# -*- coding: utf-8 -*-
"""
Created on Tue April 23 21:37:10 2024

@author: F.yousefi

Logic of this script:

The idea is:
 1-connect the openscale directly to the PC
 2- We have a defined class named WeighingSystem
 3- run the script RunWeighingSystem
 4- it will run the system
 5-after showing the first read it waits until user send the request to read next value (For now the char that user needs to send for the next report is "" )

"""

#todo:try to find the port autmatically
#todo:we can combine this code with the RFID reader which means as long as it detect the tag-ID then read the value from the OpenScale


import serial.tools.list_ports
import serial

class WeighingSystem:


    def __init__(self, port_name, baud_rate=9600):
        self.port_name = port_name
        self.baud_rate = baud_rate
        self.callback = None

    def set_callback(self, callback):
        self.callback = callback

    def send_command(self, command):
        try:
            with serial.Serial(self.port_name, self.baud_rate, timeout=1) as ser:
                ser.write(command.encode())
                print("Sent:", command)
        except serial.SerialException as e:
            print("Serial port error:", e)

    def listen_until_last_comma(self):
        try:
            with serial.Serial(self.port_name, self.baud_rate, timeout=1) as ser:
                received_message = ""
                while True:
                    if ser.in_waiting > 0:
                        bytes_from_port = ser.readline().decode('utf-8').strip()
                        print("Received:", bytes_from_port)
                        received_message += bytes_from_port
                        if ',' in bytes_from_port and bytes_from_port.endswith(','):
                            if self.callback:
                                self.callback(received_message)
                            received_message = ""
                            user_input = input("Do you want to request a new read? Press 'r' if you want to receive a new read: ").strip().lower()
                            if user_input == 'r':
                                self.send_command(user_input)
                        else:
                            continue
        except serial.SerialException as e:
            print("Serial port error:", e)




# Define the callback function separately
def handle_message(message):
    parts = message.split(',')
    if len(parts) > 1:  # Check if there are at least two parts
        second_part = parts[1].strip() #todo: save this value to the excel or server file
        print("Exact value:", second_part)
    # else:
    #     print("Received message does not contain enough parts to extract the second part")



port_name = 'COM5'
baud_rate = 9600
listener = WeighingSystem(port_name, baud_rate)
listener.set_callback(handle_message) # make the object self.callback as true
listener.listen_until_last_comma()







