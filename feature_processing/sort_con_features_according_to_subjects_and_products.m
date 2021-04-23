function[] = sort_con_features_according_to_subjects_and_products()

% list containing name and product no. information
% folder_content_like = dir("check_artefacts/data-reduced-like/*.txt");
% folder_content_dislike = dir("check_artefacts/data-reduced-dislike/*.txt");
folder_content_like = dir("datasets\artefact_free_like_data\*.txt");
folder_content_dislike = dir("datasets\artefact_free_dislike_data\*.txt");
like_data_no = numel(folder_content_like);
dislike_data_no = numel(folder_content_dislike);
total_data_no = like_data_no + dislike_data_no;

sub_name_list = strings([total_data_no, 1]);
prod_no_list = strings([total_data_no, 1]);
sub_name_unique = strings([25, 1]);
sub_name_array_counter = 1;
prod_no_unique = strings([41, 1]);
prod_no_array_counter = 1;

% get the subject and prod. no. associated with the concatenated_features.csv
% also create a unique subject and prod. no. list
for i = 1 : total_data_no
    
    if i <= like_data_no % we want to access 'like' data
        
        % get subject name
        if strcmp(folder_content_like(i).name(end-5), '_')  % if the last 6 char of current file name is _ 
            sub_name = folder_content_like(i).name(1:end-6); % i.e Abhishek_1.txt > Abhishek
        else 
            sub_name = folder_content_like(i).name(1:end-7);  % i.e Abhishek_41.txt > Abhishek
        end
        
        % get product number
       if strcmp(folder_content_like(i).name(end-5), '_')  % if the last 6 char of current file name is _ 
            prod_no = folder_content_like(i).name(end-4); % i.e Abhishek_1.txt > 1
        else 
            prod_no = folder_content_like(i).name(end-5:end-4);  % i.e Abhishek_41.txt > 41
        end
        
    else % we want to access 'dislike' data
        new_index = i - like_data_no;
        
        % get subject name
        if strcmp(folder_content_dislike(new_index).name(end-5), '_') 
            sub_name = folder_content_dislike(new_index).name(1:end-6);
        else 
            sub_name = folder_content_dislike(new_index).name(1:end-7);
        end
        
       % get product number
       if strcmp(folder_content_dislike(new_index).name(end-5), '_')  % if the last 6 char of current file name is _ 
            prod_no = folder_content_dislike(new_index).name(end-4); % i.e Abhishek_1.txt > 1
        else 
            prod_no = folder_content_dislike(new_index).name(end-5:end-4);  % i.e Abhishek_41.txt > 41
        end
    end
    
    sub_name_list(i, 1) = sub_name;
    prod_no_list(i, 1) = prod_no;
    
    % create a unique name list
    % if variable sub_name is not found in sub_name_array
    if ~any(strcmp(sub_name_unique, sub_name))
        sub_name_unique(sub_name_array_counter) = sub_name; % push the name
        sub_name_array_counter = sub_name_array_counter + 1;
    end
    
    % create a unique product number list
    if ~any(strcmp(prod_no_unique, prod_no))
        prod_no_unique(prod_no_array_counter) = prod_no;
        prod_no_array_counter = prod_no_array_counter + 1;
    end
    
end

% initialize subject container for storing seperated feature rows
for i = 1 : length(sub_name_unique)
    sub_feature(i).name = sub_name_unique(i);
    sub_feature(i).features = [];
end

% initialize prod. no. container for storing seperated feature rows
for i = 1 : length(prod_no_unique)
    prod_feature(i).no = prod_no_unique(i);
    prod_feature(i).features = [];
end

% data = csvread('concatenated_features/concatenated_features.csv');
data = csvread('feature_processing\concatenated_features\concatenated_features.csv');
data_no = height(data); % number of rows in data

% seperate features according to subjects, product numbers
for i = 1 : data_no
    
    % decide which subject does this row of feature belong to
    % match sub_name_list(i) against an element in sub_name_unique to get an index
    [~, sub_index] = ismember(sub_name_list(i), sub_name_unique);
    sub_feature(sub_index).features = [sub_feature(sub_index).features; data(i, :)]; 
    
    % also decide which product no. does this row of feature belong to
    [~, prod_index] = ismember(prod_no_list(i), prod_no_unique);
    prod_feature(prod_index).features = [prod_feature(prod_index).features; data(i, :)]; 
    
end


% if not(isfolder('features_by_subjects\'))
%     mkdir('features_by_subjects\');
% end
% 
% if not(isfolder('features_by_product_no\'))
%     mkdir('features_by_product_no\');
% end

if not(isfolder('feature_processing\concatenated_features_by_subjects\'))
    mkdir('feature_processing\concatenated_features_by_subjects\');
end

if not(isfolder('feature_processing\concatenated_features_by_products\'))
    mkdir('feature_processing\concatenated_features_by_products\');
end

for i = 1 : length(sub_feature)
   sub_name = sub_feature(i).name;
   filename = strcat("feature_processing\concatenated_features_by_subjects\", sub_name, ".csv");
   writematrix(sub_feature(i).features, filename); 
end

for i = 1 : length(prod_feature)
   prod_no = prod_feature(i).no;
   filename = strcat("feature_processing\concatenated_features_by_products\", prod_no, ".csv");
   writematrix(prod_feature(i).features, filename); 
end

