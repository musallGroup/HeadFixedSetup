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
                flush u;
        end

    end
end