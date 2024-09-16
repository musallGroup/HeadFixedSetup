function send_perfomance(obj, ipAddress, port)
% function Autopilot_checkperfromance
% make learning curve plot for current animal

modColors = [0 0 0; 1 0 0.5; 0 0.5 1];
modLabels = {'Vision' 'Tactile' 'VisuoTactile'};
modIdx = [1 4 5]; %modalities to check (as identified by modlabels above) 


% here load the Bpod object
        global BpodSystem % Import the global BpodSystem object
        bhv = BpodSystem.Data;
        if sum(bhv.Assisted) > 25
            Cnt = Cnt + 1;
            for iMods = 1 : length(modIdx)
                allTrialCnt(iMods,Cnt) = sum(bhv.StimType == modIdx(iMods));
                cIdx = bhv.StimType == modIdx(iMods) & bhv.Assisted & ~bhv.DidNotChoose & bhv.Modality == 1;
                perf(iMods,Cnt) = sum(bhv.Rewarded(cIdx)) / sum(cIdx);
                perfTrialCnt(iMods,Cnt) = sum(cIdx);
            end
        end
        disp(['Performance / session: ' num2str(round(perf(x,:),2))]);
    