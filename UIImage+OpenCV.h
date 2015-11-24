//
//  UIImage+OpenCV.h
//  PicTiles
//
//  Created by Puttipong S. on 11/23/15.
//  Copyright © 2015 Puttipong S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_OpenCV)

+(UIImage *)imageWithCVMat:(const cv::Mat&)cvMat;
-(id)initWithCVMat:(const cv::Mat&)cvMat;

@property(nonatomic, readonly) cv::Mat CVMat;
@property(nonatomic, readonly) cv::Mat CVGrayscaleMat;

@end