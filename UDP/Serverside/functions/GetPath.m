%% Function to find the table
function [fullfilePath] = GetPath(subjectID)
setting_path = 'C:\Users\laufs\Documents\GitHub\HeadFixedSetup\UDP';
filename = [num2str(subjectID), '.xlsx'];
fullfilePath = fullfile(setting_path, filename);
end