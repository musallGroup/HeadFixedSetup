% Example state matrix: A global timer in "loop mode" sends 1ms pulses from BNC1 in an infinite loop. 
% It is triggered in the first state. Next, the state machine goes into a state
% where it waits for two events:
% 1. Port1In momentarily enters a state that stops the global timer.
% 2. Port2In exits the state machine.
% Requires: behavior ports or lickometers with visible LEDs connected to Ch1 and Ch2

sma = NewStateMachine;
sma = SetGlobalTimer(sma, 'TimerID', 1, 'Duration', 0.001, 'OnsetDelay', 0,...
                     'Channel', 'BNC1', 'OnLevel', 1, 'OffLevel', 0,...
                     'Loop', 1, 'SendGlobalTimerEvents', 0, 'LoopInterval', 0.001); 
sma = AddState(sma, 'Name', 'TimerTrig1', ...
    'Timer', 0,...
    'StateChangeConditions', {'Tup', 'WaitForPoke'},...
    'OutputActions', {'GlobalTimerTrig', 1});
sma = AddState(sma, 'Name', 'WaitForPoke', ...
    'Timer', 0,...
    'StateChangeConditions', {'Port1In', 'StopGlobalTimer', 'Port2In', '>exit'},...
    'OutputActions', {});
sma = AddState(sma, 'Name', 'StopGlobalTimer', ...
    'Timer', 0,...
    'StateChangeConditions', {'Tup', 'WaitForPoke'},...
    'OutputActions', {'GlobalTimerCancel', 1});

