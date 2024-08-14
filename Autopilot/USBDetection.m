function USBDetection
% List of potential commands to identify the device
commands = {'ID?'};

% Detect available serial ports
info = instrhwinfo('serial');
availablePorts = info.AvailableSerialPorts;

if isempty(availablePorts)
    disp('No COM ports detected.');
else
    disp('Available COM Ports:');
    disp(availablePorts);

    % Iterate over each available COM port
    for i = 1:length(availablePorts)
        portName = availablePorts{i};
        try
            % Create and configure serial object
            serialObj = serial(portName, 'BaudRate', 9600, 'Terminator', 'LF', 'Timeout', 2);

            % Open the serial port
            fopen(serialObj);

            % Initialize variables for waiting
            timeout = 10;  % Timeout period in seconds
            startTime = tic;
            response = '';

            % Continuously send ID? until the correct response is received or timeout
            while true
                % Send the ID? command
                cmd = commands{1};
                fprintf(serialObj, cmd);
                disp(['Sent: ', cmd]);

                % Wait for the response
                pause(1); % Wait 1 second between sending commands

                % Check if there is a response
                if serialObj.BytesAvailable > 0
                    response = fscanf(serialObj);
                    disp(['Received: ', response]);
                end

                % Check if the response matches 'OpenScale'
                if contains(response, 'OpenScale')
                    disp(['Correct response received on ', portName, ': ', response]);
                    scalePort = portName;
                    disp (['scale:' portName])
                    break;  % Exit the loop if the expected response is received
                end

                if contains(response, 'RFID')
                    disp(['Correct response received on ', portName, ': ', response]);
                    arduino = portName;
                    disp (['arduino:' portName])
                    break;  % Exit the loop if the expected response is received
                end

                % Check if the timeout period has been exceeded
                elapsedTime = toc(startTime);
                if elapsedTime > timeout
                    disp(['Timeout exceeded on ', portName]);
                    break;  % Exit the loop if the timeout is exceeded
                end
            end

            % Close the serial port
            fclose(serialObj);
            delete(serialObj);
            clear serialObj;
        catch ME
            % Handle any errors (e.g., port already in use)
            disp(['Error with port ', portName, ': ', ME.message]);
            if exist('serialObj', 'var')
                fclose(serialObj);
                delete(serialObj);
                clear serialObj;
            end
        end
    end
end
end
