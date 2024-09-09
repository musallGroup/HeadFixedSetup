% Example state machine: Wait for a choice between ports 1 and 2. Indicate
% the choice for 1 second with the chosen port LED at max intsnsity.
% Requires: behavior ports or lickometers with visible LEDs connected to Ch1 and Ch2

sma = NewStateMachine();

sma = AddState(sma, 'Name', 'WaitForChoice', ...
    'Timer', 1,...
    'StateChangeConditions', {'Port1In', 'LightPort1', 'Port2In', 'LightPort2'},...
    'OutputActions', {});
sma = AddState(sma, 'Name', 'LightPort1', ...
    'Timer', 1,...
    'StateChangeConditions', {'Tup', '>exit'},...
    'OutputActions', {'PWM1', 255});
sma = AddState(sma, 'Name', 'LightPort2', ...
    'Timer', 1,...
    'StateChangeConditions', {'Tup', '>exit'},...
    'OutputActions', {'PWM2', 255});