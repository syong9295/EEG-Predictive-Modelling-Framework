function[] = separate_remaining_files()

% load the variable that tells which files belong which labels
load('class_distribution.mat', 'like_counter', 'dislike_counter', 'label_index');

if not(isfolder('check_artefacts\data-reduced-like'))
    mkdir('check_artefacts\data-reduced-like');
end

if not(isfolder('check_artefacts\data-reduced-dislike'))
    mkdir('check_artefacts\data-reduced-dislike');
end

folder_content = dir("check_artefacts\data-reduced\*.txt");
data_no = numel(folder_content);
 
% move files into corresponding 'like' or 'dislike' folder
for i = 1 : data_no
    
    copied_file_path = strcat('check_artefacts\data-reduced\', folder_content(i).name);
    
    if label_index(i) == 1
        copyfile(copied_file_path, 'check_artefacts\data-reduced-like');
    else
        copyfile(copied_file_path, 'check_artefacts\data-reduced-dislike');
    end
    
end






