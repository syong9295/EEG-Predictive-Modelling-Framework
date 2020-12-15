% this function calculates how many remaining files are there for each
% product, the ouput is a txt file containing this information

function [] = remaining_file_per_product()

% initializations
prod_array = zeros(1, 41); % create an array of size 1 x 41 of values 0
                           % this is an array of counters for each product
folder_content = dir("check_artefacts\data-reduced\*.txt");
data_no = numel(folder_content);

for i = 1 : data_no  % for each txt file
    temp = folder_content(i).name;
    no_prod = temp(end-5:end-4);  % get the product number (_1, _2 ... 41)
    if no_prod(1) == '_'   % if no_prod is single digit like _1, _2 ... _9, make it 1, 2,  ... 9
       no_prod = no_prod(2); 
    end
    prod_array(str2num(no_prod)) = prod_array(str2num(no_prod)) + 1;  % increment product counter of current file
end

fileID = fopen('check_artefacts\artefact-statistics\no_file_per_product.txt', 'w+');
counter = 0;

for i = 1 : length(prod_array)
    fprintf(fileID, 'remaining files for product %s : %s\n', int2str(i), int2str(prod_array(i)));
    counter = counter + prod_array(i);
end

fclose(fileID);

disp('remaining_file_per_product.txt has been computed')

end



