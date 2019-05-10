//
//  StartScreenTests.m
//  Final_Project_MVPTests
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

//#import "UIKit/UIKit.h"
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "Presenter.h"
#import "StartScreenView.h"
#import "ImagePhotoView.h"
#import "MenuView.h"
#import "CropImageView.h"
#import "CollectionView.h"
#import "TableView.h"

@interface PresenterTests : XCTestCase

@property (strong, nonatomic) id mockNavigationController;

@property (strong, nonatomic) id mockStartScreenView;
@property (strong, nonatomic) id mockImagePhotoView;
@property (strong, nonatomic) id mockMenuView;
@property (strong, nonatomic) id mockCropImageView;

@end

@implementation PresenterTests

- (void)setUp
{
    self.mockNavigationController = OCMClassMock([UINavigationController class]);
    
    self.mockStartScreenView = OCMClassMock([StartScreenView class]);
    self.mockImagePhotoView = OCMClassMock([ImagePhotoView class]);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testPushImagePhotoView
{
    Presenter *presenter = [Presenter new];
    id mockPresenter = OCMClassMock([Presenter class]);
    
    OCMExpect([mockPresenter pushImagePhotoView:self.mockImagePhotoView]).andDo(nil);
    XCTAssertTrue([[self.mockNavigationController visibleViewController] isKindOfClass:[ImagePhotoView class]]);
//    XCTAssertEqual(starScreenPresenter.passiveView, mockStartScreenView);
}

- (void)testAddImagePhotoScreen
{
//    id mockStartScreenView = OCMClassMock([StartScreenView class]);
//    id mockImagePhotoView = OCMClassMock([ImagePhotoView class]);
    
}

@end
