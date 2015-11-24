//
//  OpenCv.h
//  PicTiles
//
//  Created by Puttipong S. on 11/23/15.
//  Copyright © 2015 Puttipong S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CVWrapper : NSObject

+ (UIImage*) processImageWithOpenCV: (UIImage*) inputImage;

@end
