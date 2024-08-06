% Original floating-point number
x = 0.3821;

% Convert the number to a string
x_str = num2str(x, '%.12f'); % Use a specific format to ensure adequate precision

% Define the total length of the final string, including zeros
total_length = 12;

% Get the current length of the string representation
current_length = length(x_str);

% Calculate the number of zeros to add before and after the number
num_zeros = total_length - current_length;

% Create a string with the zeros added before and after the original number
% For example, if we want to add zeros after the number to achieve the length
if num_zeros > 0
    % Adding zeros after the number (for this example)
    x_padded_str = [x_str, repmat('0', 1, num_zeros)];
else
    % If the number of zeros needed is negative, this will handle cases where
    % the original number already exceeds the total length
    x_padded_str = x_str;
end

% Convert the padded string back to a float if needed
x_final = str2double(x_padded_str);

% Display the final result
disp(x_padded_str); % Displays the formatted number as a string
disp(x_final);     % Displays the number as a float
