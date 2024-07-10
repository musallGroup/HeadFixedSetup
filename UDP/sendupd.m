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