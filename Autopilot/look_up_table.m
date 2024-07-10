global BpodSystem % Import the global BpodSystem object

% Read the CSV file into a table
file_path = 'C:\Users\laufs\Documents\GitHub\AutoPilot\StartButton\General.xlsx';
data = readtable(file_path);

% Define the RFID value you are looking for
rfid_value = BpodSystem.GUIHandles.rfidGUI.SubjectTextArea.Value;

% Ensure the RFID value is a string
rfid_value = string(rfid_value);

% Remove the first two characters and the last character
% if strlength(rfid_value) > 2
%     rfid_value = extractBetween(rfid_value, 3, strlength(rfid_value) - 1);
% end

% Trim any leading/trailing whitespace from the RFID value
%rfid_value = strtrim(rfid_value);

% Ensure the RFID column in the table is a string for comparison
data.RFID = string(data.RFID);

% Trim any leading/trailing whitespace from the table RFID values
%data.RFID = strtrim(data.RFID);

% Debugging: Display the processed RFID value and the first few RFID values from the table
disp('Processed RFID value:');
disp(rfid_value);
disp('First few RFID values from the table:');
disp(data.RFID(1:5));

% Find the row index where the 'RFID' matches the targetRFID using strcmp
rowIndex = strcmp(data.RFID, rfid_value);

% Extract the 'ID' from the matching row
if any(rowIndex)
    targetID = data.ID(rowIndex);
    
    fprintf('The ID for RFID %s is %d.\n', rfid_value, targetID);
    targetID = string(targetID);
else
    fprintf('RFID %s not found.\n', rfid_value);
end



%Look up settings file for targetID

%Read the CSV file into a table
folder = 'C:\Users\laufs\Documents\GitHub\AutopilotNEW';
extension = '.xlsx';
file_name = [targetID, extension];
file_path = fullfile(folder, file_name);


% Read the Excel file into a table
%filepath = 'C:\Users\laufs\Documents\GitHub\AutoPilot\StartButton\1234.xlsx';
data1 = readtable(filepath);

% Ensure the Animal_ID column in the table is a string for comparison
data1.Animal_ID = string(data1.Animal_ID);

% Debugging: Display the processed Animal_ID value and the first few Animal_ID values from the table
disp('Processed Animal_ID value:');
disp(targetID);
disp('First few Animal_ID values from the table:');
disp(data1.Animal_ID);

% Find the row index where the 'Animal_ID' matches the targetID using strcmp
rowIndex = strcmp(data1.Animal_ID, targetID);

% Extract the 'Protocol' from the matching row
if any(rowIndex)
    targetProtocol = data1.Protocol{rowIndex}; % Extracting the text value from the cell
    fprintf('The Protocol for Animal ID %s is %s.\n', targetID, targetProtocol);
else
    fprintf('Animal ID %s not found.\n', targetID);
end

if any(rowIndex)
    targetSettings = data1.Settings{rowIndex}; % Extracting the text value from the cell
    fprintf('The Settings for Animal ID %s are %s.\n', targetID, targetSettings);
else
    fprintf('Animal ID %s not found.\n', targetID);
end





BpodSystem.GUIHandles.rfidGUI.SubjectTextArea.Value = targetID;
BpodSystem.GUIHandles.rfidGUI.ProtocolTextArea.Value = targetProtocol;
BpodSystem.GUIHandles.rfidGUI.SettingsTextArea.Value = targetSettings;



