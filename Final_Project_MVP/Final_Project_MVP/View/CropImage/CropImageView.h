//
//  ResponseImage.h
//  Final_project
//
//  Created by Вова on 24.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CropImageViewProtocol.h"
#import "PresenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CropImageView : UIViewController <CropImageViewProtocol>

- (instancetype)initWithPresenter:(id<PresenterProtocol>) presenter;
@property (nonatomic, weak) id<PresenterProtocol> presenter;

@end

NS_ASSUME_NONNULL_END
