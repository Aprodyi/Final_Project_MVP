//
//  Presenter.m
//  Final_Project_MVP
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "Presenter.h"

@implementation Presenter

#pragma mark - StartScreenViewProtocol

- (void)createImageScreenButtonWasPressed
{
    [self.router pushViewController: self.passiveViewImagePhoto];
}

- (void)createDetectorScreen
{
    [self.router pushViewController:self.passiveViewGoogleDetect];
}

#pragma mark - ImagePhotoView

- (void)selectImageButtonWasPressed
{
    [self.passiveViewPicker runGalleryPickerController];
}

- (void)takePhotoButtonWasPressed
{
    [self.passiveViewPicker runCameraPickerController];
}

- (void)imagePickIsDoneWithData:(NSData *)imageData
{
    if (imageData != nil)
    {
        [self.passiveViewImagePhoto createNextButton];
        [self.model saveImageData:imageData];
        [self.passiveViewImagePhoto uploadImageData:imageData];
    }
}

- (void)nextButtonWasPressed
{
    [self.router pushViewController:self.passiveViewMenu];
}

- (void)imageCoreDataButtonWasPressed
{
    [self.router pushViewController:self.passiveViewCollection];
    NSArray *photoArray = [self.model getPhotoArray];
    self.coreDataImagesArray = photoArray;//.mutableCopy;
    [self.passiveViewCollection reloadCollectionView];
}

#pragma mark - MenuViewProtocol

- (NSInteger)getArrayCount
{
    return [self.model getProcessingArray].count;
}

- (NSString *)getTextAtIndex:(NSInteger)index
{
    if (index > [self getArrayCount] - 1)
    {
        return @"Выход за границы массива";
    }
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
    if ([[responseDict valueForKeyPath:@"status.type"] isEqualToString:@"success"])
    {
        NSDictionary *mainRect = [responseDict valueForKeyPath:@"result.croppings"][0];
        float x1 = [[mainRect valueForKey:@"x1"] floatValue];
        float y1 = [[mainRect valueForKey:@"y1"] floatValue];
        float height = [[mainRect valueForKey:@"target_height"] floatValue];
        float width = [[mainRect valueForKey:@"target_width"] floatValue];
    
        [self.passiveViewCropImage cropRectWithX: x1 andY: y1 andHeight: height andWidth: width];
    }
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
}

#pragma mark - TableViewProtocol

- (void)uploadTableViewWithTagsDict:(NSDictionary *)responseDict
{
    NSMutableArray *responseTagsArray = [NSMutableArray new];
    if ([[responseDict valueForKeyPath:@"status.type"] isEqualToString:@"success"])
    {
        for (NSUInteger index=0; index < [[responseDict valueForKeyPath:@"result.tags.tag.ru"] count]; index++)
        {
            NSString *tag = [responseDict valueForKeyPath:@"result.tags.tag.ru"][index];
            NSString *confidence = [responseDict valueForKeyPath:@"result.tags.confidence"][index];
            [responseTagsArray addObject:[NSString stringWithFormat:@"%@ - %@", tag, confidence]];
        }
        NSArray *tagsData = responseTagsArray.copy;
        self.responseArray = [[NSArray alloc] initWithArray:tagsData];
    }
    else
    {
        self.responseArray = nil;
    }
    [self.passiveViewTable reloadTableViewWithIdentifier:@"Tags"];
}

- (void)uploadTableViewWithCategoriesDict:(NSDictionary *)responseDict
{
    NSMutableArray *responseCategoriesArray = [NSMutableArray new];
    if ([[responseDict valueForKeyPath:@"status.type"] isEqualToString:@"success"])
    {
        for (NSUInteger index=0; index < [[responseDict valueForKeyPath:@"result.categories.name.ru"] count]; index++)
        {
            NSString *categories = [responseDict valueForKeyPath:@"result.categories.name.ru"][index];
            NSString *confidence = [responseDict valueForKeyPath:@"result.categories.confidence"][index];
            [responseCategoriesArray addObject:[NSString stringWithFormat:@"%@ - %@", categories, confidence]];
        }
        NSArray *categoriesData = responseCategoriesArray.copy;
        self.responseArray = [[NSArray alloc] initWithArray:categoriesData];
    }
    else
    {
        self.responseArray = nil;
    }
    [self.passiveViewTable reloadTableViewWithIdentifier:@"Categories"];
}

- (void)uploadTableViewWithColorsDict:(NSDictionary *)responseDict
{
    if ([[responseDict valueForKeyPath:@"status.type"] isEqualToString:@"success"])
    {
        NSArray *backgroundColors = [responseDict valueForKeyPath:@"result.colors.background_colors"];
        NSArray *foregroundColors = [responseDict valueForKeyPath:@"result.colors.foreground_colors"];
        NSArray *imageColors = [responseDict valueForKeyPath:@"result.colors.image_colors"];
        NSArray *responseColorsArray = [NSArray arrayWithObjects: backgroundColors, foregroundColors, imageColors, nil];
        
        self.responseArray = [[NSArray alloc] initWithArray:responseColorsArray];
    }
    else
    {
        self.responseArray = nil;
    }
    [self.passiveViewTable reloadTableViewWithIdentifier:@"Colors"];
}

- (NSString *)getHtmlStringAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [_responseArray[section][row] objectForKey:@"html_code"];
}

- (NSString *)getParentColorAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [_responseArray[section][row] objectForKey:@"closest_palette_color_parent"];
}

- (NSString *)getHtmlParentColorAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [_responseArray[section][row] objectForKey:@"closest_palette_color_html_code"];
}

- (NSString *)getPaletteColorAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [_responseArray[section][row] objectForKey:@"closest_palette_color"];
}

- (NSString *)getPercentAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [_responseArray[section][row] objectForKey:@"percent"];
}

- (float)getRedValueAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [[_responseArray[section][row] objectForKey:@"r"] floatValue]/255.f;
}

- (float)getGreenValueAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [[_responseArray[section][row] objectForKey:@"g"] floatValue]/255.f;
}

- (float)getBlueValueAtSection:(NSUInteger)section andRow:(NSUInteger)row
{
    return [[_responseArray[section][row] objectForKey:@"b"] floatValue]/255.f;
}

- (NSString *)getClassicCellString:(NSUInteger)row
{
    return [_responseArray objectAtIndex:row];
}

- (NSUInteger)getRowsInSectionCount:(NSUInteger)section
{
    return [_responseArray[section] count];
}

- (NSUInteger)getRows
{
    return _responseArray.count;
}

- (void)clearTableView
{
    self.responseArray = nil;
}

#pragma mark - CollectionViewCoreData

- (NSUInteger)getCount
{
    return self.coreDataImagesArray.count;
}

- (NSData *)getImageAtIndex:(NSUInteger)index
{
    Images *image = self.coreDataImagesArray[index];
    return image.image;
}

- (void)cellAtIndexWasPressed:(NSUInteger)index
{
    self.imageCoreData = [self getImageAtIndex:index];
    [self.router pushViewController:self.passiveViewFullImage];
}

- (NSData *)getFullScreenImage
{
    return _imageCoreData;
}

- (void)backButtonWasPressed
{
    [self.router popViewController];
}

@end
