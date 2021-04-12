function[] = generate_cwt_img_per_channel(selected_channel)

% initializations
folder_content_data = dir("datasets\artifact_free_data\*.txt");
folder_content_label = dir("datasets\artifact_free_data_labels\*.lab");
data_no = numel(folder_content_data);
SIGNAL_LENGTH = 512;
FS = 128;
fb = cwtfilterbank('SignalLength', SIGNAL_LENGTH, 'SamplingFrequency', FS, 'VoicesPerOctave', 48);

if not(isfolder('datasets\cwt_img_channel_' + string(selected_channel)))
    mkdir('datasets\cwt_img_channel_' + string(selected_channel));
end
if not(isfolder('datasets\cwt_img_channel_' + string(selected_channel) + '\Like'))
    mkdir('datasets\cwt_img_channel_' + string(selected_channel) + '\Like');
end
if not(isfolder('datasets\cwt_img_channel_' + string(selected_channel) + '\Disike')) %ignore the typo
    mkdir('datasets\cwt_img_channel_' + string(selected_channel) + '\Disike');
end

img_root = 'datasets\cwt_img_channel_' + string(selected_channel);

% loop through 869 artifact-free EEG data, and 869 labels at the same time
for i = 1 : data_no
    
   % load EEG data
   current_data = load(fullfile("datasets\artifact_free_data\",folder_content_data(i).name));

   % get label text
   path_label = strcat('datasets\artifact_free_data_labels\', folder_content_label(i).name);
   fileID = fopen(path_label);
   next_line = fgetl(fileID);
   
   channel_data = current_data(:, selected_channel); % get each channel of an EEG data
   [wt, ~] = fb.wt(channel_data'); % compute cwt for each channel of an EEG data
   wt = abs(wt);
   img = ind2rgb(im2uint8(rescale(wt)), jet(128)); % convert to rgb image
   img_filename = string(next_line) + "_" +extractBefore(folder_content_data(i).name, ".") + "_channel_" + selected_channel + ".jpg";
   imwrite(imresize(img, [224 224]), char(fullfile(img_root, string(next_line), img_filename)), 'jpg'); % write to file

   % close current label file
   fclose(fileID);
    
end

disp("all scalograms for channel " + string(selected_channel)  + " have bene computed.");

