% Main script to handle RFID reader and scale
%clear; clc;


function listen_to_rfid()
    try
        % Configure the serial connection to the Arduino RFID reader
        % Replace 'COM7' with the correct COM port
        arduino = serialport('COM7', 9600);%;, 'Timeout', 0.1);
fopen(arduino);
        % Wait for RFID data
        disp('Listening for RFID data...');
        while true
            data = fscanf(arduino);
            disp(data);
            if ~isempty(data)
                rfid_data = data;
                fprintf('Received RFID ID: %s\n', rfid_data);
            end
            pause(0.5);
        end
    catch e
        disp(['Serial exception: ', e.message]);
    end
end







% % Initialize variables
% rfidData = '';
% % weightData = [];
% 
% 
% 
% % Setup serial connections
% rfidPort = 'COM7';  % Change as necessary
% % scalePort = 'COM8';  % Change as necessary
% 
% rfidSerial = serialport(rfidPort, 9600);
% configureTerminator(rfidSerial, "CR/LF");
% % scaleSerial = serialport(scalePort, 9600);
% % configureTerminator(scaleSerial, "CR/LF");
% % 
% 
% 
% 
% % Callback function to handle RFID data
% while true
% global BpodSystem;
%     data = readline(rfidSerial);
%     if ~isempty(data)
%         rfidData = data;
%         disp(['Received RFID ID: ', rfidData]);
%         BpodSystem.GUIData.rfidData = rfidData;       
%     end
% end

% % Callback function to handle scale data
% function scaleCallback(src, ~)
% global BpodSystem;
% data = readline(src);
%     if ~isempty(data)
%         % Extract weight from the data (modify regex as per the data format)
%         weightMatch = regexp(data, '\d+,(\d+\.\d+),\w+,\d+\.\d+,', 'tokens');
%         if ~isempty(weightMatch)
%             weight = str2double(weightMatch{1}{1});
%             weightData = [weightData, weight];
%             disp(['Collected weight: ', num2str(weight)]);
%             if length(weightData) == 10
%                 % Calculate mean weight
%                 meanWeight = mean(weightData);
%                 disp(['Calculated mean weight: ', num2str(meanWeight)]);
%                 % Update the app's WeightTextArea
%                 BpodSystem.GUIData.meanData = meanWeight;
% 
%                 weightData = [];  % Reset weight data
%             end
%         end
%     end
% end
