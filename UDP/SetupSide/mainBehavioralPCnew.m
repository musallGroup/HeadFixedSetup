% Define the main script, here I am writing the bavioral PC part (A)
% Read the .txt file and load the ID and weight and send these values via
% the UDP connection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%Change IP and port bsed on your PC%%%%%%%%%%%%%%%%%
%% choose the .txt file
[filename, pathname] = uigetfile('*.txt', 'Select the data.txt file');
if isequal(filename, 0)
    disp('User selected Cancel');
else
    fullFilePath = fullfile(pathname, filename);
    
    % Read the data from the selected file
    [rfid, weight] = readTextFile(fullFilePath);

    % IP configuration
    localIP  =  '134.130.63.100'; localPort = 5001; % The IP address of A pc (behavioral PC)
    remoteIP =  '134.130.63.141';  remotePort = 5002;  % The IP address of B pc (server PC)

    % Send the data via UDP
    [paradigm, setting , subjectID] = sendUDP(rfid, weight, remoteIP, remotePort ,localIP ,localPort);
    fprintf('paradigm: %s',paradigm,'setting %s', setting, 'subjectID %s', subjectID);
    fprintf("\nDone...");
end

%% Function to read the text file
function [rfid, weight] = readTextFile(filename) %% replace this part in a way that it reads ID and weight from the Autopilot
    % Open the file
    fid = fopen(filename, 'r');
    if fid == -1
        error('File cannot be opened: %s', filename);
    end
    
    % Read the first line (RFID)
    rfid = fgetl(fid);
    
    % Read the second line (weight)
    weight = fgetl(fid);
    
    % Close the file
    fclose(fid);
    
    % Convert the weight to a number (if necessary)
    weight = str2double(weight);
end

%% Function to send data via UDP
function [paradigm, setting , subjectID] = sendUDP(rfid, weight, remoteIP, remotePort ,localIP,localPort)
    paradigm = '';
   % set up the udp connection 
    u = udpport("datagram","LocalHost",localIP, "LocalPort", localPort);
    
    % Prepare the message
    message = sprintf(rfid, weight);
    
    % Send the message
    write(u, message, remoteIP, remotePort);
    pause(50);
    
    if u.NumDatagramsAvailable > 0
        data = read(u,1,"uint8");  % Read the received datagram
        pause(30);
        fprintf("received...\n");
        receive_bytes = char(data.Data);  % Convert to 32-bit binary string
        splited=split(receive_bytes,",");
        paradigm = char(splited{1,1});
        setting = char(splited{2,1});
        subjectID = char(splited{3,1});
        
    end
    
    
    % Close the UDP connection
    flush(u,"output");
    %
   clear u;
end
