function mainGUI
    % Create the main GUI figure
    mainFig = figure('Name', 'Main GUI', 'NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none');
    set(mainFig, 'Position', [300, 300, 400, 200]);

    % Create an edit field for user input
    textArea = uicontrol('Style', 'edit', 'Position', [50, 120, 300, 40], 'FontSize', 14);

    % Create a button to open the on-screen keypad
    uicontrol('Style', 'pushbutton', 'String', 'Open Keypad', 'FontSize', 14, ...
        'Position', [150, 50, 100, 40], 'Callback', @(src, event) onScreenKeypad(textArea));
end

function onScreenKeypad(textArea)
    % Create a figure for the on-screen keypad
    fig = figure('Name', 'On-Screen Keypad', 'NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none');
    set(fig, 'Position', [700, 300, 300, 400]);
    
    % Set the key press callback for the figure
    set(fig, 'KeyPressFcn', @(src, event) keyPressCallback(event, textArea));
    
    % Define the button labels for the numpad
    buttons = {'7', '8', '9'; '4', '5', '6'; '1', '2', '3'; '0', '.', 'Enter'};
    buttonTags = {'7', '8', '9', '4', '5', '6', '1', '2', '3', '0', '.', 'Enter'};
    
    % Create buttons for the numpad
    for i = 1:4
        for j = 1:3
            uicontrol('Style', 'pushbutton', 'String', buttons{i,j}, 'FontSize', 14, ...
                'Position', [50 + (j-1)*70, 280 - (i-1)*70, 60, 60], ...
                'Tag', buttonTags{(i-1)*3+j}, ... % Assign a tag for identification
                'Callback', @(src, event) buttonCallback(src, textArea));
        end
    end
end

function buttonCallback(src, textArea)
    % Get the current text in the text area
    currentText = get(textArea, 'String');
    
    % Get the button label
    buttonLabel = get(src, 'String');
    
    if strcmp(buttonLabel, 'Enter')
        % Handle the Enter key (you can define what happens here)
        disp(['Entered: ', currentText]);
        % Optionally, you could clear the input or perform another action
    else
        % Append the button label to the text area
        newText = [currentText, buttonLabel];
        set(textArea, 'String', newText);
    end
end

function keyPressCallback(event, textArea)
    % Map key presses to button labels
    key = event.Key;
    
    % Handle numeric keys and dot
    if ismember(key, {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'period'})
        if strcmp(key, 'period')
            key = '.';
        end
        % Find the corresponding button by Tag and simulate its press
        btn = findobj('Tag', key);
        buttonCallback(btn, textArea);
        
    elseif strcmp(key, 'return')
        % Handle the Enter key
        btn = findobj('Tag', 'Enter');
        buttonCallback(btn, textArea);
    end
end
