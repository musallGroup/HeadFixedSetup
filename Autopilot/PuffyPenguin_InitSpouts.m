% Initialization of Bpod modules and VIDEO AQUISITION
% BPod Init
BpodSystem.ProtocolSettings.triggerScanbox = false;
BpodSystem.Data.byteLoss = 0; %counter for cases when the teensy didn't send a response byte
BpodSystem.SoftCodeHandlerFunction = 'PuffyPenguin_softCodeHandler';
BpodSystem.Data.Rewarded = logical([]); %needed for GUI to work in first trial
BpodSystem.Path.visualPath = [fullfile(fileparts(BpodSystem.Path.DataFolder(1:end-1)), 'visualStim', 'Stimulus_frames'),filesep];

%% Load default settings and update with pre-defined settings if required
defaultFieldParamVals = struct2cell(DefaultSettings);
defaultFieldNames = fieldnames(DefaultSettings);
BpodSystem.ProtocolSettings.ServoPos = [0 0];
S = BpodSystem.ProtocolSettings; % Load settings chosen in launch manager into current workspace as a struct S
currentFieldNames = fieldnames(S);

if isempty(fieldnames(S)) % If settings file was an empty struct, populate struct with default settings
    S = DefaultSettings;
elseif any(~ismember(defaultFieldNames,currentFieldNames))  %an addition to default settings, update
    differentI = find(~ismember(defaultFieldNames,currentFieldNames)); %find the index
    for ii = 1:numel(differentI)
        thisnewfield = defaultFieldNames{differentI(ii)};
        S.(thisnewfield)=defaultFieldParamVals{differentI(ii)};
    end
end
BpodSystem.ProtocolSettings = S; % Adds the currently used settings to the Bpod struct
% BpodSystem.ProtocolSettings.SubjectName = BpodSystem.GUIData.SubjectName; %update subject name
% serverPath = [BpodSystem.ProtocolSettings.serverPath filesep BpodSystem.ProtocolSettings.SubjectName filesep ...
%     BpodSystem.GUIData.ProtocolName]; %path to data server

% %% ensure analog output module is present and set up communication
% clear W
% 
% checkOut = PuffyPenguin_checkPort(S.wavePort, 'wavePlayer'); %check port for waveplayer module
% if checkOut
%     W = BpodWavePlayer(S.wavePort); %check if analog module com port is correct
%     fprintf('Analog output module found on port %s\n.', S.wavePort)
% 
% else
%     % check for analog module by finding a serial device that can create a waveplayer object
%     W = [];
%     Ports = FindSerialPorts; % get available serial com ports
% 
%     for i = 1 : length(Ports)
% 
%         checkOut = PuffyPenguin_checkPort(Ports{i}, 'wavePlayer'); %check port for waveplayer module
% 
%         if checkOut
%             BpodSystem.ProtocolSettings.wavePort = Ports{i};
%             W = BpodWavePlayer(Ports{i}); %check if analog module com port is correct
% 
%             fprintf('Analog output module found on port %s\n.', Ports{i})
%             break
%         end
%     end
% end
% clear cPort
% 
% 
% if isempty(W)
%     warning('No analog output module found. Session aborted.');
%     BpodSystem.Status.BeingUsed = 0;
% else
%     clear W %clear waveplayer object to make sure it uses default values
%     W = BpodWavePlayer(BpodSystem.ProtocolSettings.wavePort);
% end
% 
% W.OutputRange = '-5V:5V'; % make sure output range is correct
% W.TriggerProfileEnable = 'On'; % use trigger profiles to produce different waveforms across channels
% W.TriggerProfiles(1, :) = 1:4; %when triggering first row, ch1-4 will play waveforms 1-4
% W.TriggerMode = 'Master'; %output can be interrupted by new stimulus triggers
% W.LoopDuration(1:4) = 0; %keep on for a up to 10 minutes
% W.SamplingRate = BpodSystem.ProtocolSettings.sRate; %adjust sampling rate
% tt = -pi:2*pi*1000/(BpodSystem.ProtocolSettings.sRate*3):pi;tt=tt(1:end-1);
% RewardSound = (1+cos(tt)).*(sin(2*tt)+sin(4*tt)+sin(6*tt)+sin(8*tt)+sin(16*tt));
% RewardSound = RewardSound * 0.1;
% W.loadWaveform(11,RewardSound); % load signal to waveform object
% W.TriggerProfiles(11, 1:2) = 11; %this will play waveform 11 (rewardSound) on ch1+2

%% check for teensy module (needs no object because it only communicates through Bpod directly)
checker = true;
for i = 1 : length(BpodSystem.Modules.Name)
    if strcmpi(BpodSystem.Modules.Name{i},'TouchShaker1')
        checker = false;
    end
end
if checker
    warning('No teensy module found. Session aborted.');
    BpodSystem.Status.BeingUsed = 0;
end

% check teensy module - this does not work if not connected to the computer
teensyWrite(128); %reset teensy module first to make sure we are starting fresh
pause(1);
teensyWrite([71 1 '0' 1 '0']); % Move spouts to zero position

% setting thresholds - move to outer
disp('Teensy is setting the thresholds')
pause(0.5);
teensyWrite([71 1 '1' 1 '1']); % Move spouts to most outer position

%set touch threshold
cVal = num2str(BpodSystem.ProtocolSettings.TouchThresh);
teensyWrite([75 length(cVal) cVal]);
pause(2); %give some time for calibration
res = teensyGetTouchThresh();
ii = 0;
while isempty(res)
    res = teensyGetTouchThresh();
    ii = ii+1;
    if ii == 5
        disp('There was an error reading the thresholds from the teensy...')
        break
    end
end
BpodSystem.ProtocolSettings.capacitiveTouchThresholds = res;

%set spout speed
val = BpodSystem.ProtocolSettings.SpoutSpeed; %SpoutSpeed
teensyWrite([73 length(num2str(val)) num2str(val)]);
     
       
% %% check for analog input module
% A = [];
% % S.analogInPort = 'COM7';
% % checkOut = true;
% checkOut = PuffyPenguin_checkPort(S.analogInPort, 'analogIn'); %check port for waveplayer module
% 
% if checkOut
%     A = BpodAnalogIn(S.analogInPort); %check if analog module com port is correct
%     fprintf('Analog input module found on port %s\n.', S.analogInPort)
%     
% else
%     Ports = FindSerialPorts; % get available serial com ports
%     Ports = Ports(~strcmpi(Ports, BpodSystem.ProtocolSettings.wavePort)); %don't use output module port
% 
%     for i = 1 : length(Ports)
% 
%         checkOut = PuffyPenguin_checkPort(Ports{i}, 'analogIn'); %check port for waveplayer module
% 
%         if checkOut
%             BpodSystem.ProtocolSettings.analogInPort = Ports{i};
%             A = BpodAnalogIn(Ports{i});
% 
%             break
%         end
%     end
% end
% S = BpodSystem.ProtocolSettings; %update S
% 
% if isempty(A)
%     warning('No analog input module found. Session aborted.');
%     BpodSystem.Status.BeingUsed = 0;
% else
%     A.Thresholds = [0.1 0.1 0.02 0.02 1 1 1 1]; %set thresholds for photodiode
%     A.ResetVoltages = [0.04 0.04 0.06 0.06 0 0 0 0]; %set thresholds for reset
%     A.InputRange = {'-2.5V:2.5V'  '-2.5V:2.5V'  '-2.5V:2.5V'  '-2.5V:2.5V' '-2.5V:2.5V' '-2.5V:2.5V' '-2.5V:2.5V' '-2.5V:2.5V'};
%     A.SMeventsEnabled(1:4) = true;
%     A.startReportingEvents();
% end

%% find stim screens
%find screens
% screenNumber = Screen('Screens'); % Draw to the external screen if avaliable
% screenNumber(screenNumber == 0) = [];
% Screen('Preference', 'Verbosity', 0);
% Screen('Preference', 'SkipSyncTests',1);
% Screen('Preference', 'VisualDebugLevel',0);
% 
% for x = screenNumber
%     window = Screen('OpenWindow', x, 0); %open ptb window and save handle in pSettings
%     pause(0.1)
% 
%     for y = 1 : 2
%         Screen('FillRect', window, 255);
%         Screen('Flip', window);
%         pause(0.1)
%         Screen('FillRect', window, 0);
%         Screen('Flip', window);
%         pause(0.1)
%     end
%     sca
% end

%% check for rotary encoder module
% clear R; R = [];
% try
%     R = RotaryEncoderModule(S.rotaryEncoderPort); %check if rotary encoder module com port is correct
%     fprintf('Rotary encoder module found on port %s\n.', S.rotaryEncoderPort)
% catch
%     % check for analog module by finding a serial device that can create a waveplayer object
%     clear R; R = [];
%     Ports = FindSerialPorts; % get available serial com ports
%     Ports = Ports(~strcmpi(Ports, BpodSystem.ProtocolSettings.wavePort)); %don't use output module port
%     Ports = Ports(~strcmpi(Ports, BpodSystem.ProtocolSettings.analogInPort)); %don't use input module port
%     for i = 1 : length(Ports)
%         try
%             R = RotaryEncoderModule(Ports{i});
%             BpodSystem.ProtocolSettings.rotaryEncoderPort = Ports{i};
%             fprintf('Rotary encoder module found on port %s\n.', Ports{i})
%             break
%         end
%     end
% end
% 
% if isempty(R)
%     BpodSystem.ProtocolSettings.rotaryEncoderPort = [];
%     warning('!!! No rotary encoder module found. Wheel data will not be available in SessionData !!!');
% end
% 

%% check for ambient module
% clear AB
% try
%     AB = AmbientModule(S.ambientPort); %check if ambient module com port is correct
% catch
%     % check for analog module by finding a serial device that can create a waveplayer object
%     Ports = FindSerialPorts; % get available serial com ports
%     Ports = Ports(~strcmpi(Ports, S.wavePort)); %don't use output module port
%     Ports = Ports(~strcmpi(Ports, S.analogInPort)); %don't use input module port
%     Ports = Ports(~strcmpi(Ports, S.rotaryEncoderPort)); %don't use rotary encoder port
%     for i = 1 : length(Ports)
%         try
%             AB = AmbientModule(Ports{i});
%             AB.getMeasurements;
%             BpodSystem.ProtocolSettings.ambientPort = Ports{i};
%             break
%         catch
%             clear AB
%         end
%     end
% end
% 
% if ~exist('AB', 'var') || isempty(AB) 
%     BpodSystem.ProtocolSettings.ambientPort = [];
%     warning('!!! No ambient module found. Ambient data will not be available in SessionData !!!');
% end



%% Initialize camera, control GUI and feedback plots
% if BpodSystem.Status.BeingUsed %only run this code if protocol is still active
%     %%
%     BpodNotebook('init');
%   
%     BpodSystem.GUIHandles.PuffyPenguin = PuffyPenguin_GUI;
%     %BpodSystem.Data.animalWeight = str2double(newid('Enter animal weight (in grams)')); %ask for animal weight and save
%     BpodSystem.GUIHandles.PuffyPenguin.getSettingsFromBpod();
%     BpodSystem.GUIHandles.PuffyPenguin.init_plots();
%     
%     %move spouts to inner position
%     ls = num2str(BpodSystem.ProtocolSettings.lInnerLim);
%     rs = num2str(BpodSystem.ProtocolSettings.rInnerLim);
%     teensyWrite([71 length(ls)  ls length(rs)  rs]);
%     
%     %% check state of optoSeqactive tickbox
%     cObj = BpodSystem.GUIHandles.PuffyPenguin.optoSeqActive;
%     cCallBack = cObj.ValueChangedFcn;
%     cCallBack(cObj, []); %confirm value change in GUI to inactivate the correctfields
% 
% 	%% initialize communication with labcams to get videos
%     if isfield(BpodSystem.ProtocolSettings,'labcamsAddress')
%         if ~isempty(BpodSystem.ProtocolSettings.labcamsAddress)
%             tmp = strsplit(BpodSystem.ProtocolSettings.labcamsAddress,':');
%             udpAddress = tmp{1};
%             udpPort = str2num(tmp{2});
%             udplabcams = udp(udpAddress,udpPort);
%             udplabcams.TimeOut = 1;
%             fopen(udplabcams);
%             
%             % check if labcams is connected already and start otherwise.
%             labcamResponds = false;
%             fwrite(udplabcams,'ping'); pause(0.05);
%             if udplabcams.BytesAvailable > 0
%                 strcmpi(fgetl(udplabcams), 'pong');
%                 labcamResponds = true;
%                 disp(' -> labcams connected.');
% 
%             else
%                 %%
%                 disp(' -> starting labcams');
% 
%                 % start labcams and allow some time to come up
%                 labcamsproc = System.Diagnostics.Process.Start('labcams.exe','-w');
%                 pause(5); 
% 
%                 % try to communicate via UDP for 10 seconds
%                 tic;
%                 while toc < 10
%                     fwrite(udplabcams,'ping')
%                     if strcmpi(fgetl(udplabcams), 'pong')
%                         labcamResponds = true;
%                         break
%                     end
%                 end
%                 fclose(udplabcams);
% 
%                 % check again on default labcams address
%                 fclose(udplabcams);
%                 tmp = strsplit(DefaultSettings.labcamsAddress,':');
%                 udpAddress = tmp{1};
%                 udpPort = str2num(tmp{2});
%                 udplabcams = udp(udpAddress,udpPort);
%                 udplabcams.TimeOut = 1;
%                 fopen(udplabcams);
%                 
%                 tic;
%                 while toc < 10
%                     fwrite(udplabcams,'ping')
%                     tmp = fgetl(udplabcams);
%                     if strcmpi(tmp, 'pong')
%                         labcamResponds = true;
%                         BpodSystem.ProtocolSettings.labcamsAddress = DefaultSettings.labcamsAddress;
%                         break
%                     end
%                 end
% 
%                 if ~labcamResponds
%                     disp('Labcams is not responding. Are cameras connected and working?')
%                     clear udplabcams
%                 end
%             end
%             
%             if exist('udplabcams','var')
%                 fwrite(udplabcams,['expname=' BpodSystem.Path.CurrentDataFile])
%                 fgetl(udplabcams);
%                 fwrite(udplabcams,'manualsave=0') % Dont save while adjusting
%                 fgetl(udplabcams);
%                 fwrite(udplabcams,'softtrigger=1')
%                 fgetl(udplabcams);
%             end
%         end
%     end
% end

%% check output power from LEDs/Lasers for optogenetics
% basePath = fileparts(BpodSystem.Path.ProtocolFolder(1:end-1));
% calFile = 'OptogeneticStimPower.txt';
% calPath = fullfile(basePath, 'calibrations',calFile);
% 
% cChan = [];
% optoPower = cell(1,4);
% if exist(calPath, 'file')
%     
%     fID = fopen(calPath);
%     while true
%         cLine = fgetl(fID);
%         
%         if cLine == -1
%             fclose(fID);
%             break
%         end
%         
%         if isempty(cLine); cChan = []; pwrCnt = 0; end
%         if isempty(cChan) % check for channel - usually 3 or 4
%             if contains(cLine, 'Channel')
%                 a = textscan(cLine, '%s%d');
%                 cChan = a{2}(1);
%             end
%             
%         else % check for power values
%             a = textscan(cLine, '%f%s%s%f%s');
%             cVals = NaN(1,2);
%             for x = 1 : length(a)
%                 if strcmpi(a{x}, 'V') %this is the control voltage, get value from preceeding number
%                     cVals(1) = a{x-1}(1);
%                 elseif strcmpi(a{x}, 'mW') %this is the output in mW, get value from preceeding number
%                     cVals(2) = a{x-1}(1);
%                 end
%             end
%             
%             % add values to array
%             if ~any(isnan(cVals))
%                 if isempty(optoPower{cChan})
%                     optoPower{cChan} = cVals;
%                 else
%                     optoPower{cChan} = [optoPower{cChan}; cVals];
%                 end
%             end
%         end
%     end
% else
%     warning('!!!!!!! No optogenetic calibration file found. Make sure that is OK for your experiment !!!!!!');
% end
% BpodSystem.ProtocolSettings.optoPower = optoPower;
% 
% % do linear fit for existing channels
% BpodSystem.ProtocolSettings.optoFits = cell(4,1);
% for x = 1 : length(optoPower)
%     if ~isempty(optoPower{x})
%         BpodSystem.ProtocolSettings.optoFits{x} = spline(optoPower{x}(:,2),optoPower{x}(:,1));
%     end
% end
% 


