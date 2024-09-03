%% function to overwrite the info into the excel file
function [performance,stage]=UpdateTable(message_info, ~)
    fullfilePath = GetPath(message_info.subjectID);
    fileInfo = dir(fullfilePath);

    data = readtable(fullfilePath);
    rows = height(data);
    data.endsession(rows,:)= string(message_info.weight);
    data.date(rows+1,:) = {string(datestr(now))};
    writetable(data, fullfilePath, 'WriteMode', 'overwrite');




end