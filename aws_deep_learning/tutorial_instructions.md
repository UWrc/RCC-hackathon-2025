# AWS Deep Learning for Biological images

In this tutorial, we will explore a few simple deep learning concepts using GPU's from AWS Sagemaker. The data used will be images of nanoparticles moving through brain tissue. Different types of nanoparticles motion can provide information about the local microstructure of the brain. We will be trying to predict three different types of motion: Brownian motion (brownian), Fractional brownian motion (fbm), and Continuous-time random walk (ctrw). 

To get started: 

1. Use the AWS credentials emailed to you by __nlsschim@uw.edu__ to log into the RCC AWS portal: **https://aws.amazon.com/console/**

2. Once in the portal, navigate to "Amazon Sagemaker AI" 

3. Under "Applications and IDs", go to "Notebooks" and create a new notebook instance. For the "Notebook instance type" select __ml.g4dn.xlarge__ - this will use a GPU compute instance to speed up your compute time on images!

4. Once the instance is set up, launch Jupyterlab. In your file directory sidebar in Jupyterlab, you should be able to upload the zip file containing all the images, which can be unzipped in the terminal. Upload the labels.csv file as well. Then, create a new notebook. 

5. Follow the code in the pytorch_notebook.ipynb file that is in this directory. Here, you will build and train a simple neural network from scratch using Pytorch. See how high you can get the 3-class accuracy!

6. In the fastai_notebook.ipynb file, we will use a method call fine-tuning on the same data to see whether it outperforms training a model from scratch. 




