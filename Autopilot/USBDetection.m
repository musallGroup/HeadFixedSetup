function serial_obj = USBDetection(name)
    % Check if the 'name' argument is provided
    if nargin < 1
        error('The function requires the input argument "name".');
    end

    % List all available serial ports and display them
    display_all_ports();

    % Get a list of all available serial ports
    ports_found = serialportlist("available");

    for i = 1:length(ports_found)
        try
            % Open the serial port
            serial_obj = open_serial(ports_found{i}, 9600);
            name_returned = read_module_name(serial_obj);

            if strcmp(name, name_returned)
                return;
            else
                clear serial_obj;
            end
        catch ME
            disp(ME.message);
            disp(ports_found{i});
        end
    end

    error([name, ' Microcontroller NOT FOUND!']);
end

function display_all_ports()
    % Get a list of all available serial ports
    ports = serialportlist("available");

    % Display each port name
    if isempty(ports)
        disp('No available serial ports found.');
    else
        disp('Available serial ports:');
        for i = 1:length(ports)
            disp(ports{i});
        end
    end
end

function name = read_module_name(serial_obj)
    flush(serial_obj); % Flush the serial buffer
    pause(0.2); % Delay needed for some devices (like ESP32)

    % Send the command to request module information
    send_byte_alone(serial_obj, 255);
    pause(0.05);

    % Ignore the first 5 bytes
    read(serial_obj, 5, 'uint8');

    % Read name length
    name_length = read(serial_obj, 1, 'uint8');

    % Read the name
    name = char(read(serial_obj, name_length, 'uint8'));

    % Read the last 0 byte
    read(serial_obj, 1, 'uint8');
end

function [serialID, hallway_pos] = read_module_serialID(serial_obj)
    % Read position of RFID reader in hallway
    hallway_pos = read(serial_obj, 1, 'uint8');

    % Read ID length
    id_length = read(serial_obj, 1, 'uint8');

    % Read the serial ID
    serialID = char(read(serial_obj, id_length, 'uint8'));

    % Read the last 0 byte
    read(serial_obj, 1, 'uint8');
end

function serial_obj = open_serial(COM_port, baudrate)
    serial_obj = serialport(COM_port, baudrate, 'Timeout', 0);

    % Try to close previous connection in case there was an error
    if isvalid(serial_obj)
        clear serial_obj;
    end
    serial_obj = serialport(COM_port, baudrate, 'Timeout', 0);
end

function send_byte_alone(serial_obj, header_byte)
    write(serial_obj, header_byte, 'uint8');
end

function send_dec_values(serial_obj, header_byte, values)
    % Convert values to char and calculate lengths
    value_str = arrayfun(@num2str, values, 'UniformOutput', false);
    value_lengths = cellfun(@length, value_str);

    % Flatten value_str into a single string
    temp_str = strjoin(value_str, '');

    % Write the header, lengths, and the concatenated string
    write(serial_obj, [header_byte, value_lengths, uint8(temp_str)], 'uint8');
end

function send_data_until_confirmation(serial_obj, header_byte, data)
    while true
        flush(serial_obj); % Flush the serial buffer

        % Start Trial
        if isempty(data)
            send_byte_alone(serial_obj, header_byte);
        else
            send_dec_values(serial_obj, header_byte, data);
        end
        st = tic;

        received = false;
        while toc(st) < 0.2
            if serial_obj.NumBytesAvailable > 0
                input_byte = read(serial_obj, 1, 'uint8');

                if input_byte == 14
                    % Successful receipt
                    flush(serial_obj); % Flush the serial buffer
                    received = true;
                    break;
                elseif input_byte == 15
                    % Resend
                    flush(serial_obj); % Flush the serial buffer
                    break;
                end
            end
        end

        if received
            break;
        end
    end
end

function [input_byte, received] = wait_for_signal_byte(serial_obj, target_bytes, timeout)
    if nargin < 3
        timeout = 0;
    end
    active_timeout = timeout >= 0;
    received = false;
    input_byte = -1;
    st = tic;
    while true
        if serial_obj.NumBytesAvailable > 0
            input_byte = read(serial_obj, 1, 'uint8');
            if any(input_byte == target_bytes)
                received = true;
                write(serial_obj, 14, 'uint8'); % Send acknowledgment
                break;
            else
                flush(serial_obj); % Flush the serial buffer
            end
        end

        if active_timeout && toc(st) >= timeout
            break;
        end
    end
end

function port_name = find_teensy_port()
    % Get a list of all available serial ports
    ports = serialportlist("available");

    for i = 1:length(ports)
        try
            % Open the serial port
            serial_obj = open_serial(ports{i}, 9600);
            pause(2); % Allow some time for Teensy to start up
            
            % Send a command to Teensy
            write(serial_obj, 'identify', 'char');
            
            % Read the response from Teensy
            response = readline(serial_obj);
            
            % Check if the response indicates a Teensy device
            if contains(response, "Teensy")
                port_name = ports{i};
                clear serial_obj;
                return;
            end
        catch
            % Ignore errors and move on to the next port
        end
    end
    port_name = '';
end

function bytes_from_teensy = receive_bytes_from_teensy(port_name, baud_rate)
    try
        % Open serial port
        serial_obj = open_serial(port_name, baud_rate);
        
        % Wait for data to be available
        while serial_obj.NumBytesAvailable == 0
            pause(0.1);
        end
        
        % Read the ID from Teensy
        bytes_from_teensy = readline(serial_obj);
    catch ME
        disp("Serial port error: " + ME.message);
        bytes_from_teensy = '';
    end
end
