//
//  MenuModelProtocol.h
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

@protocol SBSDataModelProtocol <NSObject>

@required
- (void)saveImageData:(NSData *)imageData;
- (NSData *)getImageData;
- (void)saveImageToCoreData:(NSData *)imageData;
- (NSArray *)getPhotoArray;
- (NSArray *)getProcessingArray;

//Network Service
- (void)getCropImage;
- (void)getTags;
- (void)getCategories;
- (void)getColors;

//Network Protocol
- (void)loadingTagsIsDoneWithData:(NSDictionary *)responseDict;
- (void)loadingCategoriesIsDoneWithData:(NSDictionary *)responseDict;
- (void)loadingColorsIsDoneWithData:(NSDictionary *)responseDict;
- (void)loadingCropImageIsDoneWithData:(NSDictionary *)responseDict;

@end
