% test for the generation of CWT image of 1 EEG data

data = load("datasets\artifact_free_data\Abhishek_10.txt");
SIGNAL_LENGTH = 512; % each EEG data file has 512 samples within 4 seconds
FS = 128;

fb = cwtfilterbank('SignalLength', SIGNAL_LENGTH, 'SamplingFrequency', FS, 'VoicesPerOctave', 48);

[wt, f] = fb.wt(data(:,1)'); % (512 x 1) becomes (1 x 512)

wt = abs(wt);

im = ind2rgb(im2uint8(rescale(wt)), jet(128));

im_file_name = "like" + "_" + "1" + ".jpg";

% generate a folder to contain filtered EEG data
if not(isfolder('datasets\cwt_img'))
    mkdir('datasets\cwt_img');
end

imwrite(imresize(im, [224 224]), char(fullfile("datasets\cwt_img", im_file_name)), "jpg");

