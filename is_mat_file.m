function [bool] = is_mat_file(fileName)
% Checks the file extention of fileName, returns true if = '.mat'

bool = false; % Default

if length(fileName) > 3
    if fileName(end-3:end) == '.mat'
        bool = true;
    end
end

end

