% function to set the UPD connection and listen and send
%% IP configuration
if ispc
    % This block of code will only execute if the operating system is Windows
    [status, cmdout] = system('ipconfig');
    expr = 'IPv4 Address[. ]+: ([\d.]+)';
    tokens = regexp(cmdout, expr, 'tokens');

    if ~isempty(tokens)
        localIP = tokens{1}{1};
        disp(['Local IP Address: ', localIP]);
        app.LocalIPTextArea.Value = char(localIP);
    else
        disp('Could not find local IP address.');
        errordlg('Could not find local IP address.');
    end

    setupname = 'CMP0357';
    [status, cmdout] = system(['ping -n 1 ', setupname]);
    expr = '\[([\d.]+)\]';
    tokens = regexp(cmdout, expr, 'tokens');

    if ~isempty(tokens)
        ipAddress = tokens{1}{1};
        disp(['IP Address of ', setupname, ': ', ipAddress]);
        app.ServerIPTextArea.Value = ipAddress;
    end
end
remoteIP = ipAddress ; remotePort = 5001; % The IP address of A pc (behavioral PC)
localIP =  localIP ;  localPort = 5002;  % The IP address of B pc (server PC)
%% create the udp connection
% set up the udp connection
u = udpport("datagram","LocalHost",localIP, "LocalPort", localPort);
% Configure the callback to trigger on datagram reception
configureCallback(u, "datagram", 10,@Interpreter);








%% Listen to setups
while true
    % Check if there are datagrams available to process
    if u.NumDatagramsAvailable > 0
        % Process incoming datagrams by triggering the callback function
        [message_info,mode] = Interpreter(u,[]);
        %[paradigm, setting , subjectID] = processDatagram(u, []);
        switch mode
            case start_session
                [paradigm, setting , subjectID] = processDatagram(message_info, []);
                message = sprintf('%s,%s,%s', paradigm, setting, num2str(subjectID));
                write(u,message,"char",remoteIP,remotePort);
                fprintf("sent...\n");
                fprintf("waiting for performance...");

            case stop_session
                [performance,stage]=UpdateTable(message_info, []);
                





                clear paradigm;
                clear setting_name;
                clear subjectID;
        end

    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%--Functions--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% set the callback function
%Function to process received datagrams
function [message_info,mode] = Interpreter(udp_object,~)
data = read(u,15,"uint8");  % Read the received datagram
fprintf("received...\n");
receive_bytes = data.Data;  % Convert to 32-bit binary string
received_str = char(receive_bytes);

%pre-define the pattern
pattern = '(\w+)\s*=\s*(\S+)';
tokens = regexp(received_str, pattern, 'tokens');
%Extract values from the message
message_info = struct();
for i = 1:length(tokens)
    key = tokens{i}{1};   % Field name
    value = tokens{i}{2}; % Field value
    message_info.(key) = value;
end

mode = 'start_session'
if isfield(message_info,'performance')
    mode = 'end_session'
end

end


%% process the message that we got
function [paradigm, setting , subjectID] = processDatagram(message_info, ~)
paradigm = '';
setting ='';
subjectID = '';

if isfield (message_info,'No_ID') && isequal(message_info.No_ID, true)
    % here we write whatever should happen if there is no ID from the
    % reader
    fullfilePath = GetPath(message_info.subjectID);
    fileInfo = dir(fullfilePath);
    data = readtable(fullfilePath);
    data.weight(length(data.date)+1,:)= string(weight);
    data.date(length(data.date)+1,:)= datestr(now);
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

    % read the paradigm from the excel file
    data = readtable(fullfilePath);
    data.weight(length(data.date)+1,:)= string(weight);
    data.date(length(data.date)+1,:)= datestr(now);
    writetable(data, fullfilePath, 'WriteMode', 'overwrite');

    setting = char(data.setting(1,1));
    paradigm = char(data.paradigm(1,1));
    % Check if the cell value is a string (name)

end
% Display the results
fprintf('%s\n%s\n', ID, weight);
end
%% Function to find the table
function [fullfilePath] = GetPath(subjectID)
setting_path = 'C:\Users\yousefi\Desktop\Projects\HeadFixedSetup\UDPCodes';
filename = [num2str(subjectID), '.xlsx'];
fullfilePath = fullfile(setting_path, filename);
end

%% function to overwrite the info into the excel file
function [performance,stage]=UpdateTable(message_info, ~)
fullfilePath = GetPath(message_info.subjectID);
fileInfo = dir(fullfilePath);


end