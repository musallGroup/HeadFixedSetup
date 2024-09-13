function send_perfomance(obj, ipAddress, port)
% send_perfomance Sends a MATLAB object via UDP
%     % RELEVANT DATA FOR PERFORMANCE
% function PuffyPenguin_checkPerformance
%%
modColors = [0 0 0; 0 1 0; 1 0 0.5; 1 0 0; 0.5 0.5 0; 0 0.5 1];
modLabels = {'Vision' 'Audio' 'AudioVisual' 'Tactile' 'VisuoTactile' 'AudioTactile'};
modIdx = [1 2 4 5]; %modalities to check (as identified by modlabels above)

try %make sure this doesnt cause an error
    cAnimal = BpodSystem.ProtocolSettings.SubjectName;

    cPath = [BpodSystem.ProtocolSettings.serverPath cAnimal ...
        '\PuffyPenguin\Session Data'];

    if ~exist(cPath, 'dir')
        error('Could not find server location for behavioral data.');
    end

    recs = dir(cPath);
    recs = recs([recs.isdir]);
    recs = {recs(3:end).name};

    clear perf perfTrialCnt allTrialCnt
    Cnt = 0;
    for iRecs = 1 : length(recs)
        try
            cRec = [cPath filesep recs{iRecs} filesep];
            cFile = dir([cRec '*' recs{iRecs} '.mat']);

            load([cRec cFile.name]);
            bhv = SessionData;
            if sum(bhv.Assisted) > 25
                Cnt = Cnt + 1;
                for iMods = 1 : length(modIdx)
                    allTrialCnt(iMods,Cnt) = sum(bhv.StimType == modIdx(iMods));
                    cIdx = bhv.StimType == modIdx(iMods) & bhv.Assisted & ~bhv.DidNotChoose & bhv.Modality == 1;
                    perf(iMods,Cnt) = sum(bhv.Rewarded(cIdx)) / sum(cIdx);
                    perfTrialCnt(iMods,Cnt) = sum(cIdx);
                end
            end
        end
    end
    %%
    % obj: The MATLAB object to be sent (e.g., struct, array, etc.)
    obj = '';
    if ~isempty(perf)
        obj = perf;
    else
        disp('No Performance-Data found')
    end
    % ipAddress: The IP address of the receiving machine as a string
    % For Windows:
    if ispc
        [status, cmdout] = system('ipconfig');
        expr = 'IPv4 Address[. ]+: ([\d.]+)';
    end

    % Looks up with which Server the GUI was communicating and initiates
    % the conncetion
     if exist('app.hostname.mat', 'file') == 2
        % Load the saved variable from the file
        loadedData = load('app.hostname.mat');
        hostname = loadedData.hostname;
        
        % Use the variable
        disp(['Servername ', num2str(hostname)]);
    else
        disp('No Server found');
    end


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