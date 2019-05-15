//
//  TableView.h
//  Final_Project_MVP
//
//  Created by Вова on 08.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewProtocol.h"
#import "PresenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableView : UIViewController <TableViewProtocol>

- (instancetype)initWithPresenter:(id<PresenterProtocol>) presenter;
@property (nonatomic, weak) id<PresenterProtocol> presenter;

@end

NS_ASSUME_NONNULL_END
