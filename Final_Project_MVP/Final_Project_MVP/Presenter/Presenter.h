//
//  Presenter.h
//  Final_Project_MVP
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Images+CoreDataClass.h"

#import "RouterProtocol.h"

#import "PresenterProtocol.h"
#import "DataModelProtocol.h"

#import "ImagePhotoViewProtocol.h"
#import "CollectionViewProtocol.h"
#import "TableViewProtocol.h"
#import "CropImageViewProtocol.h"
#import "PickerViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Presenter : NSObject <PresenterProtocol>

@property (nonatomic, strong) id<RouterProtocol> router;

@property (nonatomic, weak) id<DataModelProtocol> model;

@property (nonatomic, strong) id passiveViewStartScreen;
@property (nonatomic, strong) id<ImagePhotoViewProtocol> passiveViewImagePhoto;
@property (nonatomic, strong) id passiveViewMenu;
@property (nonatomic, strong) id<CollectionViewProtocol> passiveViewCollection;
@property (nonatomic, strong) id<TableViewProtocol> passiveViewTable;
@property (nonatomic, strong) id<CropImageViewProtocol> passiveViewCropImage;
@property (nonatomic, strong) id passiveViewFullImage;
@property (nonatomic, strong) id<PickerViewProtocol> passiveViewPicker;
@property (nonatomic, strong) id passiveViewGoogleDetect;

@property (nonatomic, strong) NSData *imageCoreData;
@property (nonatomic, copy, nullable) NSArray *responseArray;
@property (nonatomic, copy) NSArray <Images *> *coreDataImagesArray;

@end

NS_ASSUME_NONNULL_END
