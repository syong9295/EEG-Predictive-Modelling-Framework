# Acknowledgement
This repository contains the code for the final year project of "Predictive Modelling Framework for Consumer Choice in E-commerce Products using EEG Signals" in University of Nottingham Malaysia Campus, by the user syong9295.

# Description
A neuromarketing framework for prediction of consumer preferences using EEG signals and several state-of-the-art machine learning classifiers.

# How to run
0. Either download the zip file or git clone this project.
1. Launch MATLAB of version r2020a or higher.
2. Locate the folder "EEG-Predictive-Modelling-Framework" and right click to "add selected folders and subfolders to path".
3. Run main.m script and wait until "finished running." message is displayed.
4. For classification based on non-deep learning methods, select the "APPS" panel then choose "Classification Learner".
  4.1 Import any feature csv file that you want to test inside the subfolders of "feature_processing" folder.
  4.2 Click "select import selection" and specify number of "cross validation folds" to start session.
  4.3 Click "All" to run, then classification results will be shown.
  4.4 To export a model, click "export model" to workspace for future prediction using the code below, where yfit is the prediction output, C is the exported model and T is the         feature matrix of the new EEG data (which I do not have any for now).
  ```
  yfit = C.predictFcn(T)
  ```
5. For classification based on deep learning method (pretrained CNN models), select "APPS" panel then choose "Deep Network Designer".
  5.1 Open "AlexNet"
  5.2 Replace "fc8" layer with a new "fullyConnectedLayer" and change its "OutputSize" to 2, "BiasLearnRateFactor" to 2, then reconnect the arrows.
  5.3 Replace the original "output" with a new "classificaitionLayer", then reconnect the arrows.
  5.4 On the "Data" page, select interested scalogram dataset folder that starts with "cwt_img" inside "datasets" folder. (e.g cwt_img_channel_1 folder).
  5.5 Specify training options in "Training" page and click "Train", then wait.
  5.6 To export a model, click "Export", "Export trained network and results". Then for prediction of new scalogram image (which I do not have any for now), resize it to 227 x 227 using imresize function, and apply the code below, where yfit is the prediction output, trained_model is the exported model and resized_imagee is the new resized scalogram image.
  ```
  yfit = classify(trained_model, resized_image)
  ```
