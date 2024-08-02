% Prompt for serial settings
baudRate = input('Enter baud rate (e.g., 9600): ');
terminator = input('Enter terminator (e.g., ''LF'' for line feed, ''CR'' for carriage return): ', 's');
timeout = input('Enter timeout in seconds (e.g., 2): ');

% List of common identification commands to try
commands = {'*IDN?', 'HELLO', 'STATUS', 'ATI'};

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
            serialObj = serial(portName, 'BaudRate', baudRate, 'Terminator', terminator, 'Timeout', timeout);
            
            % Open the serial port
            fopen(serialObj);
            
            % Test each command
            for j = 1:length(commands)
                cmd = commands{j};
                fprintf(serialObj, cmd);
                
                % Wait for the response
                pause(1);
                
                % Read the response
                response = fscanf(serialObj);
                
                % Display the response
                if isempty(response)
                    disp(['No response to "', cmd, '" on ', portName]);
                else
                    disp(['Response to "', cmd, '" on ', portName, ': ', response]);
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
