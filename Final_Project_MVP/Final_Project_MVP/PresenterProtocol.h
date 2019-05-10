//
//  PresenterProtocol.h
//  Final_Project_MVP
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#ifndef PresenterProtocol_h
#define PresenterProtocol_h

@protocol PresenterProtocol <NSObject>

@required

//StartScreen
- (void)createImageScreenButtonWasPressed;
- (void)createDetectorScreen;

//ImagePhotoScreen
- (void)selectImageButtonWasPressed;
- (void)takePhotoButtonWasPressed;
- (void)nextButtonWasPressed;
- (void)imageCoreDataButtonWasPressed;
- (void)saveImageToUserDefaults:(NSData *)imageData;

//MenuScreen
- (NSInteger)getArrayCount;
- (NSString *)getTextAtIndex:(NSInteger)index;
- (void)labelWasPressed:(NSString *)label;

//CropImageScreen
- (void)loadingCropIsDoneWithDataRecieved:(NSDictionary *)responseDict;
- (NSData *)getImageData;
- (void)cropButtonWasPressed;
- (void)saveImageToCoreData:(NSData *)imageData;

//TableViewScreen
- (void)uploadTableViewData:(NSArray *)responseArray withIdentifier:(NSString *)identifier;
- (NSString *)getHtmlStringAtSection:(NSInteger)section andRow:(NSInteger)row;
- (NSString *)getParentColorAtSection:(NSInteger)section andRow:(NSInteger)row;
- (NSString *)getHtmlParentColorAtSection:(NSInteger)section andRow:(NSInteger)row;
- (NSString *)getPaletteColorAtSection:(NSInteger)section andRow:(NSInteger)row;
- (NSString *)getPercentAtSection:(NSInteger)section andRow:(NSInteger)row;
- (float)getRedValueAtSection:(NSInteger)section andRow:(NSInteger)row;
- (float)getGreenValueAtSection:(NSInteger)section andRow:(NSInteger)row;
- (float)getBlueValueAtSection:(NSInteger)section andRow:(NSInteger)row;
- (NSString *)getClassicCellString:(NSInteger)row;
- (NSInteger)getRowsInSectionCount:(NSInteger)section;
- (NSInteger)getRows;
- (void)clearTableView;

//CollectionViewCoreData
- (void)getData;
- (NSInteger)getCount;
- (NSData *)getImageAtIndex:(NSInteger)index;
- (void)cellAtIndexWasPressed:(NSInteger)index;

- (void)backButtonWasPressed;

@end

#endif /* PresenterProtocol_h */
