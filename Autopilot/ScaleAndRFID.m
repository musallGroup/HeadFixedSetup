% Main script to handle RFID reader and scale
clear; clc;
% % Initialize variables
rfidData = '';




% Setup serial connections
%rfidPort = 'COM7';  % Change as necessary
scalePort = 'COM8';  % Change as necessary

%rfidSerial = serialport(rfidPort, 9600);
%configureTerminator(rfidSerial, "CR/LF");
scaleSerial = serialport(scalePort, 9600);
%configureTerminator(scaleSerial, "CR/LF");
%
flush(scaleSerial);
%flush(rfidSerial);
fopen(scaleSerial);
%fopen(rfidSerial);

arduino = serialport('COM7', 9600);%, 'Timeout',10);
flush(arduino);
fopen(arduino);

%%Bpod
global BpodSystem;


%try
% Configure the serial connection to the Arduino RFID reader
% Replace 'COM7' with the correct COM port

% Wait for RFID data
disp('Listening for RFID data...');

while true
    data = fscanf(arduino);
    disp(data);
    if ~isempty(data)
        rfid_data = data;
        fprintf('Received RFID ID: %s\n', rfid_data);
        BpodSystem.GUIData.rfidData = rfid_data;
        pause(0.5);
        meanweight = scaleCallback(scaleSerial);
        fprintf('Received mean wheight %s\n',meanweight);
    end


end
%catch e
%disp(['Serial exception: ', e.message]);












% % Callback function to handle RFID data
% while true
% global BpodSystem;
%     data = readline(rfidSerial);
%     if ~isempty(data)
%         rfidData = data;
%         disp(['Received RFID ID: ', rfidData]);
%         scaleCallback(scaleSerial);
%         BpodSystem.GUIData.rfidData = rfidData;
%     end
% end


% Callback function to handle scale data
function meanWeight = scaleCallback(src, ~)
weightData = [];
global BpodSystem;
flag_skip_lines = 0;
while flag_skip_lines<8
    data = readline(src);
    flag_skip_lines = flag_skip_lines+1;
end

flag_10_reads = 0;
while flag_10_reads<10
    data = readline(src);
    if ~isempty(data)
        % Extract weight from the data (modify regex as per the data format)
        weightMatch = regexp(data, '\d+,(\d+\.\d+),\w+,\d+\.\d+,', 'tokens');
        if ~isempty(weightMatch)
            weight = str2double(weightMatch{1}{1});
            weightData = [weightData, weight];
            disp(['Collected weight: ', num2str(weight)]);
            flag_10_reads = flag_10_reads+1;
        end

        
        if length(weightData) == 10
            % Calculate mean weight
            meanWeight = mean(weightData);
            disp(['Calculated mean weight: ', num2str(meanWeight)]);
            % Update the app's WeightTextArea
            BpodSystem.GUIData.meanData = meanWeight;

            weightData = [];  % Reset weight data
            flag_10_reads = 0;
            break
        end
    end
end
end

