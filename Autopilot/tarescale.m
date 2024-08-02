% Setup scale serial connections
scalePort = 'COM10';  % Change as necessary
scaleSerial = serialport(scalePort, 9600);

flush(scaleSerial);
fopen(scaleSerial);

%skip unnecessary lines
flag_skip_lines = 0;
while flag_skip_lines < 3
    data = readline(scaleSerial);
    flag_skip_lines = flag_skip_lines + 1;
    response = fscanf(scaleSerial);
    disp(response)
    disp(flag_skip_lines)

end


%for i = 1:20
cmd = 'x';
fprintf(scaleSerial, cmd);



% Wait for the response
flag_skip_lines = 0;
while flag_skip_lines < 20
    data = readline(scaleSerial);
    flag_skip_lines = flag_skip_lines + 1;
    response = fscanf(scaleSerial);
    disp(response)
    disp(flag_skip_lines)
end



tare = '1';
fprintf(scaleSerial, tare);

flag_skip_lines = 0;

while flag_skip_lines < 20
    data = readline(scaleSerial);
    flag_skip_lines = flag_skip_lines + 1;
    response = fscanf(scaleSerial);
    disp(response)
    disp(flag_skip_lines)
end



% Close the serial port
fclose(scaleSerial);
delete(scaleSerial);
clear scaleSerial;