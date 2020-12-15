% this function marks the names of EEG files that has values > 100 or < -100

function [] = artefacts_marker()

% initializations
folder_content = dir("filtered_data\*.txt");
filt_data_no = numel(folder_content);
artefact_counter = 0;

% generate a folder to contain filtered EEG txt files
if not(isfolder('check_artefacts\artefact-statistics'))
    mkdir('check_artefacts\artefact-statistics');
end

fileID = fopen('check_artefacts\artefact-statistics\artefacts_list.txt', 'w+');

for i = 1 : filt_data_no % for each of the 1025 products
    data = load(fullfile("filtered_data\",folder_content(i).name));
    [r, c] = size(data);
%     for all 14 channels
%     for j = 1 : c % for each of the 14 channels
%         if any(data(:, j) > 100) || any(data(:, j) < -100)
%             artefact_counter = artefact_counter + 1;
%             text = strcat(eeg_files(i).name, ' channel ', int2str(j) ,'\n');
%             fprintf(fileID, text);
%         end
%     end
    
    %if we only take af3 and af4 channels
    if any(data(:, 1) > 100) || any(data(:, 1) < -100)  % af3 channel
            artefact_counter = artefact_counter + 1;
            text = strcat(folder_content(i).name, ' channel 1 (af3)','\n');
            fprintf(fileID, text);
    end 
    if any(data(:, 14) > 100) || any(data(:, 14) < -100) % af4 channel
            artefact_counter = artefact_counter + 1;
            text = strcat(folder_content(i).name, ' channel 14 (af4)','\n\n');
            fprintf(fileID, text);
    end
    
end


% message if we use 14 channels
% msg = strcat('total number of channels with artefacts (all channels) :', int2str(artefact_counter), ' out of 14350', '\n');
% fprintf(msg)

% message if we use 2 channels (af3 and af4)
msg2 = strcat('total number of channels with artefacts (af3 & af4) :', int2str(artefact_counter), ' out of 2050', '\n');
fprintf(msg2)

fclose(fileID);

end



