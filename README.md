# Bioinspired somato-visual (BSV) associated learning
This project reports a bioinspired somato-visual (BSV) learning architecture that integrates visual data with somatosensory data from skin-like stretchable strain sensors for enhanced human gesture recognition.

## System requirements
### Hardware requirements
A standard computer with enough RAM to support the in-memory operations.
### Software requirements
#### OS Requirements:
This package is supported for Windows, macOS and Linux.
Has been tested on Windows 10 (64-bit).

#### Matlab requirements:
Matlab >= R2017.
Require to install "Deep Learning Toolbox". 
This package has been tested on Matlab R2017a with "Deep Learning Toolbox".
Update:
Due to the version update of Matlab, we have slightly adjust the raw code "main.m". 
The new code "main_2023.m" has been tested on Matlab R2020b with "Deep Learning Toolbox".

## Installation guide 
Deep Learning Toolbox (formerly Neural Network Toolbox) provides a framework for designing and implementing deep neural networks with algorithms, pretrained models, and apps. In MATLAB, there is an additional installation method for Mathworks toolboxes that you have already licensed. The details are following:
(1) In the command window, click on "Add-Ons" (bring up the Add-On Explorer)
(2) Use the search box to search "Deep Learning Toolbox"
(3) Click on the entry and install. 

## Instructions to run on the data
#### 1. Please download all data & codes, and place them in the same folder 
#### 2. Unzip all the .zip folder (e.g., SV_dataset.zip and feature_extract_9183.zip )
#### 3. Run "main.m" using MATLAB(2017); run "main_2023.m" using MATLAB(2020).

There are detailed description of the code's functionality in the source code (main.m).

Runing time is usually about one minute.

You can get the recognition accuracies of Visual (r1=0.8933), Somato (r2=0.845), BSV (r3=1), SV-V (r4=0.9367), SV-T(r5=0.9583), and SV-M (r6=0.97) approaches.


If you'd like to get your hands a bit more dirty:
You can train the BSV model by enabling the following code in the source code (main.m).
#### [mynet,tr] = train(mynet,Xtrain',Ytrain');


You can also use your pretrain model to process the visual images by replacing the following code.
#### load feature_extract_9183.mat;


Finally: We'd love to hear from you. Please let us know if you have any comments or suggestions. Also, if you'd like to contribute to this project please let us know.


** You can use the dateset and code for your research **

Continuing update.




