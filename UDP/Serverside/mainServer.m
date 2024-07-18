% function to set the UPD connection and listen and send
% IP configuration
remoteIP = '134.130.63.116'; remotePort = 5001; % The IP address of A pc (behavioral PC)
localIP =  '134.130.63.141';  localPort = 5002;  % The IP address of B pc (server PC)
    
% set up the udp connection 
u = udpport("datagram","LocalHost",localIP, "LocalPort", localPort);
% Configure the callback to trigger on datagram reception
configureCallback(u, "datagram", 10,@processDatagram);


while true
        % Check if there are datagrams available to process
        if u.NumDatagramsAvailable > 0
            % Process incoming datagrams by triggering the callback function
            paradigm = processDatagram(u, []);
            if paradigm
               write(u,paradigm,"char",remoteIP,remotePort);
               fprintf("sent...\n");
               clear paradigm;
            end
            pause(1);
        end
end



% set the callback function
% Function to process received datagrams
function [paradigm, setting, subjectID] = processDatagram(u, ~)
    paradigm = '';
    data = read(u,15,"uint8");  % Read the received datagram
    fprintf("received...\n");
    receive_bytes = data.Data;  % Convert to 32-bit binary string
    received_str = char(receive_bytes);
    
    % Extract ID and weight from binary representation
    splited=split(received_str,",");
    ID = splited{1,1};
    weight = splited{2,1};
    
    % Extract the sibject ID
    base_path = 'C:\Users\yousefi.BIOLOGIE2\Desktop\Project\HeadFixedSetup\UDPCodes';
    IDconverter_file = 'IDConvertor.xlsx';
    IDconverter_path = fullfile(base_path,IDconverter_file);
    IDconverter = readtable(IDconverter_path);
    idx = find(strcmp(IDconverter.ID,ID)); %index
    subjectID = IDconverter.Subject_ID(idx);
    setting_path = char(subject_directory{1,1});
    
    % read the paradigm assigned to this ID
    filename = [subjectID, '.xlsx'];
    fullfilePath = fullfile(setting_path, filename);
    fileInfo = dir(fullfilePath);
    
    if isempty(fileInfo)
    fprintf('The file %s does not exist in the directory %s.\n', filename, directory);
    else
    fprintf('The file %s exists in the directory %s.\n', filename, directory);

    % read the paradigm from the excel file
    data = readtable(fullfilePath); 
    data.date(length(data.date)+1,:)= {datetime('now', 'Format', 'yyyy-MM-dd')};
    data.weight(length(data.date)+1,:)= weight;
    paradigm = char(data.paradigm);
    % Check if the cell value is a string (name)
    end
    
    % Display the results
    fprintf('%s\n%s\n', ID, weight);
end