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
    
    Mat img = [inputImage CVGrayscaleMat];
    
    return [UIImage imageWithCVMat:img];
}

@end