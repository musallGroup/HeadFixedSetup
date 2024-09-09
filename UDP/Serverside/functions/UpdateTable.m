%% function to overwrite the info into the excel file
function [performance,stage]=UpdateTable(message_info, ~)
    fullfilePath = GetPath(message_info.subjectID);
    fileInfo = dir(fullfilePath);

    data = readtable(fullfilePath);
    rows = height(data);
    data.end_of_session(rows,:) = {string(datestr(now, 'HH:MM:SS'))};
    data.performance(rows,:) = string(message_info.performance);
    writetable(data, fullfilePath, 'WriteMode', 'overwrite');

end