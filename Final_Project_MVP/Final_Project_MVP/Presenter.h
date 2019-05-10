//
//  Presenter.h
//  Final_Project_MVP
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RouterProtocol.h"

#import "PresenterProtocol.h"
#import "DataModelProtocol.h"

#import "ImagePhotoViewProtocol.h"
#import "CollectionViewProtocol.h"
#import "TableViewProtocol.h"
#import "CropImageViewProtocol.h"
#import "FullImageScreenProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Presenter : NSObject <PresenterProtocol>

@property (strong, nonatomic) id<RouterProtocol> router;

@property (strong, nonatomic) id<DataModelProtocol> model;

@property (strong, nonatomic) id passiveViewStartScreen;
@property (strong, nonatomic) id<ImagePhotoViewProtocol> passiveViewImagePhoto;
@property (strong, nonatomic) id passiveViewMenu;
@property (strong, nonatomic) id<CollectionViewProtocol> passiveViewCollection;
@property (strong, nonatomic) id<TableViewProtocol> passiveViewTable;
@property (strong, nonatomic) id<CropImageViewProtocol> passiveViewCropImage;
@property (strong, nonatomic) id<FullImageScreenProtocol> passiveViewFullImage;

@end

NS_ASSUME_NONNULL_END
