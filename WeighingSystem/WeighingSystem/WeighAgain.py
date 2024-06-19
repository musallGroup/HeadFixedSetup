import time
import serial
import re
import os

# Function to listen to the Arduino RFID reader and the scale
def listen_to_devices():
    try:
        # Configure the serial connection to the scale (change COM port as necessary)
        scale = serial.Serial(port='COM8', baudrate=9600, timeout=.1)

        # Collect ten values from the scale, but only process every second value
        print("Collecting weight data...")
        weight_values = []
        count = 0
        for i in range(7):
            line = scale.readline().decode('utf-8').strip()
        while len(weight_values) < 10:
            line = scale.readline().decode('utf-8').strip()
            if line:
                weight_match = re.search(r'\d+,(\d+\.\d+),\w+,\d+\.\d+,', line)
                if weight_match:
                    weight = float(weight_match.group(1))
                    count += 1
                    if count % 2 == 0:
                        weight_values.append(weight)
                        print(f"Collected weight: {weight}")

        # Calculate the mean weight
        mean_weight = sum(weight_values) / len(weight_values)
        print(f"Calculated mean weight: {mean_weight}")

        # Write mean weight to a text file
        mean_file_path = r'C:\Users\laufs\Desktop\AutoPilot\StartButton\mean_value.txt'
        with open(mean_file_path, 'w') as mean_file:
            mean_file.write(f"{mean_weight:.4f}")
        print(f"Mean weight written to {mean_file_path}")

        # Create flag file to signal MATLAB that mean value is ready
        mean_ready_file_path = r'C:\Users\laufs\Desktop\AutoPilot\StartButton\mean_ready.txt'
        with open(mean_ready_file_path, 'w') as mean_ready_file:
            mean_ready_file.write('Mean ready')
        print(f"Mean ready signal created: {mean_ready_file_path}")

    except serial.SerialException as e:
        print(f"Serial exception: {e}")

if __name__ == "__main__":
    # Main loop to wait for the start signal
    while True:
        start_signal_path = r'C:\Users\laufs\Desktop\AutoPilot\StartButton\weigh_signal.txt'
        if os.path.isfile(start_signal_path):
            print("Start signal detected")
            os.remove(start_signal_path)
            listen_to_devices()
        time.sleep(0.5)
