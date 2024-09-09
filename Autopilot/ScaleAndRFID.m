clear;
clc;

% Initialize variables
rfidData = '';
weightData = [];

% Setup serial connections
scalePort = 'COM13';  % Change as necessary
arduinoPort = 'COM7';  % Change as necessary

scaleSerial = serialport(scalePort, 9600);
flush(scaleSerial);
fopen(scaleSerial);

arduino = serialport(arduinoPort, 9600);
flush(arduino);
fopen(arduino);

disp('Listening for RFID data...');

while true
    try
        % Wait for RFID data from Arduino
        bytesAvailable = arduino.NumBytesAvailable;
        if bytesAvailable > 0
            data = read(arduino, bytesAvailable, 'char');
            disp(['Raw Data: ', data]);  % Display raw data for debugging
            if ~isempty(data)
                rfid_data = strtrim(data);
                fprintf('Received RFID ID: %s\n', rfid_data);
                rfidData = rfid_data;  % Store RFID data in a variable
                
                % Call scale function after receiving RFID data
                BpodSystem.GUIHandles.rfidGUI.WeightTextArea.Value = 'Weighing in progress...';
                scale(scaleSerial);
            end
        end
    catch ME
        % Handle errors
        warning(['Error: ', ME.message]);
    end
    pause(0.1);  % Adjust pause duration for responsiveness
end

% Close serial ports
fclose(scaleSerial);
fclose(arduino);


function scale(scaleSerial)
    global weightData;
    global BpodSystem;
    
    flag_skip_lines = 0;
    while flag_skip_lines < 8
        data = readline(scaleSerial);
        flag_skip_lines = flag_skip_lines + 1;
    end
    
    flag_10_reads = 0;
    while flag_10_reads < 10
        data = readline(scaleSerial);
        if ~isempty(data)
            % Extract weight from the data using specified regex pattern
            weightMatch = regexp(data, '\d+,-?\d+\.\d+,kg,\d+\.\d+,', 'match', 'once');
            if ~isempty(weightMatch)
                weightParts = strsplit(weightMatch, ',');
                weight = str2double(weightParts{2});
                weightData = [weightData, weight];
                disp(['Collected weight: ', num2str(weight)]);
                flag_10_reads = flag_10_reads + 1;
            else
                disp('No valid weight data found.');
            end
            
            if length(weightData) == 10
                % Calculate mean weight
                meanWeight = mean(weightData);
                disp(['Calculated mean weight: ', num2str(meanWeight)]);
                
                % Update the BpodSystem GUI data with mean weight
                BpodSystem.GUIHandles.rfidGUI.WeightTextArea.Value = meanWeight;
                
                weightData = [];  % Reset weight data
                flag_10_reads = 0;
                break;  % Exit the loop after calculating mean for 10 readings
            end
        else
            disp('Empty data received.');
        end
    end
end
