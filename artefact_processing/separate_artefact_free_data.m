function[] = separate_artefact_free_data()

% load the variable that tells which files belong which labels
load('variable_files\artefact_free_data_class_distribution.mat', 'like_counter', 'dislike_counter', 'label_index');

% if not(isfolder('check_artefacts\data-reduced-like'))
%     mkdir('check_artefacts\data-reduced-like');
% end

if not(isfolder('datasets\artefact_free_like_data'))
    mkdir('datasets\artefact_free_like_data');
end

% if not(isfolder('check_artefacts\data-reduced-dislike'))
%     mkdir('check_artefacts\data-reduced-dislike');
% end

if not(isfolder('datasets\artefact_free_dislike_data'))
    mkdir('datasets\artefact_free_dislike_data');
end

% folder_content = dir("check_artefacts\data-reduced\*.txt");
folder_content = dir("datasets\artefact_free_data\*.txt");
data_no = numel(folder_content);
 
% move files into corresponding 'like' or 'dislike' folder
for i = 1 : data_no
    
    copied_file_path = strcat('datasets\artefact_free_data\', folder_content(i).name);
    
    if label_index(i) == 1
        copyfile(copied_file_path, 'datasets\artefact_free_like_data');
    else
        copyfile(copied_file_path, 'datasets\artefact_free_dislike_data');
    end
    
end






