%% set the callback function
%Function to process received datagrams
function [message_info,mode] = Interpreter_old(udp_object,~)
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

mode = 'start_session';
if isfield(message_info,'performance')
    mode = 'end_session'
end

end