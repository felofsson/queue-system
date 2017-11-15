%% Initialisation -- Delete and re-create folders, 
% Do not run this if you have contents in the folders below you
% wish to save!

todo_folder_name = 'todo';
active_folder_name = 'active';
done_folder_name = 'done';

folder_names = {todo_folder_name, ...
                active_folder_name, ...
                done_folder_name};

% Remove and create folders
for iter = 1:numel(folder_names)
    if isdir(folder_names{iter})
        rmdir(folder_names{iter}, 's')
    end
    mkdir(folder_names{iter})
end

%% Create commands to execute

meta.function_name = 'dummy_function';
meta.opt.xRange = [0:0.01:3];

parameter_range = (linspace(0, 1, 7)).^(3)*5 % Parameters to sweep

my_iter = 1; %loop iterable
for my_param = parameter_range

    meta.opt.my_param = my_param;
    
    save(sprintf([todo_folder_name, filesep, '%s.mat'], num2str(my_iter)), 'meta')
    my_iter = my_iter + 1;
end


%% Run it ! -- This is where the magic happens
% Run this specific cell on many MATLAB instances, to evaluate all
% .mat-files faster!

queue_system(todo_folder_name)

%% Collect results and visualize the results
% Depends on your the nature of your function. 
% E. g. do you want to plot all results, or just find the best
% result of all runs? 
% In this demo we plot the result from all files.

d = dir(done_folder_name);

X = [];
y_list = [];
figure(1)
clf
hold on

legend_list = {}; %for plotting

for iter = 1:numel(d)
    
    fileName = d(iter).name;
    
    if is_mat_file(fileName)
        load([done_folder_name, filesep, fileName])
        
        xRange = meta.opt.xRange;
        legend_list{end+1} = sprintf('1-exp(-ax), a=%s',num2str(meta.opt.my_param));
        plot(xRange, meta.x, '-', 'color', [rand rand rand], 'linewidth', 2)
        
        % X = [X; meta.x]; %e.g. too concatenate the results       
    end  
end
legend(legend_list)



