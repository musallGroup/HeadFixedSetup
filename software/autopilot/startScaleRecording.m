function startScaleRecording(app)
    % Initialize data storage
    app.WeightDataAll = [];         % Raw weight readings (grams)
    app.WeightTimestampsBpod = [];  % BPod session timestamps
    weightWindow = [];              % Rolling buffer
    N = 10;                         % Number of readings for smoothing

    disp('Started reading from scale...');

    while app.Running
        drawnow;

        data = readline(app.scaleSerial);
        if ~isempty(data)
            % Extract weight using regex
            weightMatch = regexp(data, '\d+,-?\d+\.\d+,[^,]+,\d+\.\d+,', 'match', 'once');

            if ~isempty(weightMatch)
                weightParts = strsplit(weightMatch, ',');
                weight = str2double(weightParts{2}) * 1000;  % Convert to mg

                if ~isempty(weight)
                    % === Use BPod's internal timestamp ===
                    timestamp = BpodSystem.BpodTime;

                    % Store raw weight and timestamp
                    app.WeightDataAll(end+1) = weight;
                    app.WeightTimestampsBpod(end+1) = timestamp;

                    % Maintain rolling average
                    weightWindow(end+1) = weight;
                    if length(weightWindow) > N
                        weightWindow(1) = [];
                    end

                    % GUI update
                    app.CurrentWeightgTextArea.Value = num2str(weight);

                    if length(weightWindow) == N
                        meanWeight = mean(weightWindow);
                        disp(['Smoothed weight: ', num2str(meanWeight, '%.1f'), ' g']);
                        app.checkAllTextAreas;
                    end
                end
            end
        end
    end

    disp('Stopped reading from scale.');
end
