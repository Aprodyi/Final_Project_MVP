//
//  PhotoProcessingViewController.h
//  Final_project
//
//  Created by Вова on 21.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuView : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithPresenter:(id<PresenterProtocol>) presenter;
@property (strong, nonatomic) id<PresenterProtocol> presenter;

@end

NS_ASSUME_NONNULL_END
