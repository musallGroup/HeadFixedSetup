
%% catch the IP
% For Windows:
if ispc
    [status, cmdout] = system('ipconfig');
    expr = 'IPv4 Address[. ]+: ([\d.]+)';
end
% Extract the IP address using a regular expression
tokens = regexp(cmdout, expr, 'tokens');
localIP = tokens{1}{1};
% Display the local IP address
disp(['Local IP Address: ', localIP]);
app.LocalIPTextArea.Value = char(localIP);
% Replace 'hostname' with the actual hostname of the target PC
hostname = 'CMP0357';
% Use the 'ping' command to resolve the hostname to an IP address
[status, cmdout] = system(['ping -n 1 ', hostname]);
% Extract the IP address using a regular expression
expr = '\[([\d.]+)\]';
tokens = regexp(cmdout, expr, 'tokens');
if ~isempty(tokens)
    ipAddress = tokens{1}{1};
    % Display the IP address
    disp(['IP Address of ', hostname, ': ', ipAddress]);
    app.ServerIPTextArea.Value = ipAddress;
else
    disp(['Could not resolve IP address for ', hostname]);
    errordlg('The server could not be reached. Use the manual mode!');
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

%% function to send info via udp
function [paradigm, setting , subjectID] = sendUDP(~,rfid, weight, remoteIP, remotePort ,localIP,localPort)
paradigm = '';
setting = '';
subjectID = '';

% set up the udp connection
u = udpport("datagram","LocalHost",localIP, "LocalPort", localPort);

% Prepare the message
message = sprintf('%s,%s', rfid, weight);
disp(message);

% Send the message
write(u, message, remoteIP, remotePort);
while ~u.NumDatagramsAvailable
    drawnow; % Allow MATLAB to process callbacks and graphics updates
end
if u.NumDatagramsAvailable > 0
    data = read(u,1,"uint8");  % Read the received datagram
    pause(1);
    fprintf("received...\n");
    receive_bytes = char(data.Data);  % Convert to 32-bit binary string


    splited=split(receive_bytes,",");
    paradigm = char(splited{1,1});
    disp(paradigm)
    setting = char(splited{2,1});
    disp(setting)
    subjectID = char(splited{3,1});
    disp(subjectID)

end


% Close the UDP connection
flush(u,"output");
%
clear u;
end