%% Function to find the table
function [fullfilePath] = GetPath(subjectID)
setting_path = 'C:\Users\yousefi\Desktop\Projects\HeadFixedSetup\UDPCodes';
filename = [num2str(subjectID), '.xlsx'];
fullfilePath = fullfile(setting_path, filename);
end