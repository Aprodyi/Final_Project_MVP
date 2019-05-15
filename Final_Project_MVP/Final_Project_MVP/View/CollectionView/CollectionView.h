//
//  CollectionViewViewController.h
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresenterProtocol.h"
#import "CollectionViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionView : UIViewController <CollectionViewProtocol>

- (instancetype)initWithPresenter:(id<PresenterProtocol>) presenter;
@property (nonatomic, weak) id<PresenterProtocol> presenter;

@end

NS_ASSUME_NONNULL_END
