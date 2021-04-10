function[] = generate_dwt_img()

% initializations
folder_content_data = dir("datasets\artifact_free_data\*.txt");
folder_content_label = dir("datasets\artifact_free_data_labels\*.lab");
data_no = numel(folder_content_data);
CHANNEL_NO = 14;
SIGNAL_LENGTH = 512;
FS = 128;
fb = cwtfilterbank('SignalLength', SIGNAL_LENGTH, 'SamplingFrequency', FS, 'VoicesPerOctave', 48);
if not(isfolder('datasets\cwt_img'))
    mkdir('datasets\cwt_img');
end
img_root = "datasets\cwt_img";

% loop through 869 artifact-free EEG data, and 869 labels at the same time
for i = 1 : data_no
    
   % load EEG data
   current_data = load(fullfile("datasets\artifact_free_data\",folder_content_data(i).name));

   % get label text
   path_label = strcat('datasets\artifact_free_data_labels\', folder_content_label(i).name);
   fileID = fopen(path_label);
   next_line = fgetl(fileID);
   
   % loop through all 14 channels
   for j = 1 : CHANNEL_NO
       channel_data = current_data(:, j); % get each channel of an EEG data
       [wt, f] = fb.wt(channel_data'); % compute cwt for each channel of an EEG data
       wt = abs(wt);
       img = ind2rgb(im2uint8(rescale(wt)), jet(128)); % convert to rgb image
       img_filename = string(next_line) + "_data" + string(i) + "_channel" + string(j) + ".jpg";
       imwrite(imresize(img, [224 224]), char(fullfile(img_root, img_filename)), 'jpg'); % write to file
   end
   
   % close current label file
   fclose(fileID);
    
end

