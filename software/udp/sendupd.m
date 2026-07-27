function protocol = sendupd(rfid, weight, remoteIP, remotePort ,localIP,localPort)
protocol = '';
% set up the udp connection
u = udpport("datagram","LocalHost",localIP, "LocalPort", localPort);

% Prepare the message
message = sprintf(rfid, weight);

% Send the message
write(u, message, remoteIP, remotePort);
pause(50);

if u.NumDatagramsAvailable > 0
    data = read(u,15,"uint8");  % Read the received datagram
    pause(30);
    fprintf("received...\n");
    receive_bytes = data.Data;  % Convert to 32-bit binary string
    protocol = char(receive_bytes);

end


% Close the UDP connection
flush(u,"output");
%
clear u;
end





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