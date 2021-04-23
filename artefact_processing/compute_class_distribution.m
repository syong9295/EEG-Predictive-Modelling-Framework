% this function calculates the class distribution, 
% the ouput is a txt file containing this information

function [] = compute_class_distribution()

% folder_content = dir("check_artefacts\labels-reduced\*.lab");
folder_content = dir("datasets\artefact_free_data_labels\*.lab");
data_no = numel(folder_content);

like_counter = 0;
dislike_counter = 0;
label_index = zeros(1, data_no);

for i = 1 : data_no % for each of the label file
    path = strcat('datasets\artefact_free_data_labels\', folder_content(i).name);
    fileID = fopen(path);
    next_line = fgetl(fileID);
    if strcmp(next_line, 'Like')
        like_counter = like_counter + 1;
        label_index(i) = 1;
    end
    if strcmp(next_line, 'Disike')  % ignore the typo there
        dislike_counter = dislike_counter + 1;
        label_index(i) = 0;
    end
    fclose(fileID);
end

% fileID = fopen('check_artefacts\artefact-statistics\class_distribution.txt', 'w+');
fileID = fopen('artefact_processing\artefact_statistics\artefact_free_data_class_distribution.txt', 'w+');
fprintf(fileID, "products with 'Like' as label : %s\n", int2str(like_counter));
fprintf(fileID, "products with 'Dislike' as label : %s", int2str(dislike_counter));
fclose(fileID);

save('variable_files\artefact_free_data_class_distribution.mat', 'like_counter', 'dislike_counter', 'label_index');

disp("artefact_free_data_class_distribution.txt has been computed.")

end


