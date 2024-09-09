%% process the message that we got
function [paradigm, setting , subjectID] = processDatagram(message_info, ~)
paradigm = '';
setting ='';
subjectID = '';

if isfield (message_info,'No_ID') && isequal(str2double(message_info.No_ID), 1)
    % here we write whatever should happen if there is no ID from the
    % reader
    fullfilePath = GetPath(message_info.subjectID);
    fileInfo = dir(fullfilePath);
    data = readtable(fullfilePath);
    rows = height(data);
    data.weight(rows+1,:)= string(message_info.weight);
    data.date(rows+1,:) = {string(datestr(now))};
    data.start_of_session(rows+1,:) = {string(datestr(now, 'HH:MM:SS'))};
    writetable(data, fullfilePath, 'WriteMode', 'overwrite');

    setting = char(data.setting(1,1));
    paradigm = char(data.paradigm(1,1));

else
    % Extract ID and weight from binary representation
    % splited=split(received_str,",");
    % ID = splited{1,1};
    % weight = splited{2,1};


    % Extract the sibject ID
    base_path = 'C:\Users\yousefi\Desktop\Projects\HeadFixedSetup\UDPCodes';
    IDconverter_file = 'IDConvertor.xlsx';
    IDconverter_path = fullfile(base_path,IDconverter_file);
    IDconverter = readtable(IDconverter_path);
    idx = find(strcmp(IDconverter.ID,ID)); %index
    message_info.subjectID = IDconverter.Subject_ID(idx);
    disp(subjectID);
    %setting_path = char(subject_directory{1,1});

    % read the paradigm assigned to this ID
    fullfilePath = GetPath(message_info.subjectID);
    fileInfo = dir(fullfilePath);
    data = readtable(fullfilePath);
    % read the paradigm from the excel file
    rows = height(data);
    data.weight(rows+1,:)= string(message_info.weight);
    data.date(rows+1,:) = {string(datestr(now))};
    data.start_of_session(rows+1,:) = {string(datestr(now, 'HH:MM:SS'))};
    writetable(data, fullfilePath, 'WriteMode', 'overwrite');

    setting = char(data.setting(1,1));
    paradigm = char(data.paradigm(1,1));
    % Check if the cell value is a string (name)

end
% Display the results
fprintf('%s\n%s\n',paradigm , setting);
end