//
//  OpenCv.m
//  PicTiles
//
//  Created by Puttipong S. on 11/23/15.
//  Copyright © 2015 Puttipong S. All rights reserved.
//

#include "OpenCV.h"
#import "UIImage+OpenCV.h"

using namespace cv;
using namespace std;

@implementation OpenCV : NSObject

+ (UIImage*) processImageWithOpenCV: (UIImage*) inputImage{
    
    Mat img = [inputImage CVMat];
    
    return [UIImage imageWithCVMat:img];
}

+ (UIImage*) processImageWithOpenCV2: (UIImage*) inputImage{
    
    Mat img = [inputImage CVMat];
    
    Mat grayImg;
    cvtColor(img, grayImg, CV_BGR2GRAY);
    
    int randomRotate =arc4random_uniform(3);
    
    Point2f pt(img.cols/2., img.rows/2.);
    Mat r = getRotationMatrix2D(pt, (randomRotate+1)*90, 1.0);
    warpAffine(grayImg, grayImg, r, cv::Size(img.cols, img.rows));
    
    return [UIImage imageWithCVMat:grayImg];
}

+ (UIImage*) processImageWithOpenCV3: (UIImage*) inputImage{
    
    Mat img = [inputImage CVMat];
    
    for(int i=0;i<img.rows;i++){
        for(int j=0;j<img.cols*4;j++){
            img.at<uchar>(i,j) = 255-img.at<uchar>(i,j);
        }
    }
    
    int randomRotate =arc4random_uniform(3);
    
    Point2f pt(img.cols/2., img.rows/2.);
    Mat r = getRotationMatrix2D(pt, (randomRotate+1)*90, 1.0);
    warpAffine(img, img, r, cv::Size(img.cols, img.rows));
    
    return [UIImage imageWithCVMat:img];
}

+ (UIImage*) processImageWithOpenCV4: (UIImage*) inputImage{
    
    Mat img = [inputImage CVMat];
    
    cvtColor(img, img, CV_BGR2GRAY);
    
    for(int i=0;i<img.rows;i++){
        for(int j=0;j<img.cols;j++){
            img.at<uchar>(i,j) = 255-img.at<uchar>(i,j);
        }
    }
    
    int randomRotate =arc4random_uniform(8);
    
    Point2f pt(img.cols/2., img.rows/2.);
    Mat r = getRotationMatrix2D(pt, (randomRotate+1)*45, 1.0);
    warpAffine(img, img, r, cv::Size(img.cols, img.rows));
    
    return [UIImage imageWithCVMat:img];
}



@end