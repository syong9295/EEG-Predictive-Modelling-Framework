% this function deletes the data and labels marked as artefacts by
% artefacts_marker.m

function [] = remove_artefacts()

% if not(isfolder('check_artefacts\data-reduced'))
%     mkdir('check_artefacts\data-reduced');
% end

if not(isfolder('datasets\artefact_free_data'))
    mkdir('datasets\artefact_free_data');
end

% if not(isfolder('check_artefacts\labels-reduced'))
%     mkdir('check_artefacts\labels-reduced');
% end

if not(isfolder('datasets\artefact_free_data_labels'))
    mkdir('datasets\artefact_free_data_labels');
end

% copyfile('filtered_data\*.txt','check_artefacts\data-reduced');
% copyfile('ori_labels\*.lab','check_artefacts\labels-reduced');

copyfile('datasets\filtered_data\*.txt','datasets\artefact_free_data');
copyfile('datasets\original_data_labels\*.lab','datasets\artefact_free_data_labels');

% fileID = fopen('check_artefacts\artefact-statistics\artefacts_list.txt');

fileID = fopen('artefact_processing\artefact_statistics\artefacts_list.txt');

next_line = fgetl(fileID);
del_counter = 0;

while ischar(next_line) % while not EOF
    filename = extractBefore(next_line, " "); % i.e get 'Abhishek_1.txt' in 'Abhishek_1.txt channel1'
%     delete_path_data = strcat('check_artefacts\data-reduced\', filename);
    delete_path_data = strcat('datasets\artefact_free_data\', filename);
    filename_label = strcat(filename(1:end-3), 'lab');
%     delete_path_label = strcat('check_artefacts\labels-reduced\', filename_label);
    delete_path_label = strcat('datasets\artefact_free_data_labels\', filename_label);
    
    % check if the file exists or not
    if isfile(delete_path_data)
        delete(delete_path_data);
        del_counter = del_counter + 1; 
    end
    
    if isfile(delete_path_label)
        delete(delete_path_label);
    end

    next_line = fgetl(fileID);
end

disp_msg = strcat(int2str(del_counter), ' files are deleted.');
disp(disp_msg)

fclose(fileID);

end


