# This file was originally created for the "Visuotactile Evidence accumulation task" project, by Gerion Nabbefeld.
# We now reuse these function to realize the Serial-communication with the Tocuhscreen Chamber in the
# autonomous TouchscreenChamber-HomeCageSystem Project. This code is released under the "CC BY-NC-SA" LICENSE.
# Copyright 2024 by Gerion Nabbefeld, Department for Neurophysiology at RWTH Aachen University.
import serial
from time import time, sleep
from serial.tools import list_ports


MODULE_INFO = 255  # returns module information


def search_for_microcontroller_by_name(name):
    ports_found = list_ports.comports()
    for port in ports_found:
        print(port)
        if port == "COM8": #hack for now,todo: check how to fix this and find even if multiple usb is connected
            try:
                serial_obj = open_serial(port.device, baudrate=9600)
                name_returned = read_module_name(serial_obj)
                if name == name_returned:
                    print("here")
                    return serial_obj
                else:
                    serial_obj.close()
                #
            except Exception as e:
                print(e)
                print(port)
                pass
            #
        #

            raise Exception(name + ' Microcontroller NOT FOUND!')
#


def read_module_name(serial_obj):
    serial_obj.read_all()  # flush Serial
    sleep(0.2)  # for some reason we need a 200ms delay for the ESP32

    # Ask the COM device to identify itself
    _send_byte_alone(serial_obj=serial_obj, header_byte=MODULE_INFO)
    sleep(0.05)

    # Ignore the first 5, they are part of the protocol but not relevant here
    _ = serial_obj.read(size=5)

    # read name length
    name_length = int.from_bytes(serial_obj.read(size=1), byteorder='big')

    # read name
    name = serial_obj.read(size=name_length)

    # read last 0 byte
    serial_obj.read(size=1)
    print(name)
    return name.decode()
#


def open_serial(COM_port, baudrate=9600):
    serial_obj = serial.Serial(COM_port, baudrate, serial.EIGHTBITS, serial.PARITY_NONE, serial.STOPBITS_ONE, timeout=0)
    # try to close previous connection in case there was an error.
    try:
        serial_obj.close()
    except:
        pass
    #
    serial_obj.open()

    return serial_obj
#


def _send_byte_alone(serial_obj, header_byte):
    serial_obj.write(bytes([header_byte]))
#



def _send_dec_values(serial_obj, header_byte, values):
    # IMPORTANT!!!
    # before I was sending each byte individually for simplicity.
    # PROBLEM: If not read by the teensy it stops transmitting after 12 bytes.
    # 1. It turns out, that the USB-Serial sends Packages of 64byte.
    # 2. However, the teensy rx-buffer only holds 12 packages
    # SOLUTION: I'm converting my input into a long bytearray and send that.
    # Possible issues: If the message becomes > 64byte it might cause issues, or not.
    # The message might just be split into 2 packages. We'll see.

    char_list = [list(str(value)) for value in values]
    value_lengths = [len(value) for value in char_list]

    temp_str = ''
    for element in char_list:
        for c in element:
            temp_str += c
        #
    #
    serial_obj.write(bytes(chr(header_byte), 'ascii') + bytearray(value_lengths) + temp_str.encode())
#


def send_data_until_confirmation(serial_obj, header_byte, data=None):
    # header_byte:
    # START_TRIAL = 70

    while True:
        serial_obj.read_all()  # flush Serial

        # Start Trial
        if data is None:
            _send_byte_alone(serial_obj, header_byte)
        else:
            _send_dec_values(serial_obj, header_byte, data)
        #
        st = time()

        received = False
        while time() - st < 0.2:
            # input_byte = s.readline().decode().rstrip()
            if serial_obj.in_waiting:
                # input_byte = serial_obj.read().decode().rstrip()
                input_byte = int.from_bytes(serial_obj.read(size=1), byteorder='big')

                if input_byte == 14:
                    # got byte
                    # print('GOT BYTE')
                    serial_obj.read_all()  # flush Serial
                    received = True
                    break
                #

                if input_byte == 15:
                    # resend
                    # print('DID ABORT')
                    serial_obj.read_all()  # flush Serial
                    break
                #
            #
        #

        if received:
            # successful
            break
        #
    #
#
def find_teensy_port():
    # Get a list of all available serial ports
    ports = serial.tools.list_ports.comports()

    # Iterate through each port
    for port in ports:
        try:
            # Open the port
            with serial.Serial(port.device, 9600, timeout=1) as ser:
                # Allow some time for Teensy to start up
                #time.sleep(2)
                sleep(2)
                # Send a command to Teensy
                ser.write(b'identify\n')

                # Read the response from Teensy
                response = ser.readline().decode().strip()

                # Check if the response indicates a Teensy device
                if response.startswith("Teensy"):
                    return port.device
        except serial.SerialException:
            pass

    return None

def wait_for_signal_byte(serial_obj, target_bytes, timeout=0):
    # timeout = 0: don't wait, just check if the Byte is there or not and return
    active_timeout = timeout >= 0
    received = False
    input_byte = -1
    st = time()
    while True:
        # serial_obj.read_until(bytes(target_chr, 'ascii'), size=1)
        # input_byte = s.readline().decode().rstrip()
        if serial_obj.in_waiting:
            input_byte = int.from_bytes(serial_obj.read(size=1), byteorder='big')
            try:
                if input_byte in target_bytes:
                    received = True

                    serial_obj.write(bytes(chr(14), 'ascii'))
                    # print('Send: GOT_BYTE')
                    # serial_obj.read_all()  # flush Serial

                    break
                else:
                    # print("Unexpected Byte: %d, %f" % (input_byte, time() - t))
                    # serial_obj.write(bytes(chr(14), 'ascii'))
                    serial_obj.read_all()  # flush Serial
                #
            except Exception as e:
                print(e)
            #
        #

        if active_timeout:
            if time() - st >= timeout:
                break
            #
        #
    #

    return input_byte, received
#
def receive_bytes_from_teensy(port_name, baud_rate=9600):
    try:
        # Open serial port
        with serial.Serial(port_name, baud_rate, timeout=1) as ser:
            # Wait for data to be available
            while ser.in_waiting == 0:
                pass

            # Read the ID from Teensy
            bytes_from_teensy = ser.readline().strip().decode('utf-8')
            return bytes_from_teensy
    except serial.SerialException as e:
        print("Serial port error:", e)
        return None



### FATEMEH ##
def receive_bytes_from_teensy_continusely(port_name, baud_rate=9600):
    try:
        # Open serial port
        with serial.Serial(port_name, baud_rate, timeout=1) as ser:
            # Loop indefinitely to continuously receive bytes
            while True:
                # Check if data is available
                if ser.in_waiting > 0:
                    # Read the bytes from Teensy
                    bytes_from_teensy = ser.readline().strip().decode('utf-8')
                    print("Received:", bytes_from_teensy)
    except serial.SerialException as e:
        print("Serial port error:", e)


def send_char_command(ser, command):
    try:
        ser.write(command.encode())
        print("Sent:", command)
    except serial.SerialException as e:
        print("Serial port error:", e)


def listen_until_last_comma(port_name, baud_rate=9600):
    try:
        # Open serial port
        with serial.Serial(port_name, baud_rate, timeout=1) as ser:
            # Initialize a variable to store the received message
            received_message = ""
            received_str = ""
            while True:
                # Check if data is available
                if ser.in_waiting > 0:
                    # Read the bytes from the serial port
                    bytes_from_port = ser.readline().decode('utf-8').strip()
                    print("Received:", bytes_from_port)
                    # Append the received bytes to the message
                    received_message += bytes_from_port
                    # Store the last received string
                    received_str = bytes_from_port
                    # Check if the received message contains the last comma
                    if ',' in bytes_from_port:
                        # If it does, check if it's the end of the message
                        if bytes_from_port.endswith(','):
                            # If it is, ask the user if they want to request a new read
                            user_input = input("Do you want to request a new read? Press 'r' if you want to receive a new read: ").strip().lower()
                            if user_input == 'r':
                                send_char_command(ser, user_input)
                            received_message = ""
                        else:
                            # If it's not the end of the message, continue listening
                            continue
    except serial.SerialException as e:
        print("Serial port error:", e)
