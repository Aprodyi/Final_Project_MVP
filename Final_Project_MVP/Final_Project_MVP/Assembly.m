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

@implementation Assembly

//+ (StartScreenView *)createDependency
//{
//    CropImageView *cropImageView = [CropImageView new];
//    CropImagePresenter *cropImagePresenter = [[CropImagePresenter alloc] initWithView:cropImageView];
//    cropImageView.presenter = cropImagePresenter;
//
//    TableView *tableView = [TableView new];
//    TableViewPresenter *tableViewPresenter = [[TableViewPresenter alloc] initWithView:tableView];
//    tableView.presenter = tableViewPresenter;
//
//    DataModel *dataModel = [[DataModel alloc] initWithImagePresenter:cropImagePresenter andTableViewPresenter:tableViewPresenter];
//
//    CollectionView *collectionView = [CollectionView new];
//    CollectionPresenter *collectionPresenter = [CollectionPresenter new];
//    collectionView.presenter = collectionPresenter;
//
//    MenuView *menuView = [MenuView new];
//    MenuPresenter *menuPresenter = [MenuPresenter new];
//    menuView.presenter = menuPresenter;
//    menuView.cropImageView = cropImageView;
//    menuPresenter.model = dataModel;
//    menuPresenter.passiveView = menuView;
//    menuView.tableViewScreen = tableView;
//
//    ImagePhotoView *imagePhotoView = [ImagePhotoView new];
//    ImagePhotoPresenter *imagePhotoPresenter = [[ImagePhotoPresenter alloc] initWithView:imagePhotoView];
//    imagePhotoView.presenter = imagePhotoPresenter;
//    imagePhotoView.menuView = menuView;
//    imagePhotoView.collectionView = collectionView;
//
//    StartScreenPresenter *startScreenPresenter = [StartScreenPresenter new];
//    StartScreenView *startScreenView = [[StartScreenView alloc] initWithPresenter:startScreenPresenter];
//    startScreenPresenter.passiveView = startScreenView;
//    startScreenView.imagePhotoView = imagePhotoView;
//
//    return startScreenView;
//}

+ (UINavigationController *)createDependency
{
    Router *router = [Router new];
    
    Presenter *presenter = [Presenter new];
    presenter.router = router;
    
    DataModel *dataModel = [[DataModel alloc] initWithPresenter:presenter];
    
    NetworkRequest *networkRequest = [NetworkRequest new];
    networkRequest.model = dataModel;
    dataModel.networkService = networkRequest;
    
    CollectionView *collectionView = [[CollectionView alloc] initWithPresenter:presenter];
    TableView *tableView = [[TableView alloc] initWithPresenter:presenter];
    CropImageView *cropImageView = [[CropImageView alloc] initWithPresenter:presenter];
    MenuView *menuView = [[MenuView alloc] initWithPresenter:presenter];
    ImagePhotoView *imagePhotoView = [[ImagePhotoView alloc] initWithPresenter:presenter];
    StartScreenView *startScreenView = [[StartScreenView alloc] initWithPresenter:presenter];
    FullScreenImage *fullScreenImage = [[FullScreenImage alloc] initWithPresenter:presenter];
    
    presenter.model = dataModel;
    presenter.passiveViewStartScreen = startScreenView;
    presenter.passiveViewImagePhoto = imagePhotoView;
    presenter.passiveViewMenu = menuView;
    presenter.passiveViewCollection = collectionView;
    presenter.passiveViewTable = tableView;
    presenter.passiveViewCropImage = cropImageView;
    presenter.passiveViewFullImage = fullScreenImage;
    
    UINavigationController *navigationController = [router createNavigatioControllerWithRootViewController:startScreenView];
    
    return navigationController;
}

@end
