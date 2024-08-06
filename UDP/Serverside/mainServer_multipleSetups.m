% function to set the UPD connection and listen and send
%% IP configuration
if ispc
    % This block of code will only execute if the operating system is Windows
    [status, cmdout] = system('ipconfig');
    expr = 'IPv4 Address[. ]+: ([\d.]+)';
    tokens = regexp(cmdout, expr, 'tokens');
    
    if ~isempty(tokens)
        localIP = tokens{1}{1};
         localPort = 5002;  % The IP address of B pc (server PC)
        disp(['Local IP Address: ', localIP]);
        app.LocalIPTextArea.Value = char(localIP);
    else
        disp('Could not find local IP address.');
        errordlg('Could not find local IP address.');
    end
end
%% create the udp connection
u  = udppport("datagram","LocalHost",localIP, "LocalPort", localPort);
% Configure the callback to trigger on datagram reception
configureCallback(u, "datagram", 10,@processDatagram);


%% Listen to setups
while true
    % Check if there are datagrams available to process
    if u.NumDatagramsAvailable > 0
        % Process incoming datagrams by triggering the callback function
        [paradigm, setting , subjectID] = processDatagram(u, []);
        if paradigm
            message = sprintf('%s,%s,%s', paradigm, setting, num2str(subjectID));
            write(u,message,"char",info.Address,info.port);
            fprintf("sent...\n");
            clear paradigm;
            clear setting_name;
            clear subjectID;
            clear info;
        end
        pause(1);
    end
end



%% set the callback function
% Function to process received datagrams
function [paradigm, setting , subjectID,info] = processDatagram(u, ~)
    paradigm = '';
    setting ='';
    subjectID = '';
    [data,info] = read(u,15,"uint8");  % Read the received datagram
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
    disp(subjectID);
    %setting_path = char(subject_directory{1,1});
    
    % read the paradigm assigned to this ID
    setting_path = 'C:\Users\yousefi.BIOLOGIE2\Desktop\Project\HeadFixedSetup\UDPCodes';
    filename = [num2str(subjectID), '.xlsx'];
    fullfilePath = fullfile(setting_path, filename);
    fileInfo = dir(fullfilePath);
    
    %if isempty(fileInfo)
    %fprintf('The file %s does not exist in the directory %s.\n', filename, fileInfo);
    %else
    %fprintf('The file %s exists in the directory %s.\n', filename, fileInfo);

    % read the paradigm from the excel file
    data = readtable(fullfilePath); 
    data.date(length(data.date)+1,:)= {datetime('now', 'Format', 'yyyy-MM-dd')};
    data.weight(length(data.date)+1,:)= string(weight);
    
    setting = char(data.setting(1,1));
    paradigm = char(data.paradigm(1,1));
    % Check if the cell value is a string (name)
    
    
    % Display the results
    fprintf('%s\n%s\n', ID, weight);
end