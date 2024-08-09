function send_perfomance(obj, ipAddress, port)
global BpodSystem
    % send_perfomance Sends a MATLAB object via UDP
    % obj: The MATLAB object to be sent (e.g., struct, array, etc.)
    obj = BpodSystem.Data;
    % ipAddress: The IP address of the receiving machine as a string
    % For Windows:
    if ispc
        [status, cmdout] = system('ipconfig');
        expr = 'IPv4 Address[. ]+: ([\d.]+)';
    end

    % Replace 'hostname' with the actual hostname of the target PC
    hostname = 'CMP0391'; 

    % Use the 'ping' command to resolve the hostname to an IP address
    [status, cmdout] = system(['ping -n 1 ', hostname]);

    % Extract the IP address using a regular expression
    expr = '\[([\d.]+)\]';
    tokens = regexp(cmdout, expr, 'tokens');

    if ~isempty(tokens)
        ipAddress = tokens{1}{1};
        % Display the IP address
        disp(['IP Address of ', hostname, ': ', ipAddress]);
    else
        disp(['Could not resolve IP address for ', hostname]);
    end
    % port: The port number on the receiving machine
    port = '5002';
    % Serialize the object
    serializedObj = getByteStreamFromArray(obj);

    % Create UDP socket
    udpSocket = udpport("datagram", "IPV4");

    % Send the serialized object via UDP
    write(udpSocket, serializedObj, "uint8", ipAddress, port);
    disp('data sent')

    % Cleanup
    clear udpSocket;
end

%     RELEVANT DATA FOR PERFORMANCE

%     for iMods = [1 4 5]
%         % detection
%         trialCnt = sum(BpodSystem.Data.Assisted & ~BpodSystem.Data.DidNotChoose & BpodSystem.Data.Modality == 1 & BpodSystem.Data.StimType == iMods);
%         totalCnt = sum(BpodSystem.Data.Assisted & BpodSystem.Data.Modality == 1 & BpodSystem.Data.StimType == iMods);
%         rewardCnt = sum(BpodSystem.Data.Rewarded & BpodSystem.Data.Assisted & ~BpodSystem.Data.DidNotChoose & BpodSystem.Data.Modality == 1 & BpodSystem.Data.StimType == iMods);
% 
%         disp(['Self performed DETECTION ' cModality{iMods} ': ' num2str(trialCnt) ' trials (' num2str(totalCnt) ' total); Performance: ' num2str(rewardCnt/trialCnt)]);
% 
%         % discrimination
%         trialCnt = sum(BpodSystem.Data.Assisted & ~BpodSystem.Data.DidNotChoose & BpodSystem.Data.Modality == 2 & BpodSystem.Data.StimType == iMods);
%         totalCnt = sum(BpodSystem.Data.Assisted & BpodSystem.Data.Modality == 2 & BpodSystem.Data.StimType == iMods);
%         rewardCnt = sum(BpodSystem.Data.Rewarded & BpodSystem.Data.Assisted & ~BpodSystem.Data.DidNotChoose & BpodSystem.Data.Modality == 2 & BpodSystem.Data.StimType == iMods);
%         disp(['Self performed DISCRIMINATION ' cModality{iMods} ': ' num2str(trialCnt) ' trials (' num2str(totalCnt) ' total); Performance: ' num2str(rewardCnt/trialCnt)]);
%     end