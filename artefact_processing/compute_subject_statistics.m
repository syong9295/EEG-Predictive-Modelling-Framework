% this function calculates how many remaining files are there for each
% subject, the ouput is a txt file containing this information

function [] = compute_subject_statistics()

% empty containers
sub_counter_array = zeros(1, 25);
sub_name_array = strings([1, 25]);
array_counter = 1;

% initializations
% folder_content = dir("check_artefacts\data-reduced\*.txt");
folder_content = dir("datasets\artefact_free_data\*.txt");
data_no = numel(folder_content);

for i = 1 : data_no % for each remaining file
    % process and get the subject's name from the txt file name
    if strcmp(folder_content(i).name(end-5), '_')  % if the last 6 char of current file name is _ 
        sub_name = folder_content(i).name(1:end-6); % i.e Abhishek_1.txt > Abhishek
    else 
        sub_name = folder_content(i).name(1:end-7);  % i.e Abhishek_41.txt > Abhishek
    end
    
    % if variable sub_name is not found in sub_name_array
    if ~any(strcmp(sub_name_array, sub_name))
        sub_name_array(array_counter) = sub_name; % push the name
        array_counter = array_counter + 1;
    end
    
    % increment subject's counter
    idx = find(ismember(sub_name_array, sub_name)); % find index of subject's name in that array
    sub_counter_array(idx) = sub_counter_array(idx) + 1;  % increment the correponding counter
    
end

% fileID = fopen('check_artefacts\artefact-statistics\no_file_per_subject.txt', 'w+');
fileID = fopen('artefact_processing\artefact_statistics\artefact_free_data_subject_statistics.txt', 'w+');
counter = 1;

while ~strcmp(sub_name_array(counter), "") % stop until empty string in sub_names is met
    fprintf(fileID, 'Subject %s has %s remaining files\n', sub_name_array(counter), num2str(sub_counter_array(counter)));
    if counter == 25 % to prevent array out of bound error
       break; 
    end
    counter = counter + 1;
end

fclose(fileID);

disp('artefact_free_data_subject_statistics.txt has been computed')

end


