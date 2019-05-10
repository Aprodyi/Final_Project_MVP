//
//  Presenter.m
//  Final_Project_MVP
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "Presenter.h"
#import "Images+CoreDataClass.h"

@interface Presenter()

@property (strong, nonatomic) NSArray *responseArray;
@property (strong, nonatomic) NSMutableArray <Images *> *userInfoArray;

@end

@implementation Presenter

#pragma mark - StartScreenViewProtocol

- (void)createImageScreenButtonWasPressed
{
    [self.router pushViewController: self.passiveViewImagePhoto];
}

- (void)createDetectorScreen
{
    
}

#pragma mark - ImagePhotoViewProtocol

- (void)selectImageButtonWasPressed
{
    [self.passiveViewImagePhoto runImagePickerController];
}

- (void)takePhotoButtonWasPressed
{
    [self.passiveViewImagePhoto runCameraPickerController];
}

- (void)nextButtonWasPressed
{
    [self.router pushViewController:self.passiveViewMenu];
}

- (void)imageCoreDataButtonWasPressed
{
    [self.router pushViewController:self.passiveViewCollection];
}

- (void)saveImageToUserDefaults:(NSData *)imageData
{
    [self.model saveImageData:imageData];
}

#pragma mark - MenuViewProtocol

- (NSInteger) getArrayCount
{
    return [self.model getProcessingArray].count;
}

- (NSString *) getTextAtIndex:(NSInteger)index
{
    return [[self.model getProcessingArray] objectAtIndex:index];
}

- (void) labelWasPressed:(NSString *)label
{
    NSInteger item = [[self.model getProcessingArray] indexOfObject:label];
    switch (item)
    {
        case 0:
        {
            [self.router pushViewController:self.passiveViewTable];
            [self.model getTags];
            break;
        }
            
        case 1:
        {
            [self.router pushViewController:self.passiveViewTable];
            [self.model getCategories];
            break;
        }
            
        case 2:
        {
            [self.router pushViewController:self.passiveViewCropImage];
            [self.model getCropImage];
            break;
        }
            
        case 3:
        {
            [self.router pushViewController:self.passiveViewTable];
            [self.model getColors];
            break;
        }
            
        default:
            break;
    }

}

#pragma mark - CropImageViewProtocol

- (void)loadingCropIsDoneWithDataRecieved:(NSDictionary *)responseDict
{
    NSMutableDictionary *mainRect = [responseDict valueForKeyPath:@"result.croppings"][0];
    float x1 = [[mainRect valueForKey:@"x1"] floatValue];
    float y1 = [[mainRect valueForKey:@"y1"] floatValue];
    float height = [[mainRect valueForKey:@"target_height"] floatValue];// / [[UIScreen mainScreen] scale];
    float width = [[mainRect valueForKey:@"target_width"] floatValue];//  / [[UIScreen mainScreen] scale];
    
    [self.passiveViewCropImage cropRectWithX: x1 andY: y1 andHeight: height andWidth: width];
}

- (NSData *)getImageData
{
    return [self.model getImageData];
}

- (void)cropButtonWasPressed
{
    [self.passiveViewCropImage cutImage];
}

- (void)saveImageToCoreData:(NSData *)imageData
{
    [self.model saveImageToCoreData:imageData];
    [self.passiveViewCropImage deleteCropButton];
}

#pragma mark - TableViewProtocol

- (void)uploadTableViewData:(NSArray *)responseArray withIdentifier:(NSString *)identifier
{
    self.responseArray = [[NSArray alloc] initWithArray:responseArray];
    [self.passiveViewTable reloadTableViewWithIdentifier:identifier];    
}

- (NSString *)getHtmlStringAtSection:(NSInteger)section andRow:(NSInteger)row
{
    return [self.responseArray[section][row] objectForKey:@"html_code"];
}

- (NSString *)getParentColorAtSection:(NSInteger)section andRow:(NSInteger)row
{
    return [self.responseArray[section][row] objectForKey:@"closest_palette_color_parent"];
}

- (NSString *)getHtmlParentColorAtSection:(NSInteger)section andRow:(NSInteger)row
{
    return [self.responseArray[section][row] objectForKey:@"closest_palette_color_html_code"];
}

- (NSString *)getPaletteColorAtSection:(NSInteger)section andRow:(NSInteger)row
{
    return [self.responseArray[section][row] objectForKey:@"closest_palette_color"];
}

- (NSString *)getPercentAtSection:(NSInteger)section andRow:(NSInteger)row
{
    return [self.responseArray[section][row] objectForKey:@"percent"];
}

- (float)getRedValueAtSection:(NSInteger)section andRow:(NSInteger)row
{
    return [[self.responseArray[section][row] objectForKey:@"r"] floatValue]/255.f;
}

- (float)getGreenValueAtSection:(NSInteger)section andRow:(NSInteger)row
{
    return [[self.responseArray[section][row] objectForKey:@"g"] floatValue]/255.f;
}

- (float)getBlueValueAtSection:(NSInteger)section andRow:(NSInteger)row
{
    return [[self.responseArray[section][row] objectForKey:@"b"] floatValue]/255.f;
}

- (NSString *)getClassicCellString:(NSInteger)row
{
    return [self.responseArray objectAtIndex:row];
}

- (NSInteger)getRowsInSectionCount:(NSInteger)section
{
    return [self.responseArray[section] count];
}

- (NSInteger)getRows
{
    return [self.responseArray count];
}

- (void)clearTableView
{
    self.responseArray = nil;
}

#pragma mark - CollectionViewCoreData

- (void)getData
{
    NSArray *photoArray = [self.model getPhotoArray];
    self.userInfoArray = photoArray.mutableCopy;
}

- (NSInteger)getCount
{
    return self.userInfoArray.count;
}

- (NSData *)getImageAtIndex:(NSInteger)index
{
    Images *image = self.userInfoArray[index];
    return image.image;
}

- (void)cellAtIndexWasPressed:(NSInteger)index
{
    NSData *imageCoreData = [self getImageAtIndex:index];
    [self.passiveViewFullImage updateFullImageWithData:imageCoreData];
    [self.router pushViewController:self.passiveViewFullImage];
}

- (void)backButtonWasPressed
{
    [self.router popViewController];
}

@end
