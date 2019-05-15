//
//  PickerView.h
//  Final_Project_MVP
//
//  Created by Вова on 10.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewProtocol.h"
#import "PresenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickerView : UIViewController <PickerViewProtocol>

- (instancetype)initWithPresenter:(id<PresenterProtocol>) presenter;
@property (nonatomic, weak) id<PresenterProtocol> presenter;

@end

NS_ASSUME_NONNULL_END
