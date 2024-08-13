function list_usb_devices()
    % Get a list of all available serial ports
    ports_found = serialportlist("available");

    if isempty(ports_found)
        disp('No available serial ports found.');
        return;
    end

    disp('Available serial ports and their device names:');
    for i = 1:length(ports_found)
        try
            % Open the serial port
            serial_obj = open_serial(ports_found{i}, 9600);
            
            % Query the device for its name
            device_name = read_device_name(serial_obj);
            
            % Display the port and device name
            fprintf('Port: %s, Device Name: %s\n', ports_found{i}, device_name);
            
            % Close the serial port
            clear serial_obj;
        catch ME
            % Display error message if any issues occur
            fprintf('Port: %s, Error: %s\n', ports_found{i}, ME.message);
        end
    end
end

function serial_obj = open_serial(COM_port, baudrate)
    % Open a serial port with the specified baud rate
    serial_obj = serialport(COM_port, baudrate, 'Timeout', 1);
end

function device_name = read_device_name(serial_obj)
    % Flush the serial buffer
    flush(serial_obj);

    % Send a command to request the device name
    % Adjust this command according to the specific device's protocol
    write(serial_obj, uint8('ID?'), 'ID?'); % Example command for querying name

    % Wait and read the device name
    pause(0.2); % Delay to allow device response
    if serial_obj.NumBytesAvailable > 0
        device_name = char(read(serial_obj, serial_obj.NumBytesAvailable, 'uint8'));
    else
        device_name = 'Unknown';
    end
end
