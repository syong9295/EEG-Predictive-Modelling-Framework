% this function marks the names of EEG files that has values > 100 or < -100

function [] = mark_artefacts()

% initializations
folder_content = dir("datasets\filtered_data\*.txt");
filt_data_no = numel(folder_content);
artefact_counter = 0;

% generate a folder to record artefact EEG files
if not(isfolder('artefact_processing\artefact_statistics'))
    mkdir('artefact_processing\artefact_statistics');
end

fileID = fopen('artefact_processing\artefact_statistics\artefacts_list.txt', 'w+');

for i = 1 : filt_data_no % for each of the 1025 products
    data = load(fullfile("datasets\filtered_data\",folder_content(i).name));
    [r, c] = size(data);
%     for all 14 channels
%     for j = 1 : c % for each of the 14 channels
%         if any(data(:, j) > 100) || any(data(:, j) < -100)
%             artifact_counter = artifact_counter + 1;
%             text = strcat(eeg_files(i).name, ' channel ', int2str(j) ,'\n');
%             fprintf(fileID, text);
%         end
%     end
    
    %if we only take af3 and af4 channels
    if any(data(:, 1) > 90) || any(data(:, 1) < -90)  % af3 channel
            artefact_counter = artefact_counter + 1;
            text = strcat(folder_content(i).name, ' channel 1 (af3)','\n');
            fprintf(fileID, text);
    end 
    if any(data(:, 14) > 90) || any(data(:, 14) < -90) % af4 channel
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



