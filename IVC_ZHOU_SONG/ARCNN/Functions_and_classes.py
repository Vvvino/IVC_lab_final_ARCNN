import os
import numpy as np
import torch
from torchvision import datasets,transforms
from torch.utils.data import Dataset
import torch.nn as nn
import torch.nn.functional as F
from PIL import Image



def psnr(original, contrast):
    mse = np.mean((original - contrast) ** 2)
    if mse == 0:
        return 100
    PSNR = 10 * np.log10(1 / (mse))
    return PSNR

def unnormalized_show(img):
    img = img * 0.5 + 0.5     # unnormalize
    npimg = img.detach().numpy()
    return np.transpose(npimg, (2, 3, 1, 0))

def findlabel(featurepath,labelimgs):
    count = 0;
    index = count;
    for k in labelimgs:
        if k[-7:-4] == featurepath[-7:-4]:
            index = count
        count = count+1
    return index

def getdataset(Q,transform):
    featpath2 = './train2_feature/'
    labelpath2 = './train2_label/'
    train = compset(os.path.join(featpath2,Q),labelpath2,transform)
    return train

class compset(Dataset):
    def __init__(self,featroot,labelroot,transform):
        featimgs = os.listdir(featroot)
        self.featimgs=[os.path.join(featroot,k) for k in featimgs]
        self.featimgs.sort(key=lambda x:int(x[-7:-4]))
        #self.featimgs.sort(key=lambda x:float(x[-12:-8]))
        labelimgs = os.listdir(labelroot)
        self.labelimgs=[os.path.join(labelroot,k) for k in labelimgs]
        self.labelimgs.sort(key=lambda x:int(x[-7:-4]))
        self.transforms = transform
        
    def __getitem__(self, index):
        feature_img_path = self.featimgs[index]
        feature_img = Image.open(feature_img_path)
        if self.transforms:
            feature = self.transforms(feature_img)
        else:
            feature = np.asarray(feature_img)
            feature = torch.from_numpy(feature)
        
        labelindex = findlabel(feature_img_path,self.labelimgs);
        label_img_path = self.labelimgs[labelindex]
        label_img = Image.open(label_img_path)
        if self.transforms:
            label = self.transforms(label_img)
        else:
            label = np.asarray(label_img)
            label = torch.from_numpy(label)
        data = (feature,label)
        return data
    
    def __len__(self):
        return len(self.featimgs)
    
class ARCNN(nn.Module):

    def __init__(self):
        """
        Class constructor which preinitializes NN layers with trainable
        parameters.
        """
        super(ARCNN, self).__init__()
        # 3 input image channel, 64 output channels, 9x9 square convolution
        # conv kernel
        self.conv1 = nn.Conv2d(3, 64, kernel_size=9, bias=None, stride=1, padding=4)
        nn.init.normal_(self.conv1.weight,mean=0.0,std=0.001)
        self.conv2 = nn.Conv2d(64, 32, kernel_size=7, bias=None, stride=1, padding=3)
        nn.init.normal_(self.conv2.weight,mean=0.0,std=0.001)
        self.conv3 = nn.Conv2d(32, 16, kernel_size=1, bias=None, stride=1, padding=0)
        nn.init.normal_(self.conv3.weight,mean=0.0,std=0.001)
        self.conv4 = nn.Conv2d(16, 3, kernel_size=5, bias=None, stride=1, padding=2)
        nn.init.normal_(self.conv4.weight,mean=0.0,std=0.001)



    def forward(self, x):
        x = F.relu(self.conv1(x))
        x = F.relu(self.conv2(x))
        x = F.relu(self.conv3(x))
        x = self.conv4(x)
        return x 