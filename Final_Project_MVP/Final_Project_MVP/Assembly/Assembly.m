//
//  Assembly.m
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "Assembly.h"
#import "Presenter.h"
#import "DataModel.h"

#import "Router.h"
#import "NetworkRequest.h"

#import "StartScreenView.h"
#import "ImagePhotoView.h"
#import "MenuView.h"
#import "CropImageView.h"
#import "CollectionView.h"
#import "TableView.h"
#import "FullScreenImage.h"
#import "PickerView.h"
#import "GoogleDetectView.h"

@implementation Assembly

+ (UINavigationController *)createDependency
{
    Router *router = [Router new];
    
    Presenter *presenter = [Presenter new];
    presenter.router = router;
    
    DataModel *dataModel = [[DataModel alloc] initWithPresenter:presenter];
    
    NetworkRequest *networkRequest = [NetworkRequest new];
    dataModel.networkService = networkRequest;
    networkRequest.model = dataModel;
    
    CollectionView *collectionView = [[CollectionView alloc] initWithPresenter:presenter];
    TableView *tableView = [[TableView alloc] initWithPresenter:presenter];
    CropImageView *cropImageView = [[CropImageView alloc] initWithPresenter:presenter];
    MenuView *menuView = [[MenuView alloc] initWithPresenter:presenter];
    ImagePhotoView *imagePhotoView = [[ImagePhotoView alloc] initWithPresenter:presenter];
    StartScreenView *startScreenView = [[StartScreenView alloc] initWithPresenter:presenter];
    FullScreenImage *fullScreenImage = [[FullScreenImage alloc] initWithPresenter:presenter];
    PickerView *pickerView = [[PickerView alloc] initWithPresenter:presenter];
    GoogleDetectView *googleDetectView = [[GoogleDetectView alloc] initWithPresenter:presenter];
    
    presenter.model = dataModel;
    presenter.passiveViewStartScreen = startScreenView;
    presenter.passiveViewImagePhoto = imagePhotoView;
    presenter.passiveViewMenu = menuView;
    presenter.passiveViewCollection = collectionView;
    presenter.passiveViewTable = tableView;
    presenter.passiveViewCropImage = cropImageView;
    presenter.passiveViewFullImage = fullScreenImage;
    presenter.passiveViewPicker = pickerView;
    presenter.passiveViewGoogleDetect = googleDetectView;
    
    UINavigationController *navigationController = [router createNavigatioControllerWithRootViewController:startScreenView];
    
    return navigationController;
}

@end
