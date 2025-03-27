filename = ['Result_' char(datetime("now", 'Format', 'yyyy-MM-dd_HH-mm-ss')) '.txt'];

fileID = fopen(fullfile('..', 'output', filename), 'w');

if fileID == -1
    disp('[ ERROR ] Failed to write to the file: %s', filename);
end

fprintf(fileID, 'hello chunga changi\n');

fclose(fileID);
