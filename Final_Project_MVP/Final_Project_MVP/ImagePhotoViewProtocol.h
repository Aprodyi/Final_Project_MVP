//
//  ImagePhotoViewProtocol.h
//  Final_Project_MVP
//
//  Created by Вова on 06.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "CollectionViewProtocol.h"

#ifndef ImagePhotoViewProtocol_h
#define ImagePhotoViewProtocol_h

@protocol ImagePhotoViewProtocol <NSObject>

@required
- (void)runImagePickerController;
- (void)runCameraPickerController;

@end

#endif
