function [] = queue_system(folder_path)
% Loads .mat-files that are found in folder_path and runs the command
% stored in variable <mat-file>.meta.function_name
%
% Variables/parameters used by function_name are also stored
% in the .mat-file, hence the function_name is called with the
% same folder_path.
%
% The output of the function is stored in meta.x, and saved into
% the .mat-file again.
%
% The .mat-file is then moved to a new folder, "done"


% Append system filessep (e. g. '/' if its not present)
if ~strcmp(folder_path(end),filesep)
    folder_path = [folder_path, filesep];
end

one_level_down = [folder_path, '../']; % to access done/active folders

% Create the folders 'done' and 'active' if they do not exist
required_folders = {'done', 'active'};

for iter = 1:numel(required_folders)
    if ~isdir([one_level_down, required_folders{iter}])
        mkdir([one_level_down, required_folders{iter}])
    end
end

d = dir(folder_path);

for iter = 1:numel(d)
    file_name = d(iter).name;
    
    if is_mat_file(file_name)
        
        full_mat_file_path = [folder_path, d(iter).name];
        
        try
            fprintf('Running %s...\n', full_mat_file_path)
            load(full_mat_file_path, 'meta') % load the struct meta from the .mat-file
            
            % Move the file to the 'active' folder
            movefile(full_mat_file_path, [one_level_down, 'active/', file_name])
            
            % Generate & execute command string
            % essentially we run, 
            % > function_name(folder_path)
            cmd_str = sprintf('%s(''%s'')', meta.function_name, ...
                                   [one_level_down, 'active/', file_name]);
            x = eval(cmd_str);
            meta.x = x;
            
            save([one_level_down, 'active/', file_name], 'meta')
            
            movefile([one_level_down, 'active/', file_name], ...
                     [one_level_down, 'done/', file_name])
            
        catch ME
            fprintf('An error occured, save to log file.\n')
            write_to_log_file(ME) % Supress and log any potential errors
        end
    end
  
end
