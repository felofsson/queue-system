function [] = write_to_log_file(var)
% Writes the text of var to a log-file.
% var can be a MException or char, e. g.
%
% > write_to_log_file(ME)
% > write_to_log_file('my_text_line')

if isa(var, 'MException')
    str = [var.identifier, '. ', var.message, ' '];
    
    for iter = 1:numel(var.stack)
        str = [str, sprintf('Line %d in %s. ', var.stack(iter).line, var.stack(iter).name)]; %#ok<AGROW>
    end
    
    to_write_to_log_file = str;
    
elseif isa(my_str, 'char')
    to_write_to_log_file = var;
    
else
    fprintf('Unknown content to write to log-file, attepmting anyways...')
    to_write_to_log_file = var;
    
end

[~, system_name] = system('uname -n');

fid = fopen('logfile.txt', 'a');
fprintf(fid,'%s. %s -- %s', datestr(now), to_write_to_log_file, system_name);
fclose(fid);

end


