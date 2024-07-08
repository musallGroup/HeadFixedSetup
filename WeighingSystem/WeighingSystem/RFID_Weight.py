import time
import serial
import re
import os


# Function to listen to the Arduino RFID reader
def listen_to_rfid():
    try:
        # Configure the serial connection to the Arduino RFID reader (change COM port as necessary)
        arduino = serial.Serial(port='COM7', baudrate=9600, timeout=.1)

        # Wait for RFID data
        print("Listening for RFID data...")
        while True:
            data = arduino.readline().decode('utf-8').strip()
            if data:
                rfid_data = data
                print(f"Received RFID ID: {rfid_data}")

                # Write RFID data to a text file
                rfid_file_path = r'C:\Users\laufs\Documents\GitHub\AutoPilot\StartButton\RFID_value.txt'
                with open(rfid_file_path, 'w') as rfid_file:
                    rfid_file.write(rfid_data)
                print(f"RFID value written to {rfid_file_path}")

                # Create flag file to signal MATLAB that RFID value is ready
                id_ready_file_path = r'C:\Users\laufs\Documents\GitHub\AutoPilot\StartButton\ID_ready.txt'
                with open(id_ready_file_path, 'w') as id_ready_file:
                    id_ready_file.write('ID ready')
                print(f"ID ready signal created: {id_ready_file_path}")

            time.sleep(0.5)

    except serial.SerialException as e:
        print(f"Serial exception: {e}")


# Function to listen to the scale and collect weight data
def listen_to_scale():
    try:
        # Configure the serial connection to the scale (change COM port as necessary)
        scale = serial.Serial(port='COM8', baudrate=9600, timeout=.1)

        # Collect ten values from the scale, but only process every second value
        print("Collecting weight data...")
        weight_values = []
        #count = 0
        for i in range(7):
            line = scale.readline().decode('utf-8').strip()
        while len(weight_values) < 10:
            line = scale.readline().decode('utf-8').strip()
            if line:
                weight_match = re.search(r'\d+,(\d+\.\d+),\w+,\d+\.\d+,', line)
                if weight_match:
                    weight = float(weight_match.group(1))
                    #count += 1
                    #if count % 2 == 0:
                    weight_values.append(weight)
                    print(f"Collected weight: {weight}")

        # Calculate the mean weight
        mean_weight = sum(weight_values) / len(weight_values)
        print(f"Calculated mean weight: {mean_weight}")

        # Write mean weight to a text file
        mean_file_path = r'C:\Users\laufs\Documents\GitHub\AutoPilot\StartButton\mean_value.txt'
        with open(mean_file_path, 'w') as mean_file:
            mean_file.write(f"{mean_weight:.4f}")
        print(f"Mean weight written to {mean_file_path}")

        # Create flag file to signal MATLAB that mean value is ready
        mean_ready_file_path = r'C:\Users\laufs\Documents\GitHub\AutoPilot\StartButton\mean_ready.txt'
        with open(mean_ready_file_path, 'w') as mean_ready_file:
            mean_ready_file.write('Mean ready')
        print(f"Mean ready signal created: {mean_ready_file_path}")

        # Write combined data to data.txt
        rfid_file_path = r'C:\Users\laufs\Documents\GitHub\AutoPilot\StartButton\RFID_value.txt'
        with open(rfid_file_path, 'r') as rfid_file:
            rfid_data = rfid_file.read().strip()

        data_file_path = r'C:\Users\laufs\Documents\GitHub\AutoPilot\StartButton\data.txt'
        with open(data_file_path, 'w') as data_file:
            data_file.write(rfid_data + ",")
            data_file.write(f"{mean_weight:.4f}")
        print(f"Data written to {data_file_path}")

    except serial.SerialException as e:
        print(f"Serial exception: {e}")


if __name__ == "__main__":
    # Start RFID listening thread
    from threading import Thread

    rfid_thread = Thread(target=listen_to_rfid)
    rfid_thread.daemon = True
    rfid_thread.start()

    # Main loop to wait for the start signal for weighing process
    while True:
        start_signal_path = r'C:\Users\laufs\Documents\GitHub\AutoPilot\StartButton\start_signal.txt'
        if os.path.isfile(start_signal_path):
            print("Start signal detected")
            os.remove(start_signal_path)
            listen_to_scale()
        time.sleep(0.5)
