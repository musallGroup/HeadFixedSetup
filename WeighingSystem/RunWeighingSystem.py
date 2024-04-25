from WeighingSystem import WeighingSystem


# Define the callback function separately
def handle_message(message):
    parts = message.split(',')
    if len(parts) > 1:  # Check if there are at least two parts
        second_part = parts[1].strip() #todo: save this value to the excel or server file
        print("Exact value:", second_part)
    # else:
    #     print("Received message does not contain enough parts to extract the second part")



port_name = 'COM4'
baud_rate = 9600
listener = WeighingSystem(port_name, baud_rate)
listener.set_callback(handle_message) # make the object self.callback as true
listener.listen_until_last_comma()
