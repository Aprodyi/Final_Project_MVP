//
//  MenuModel.h
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModelProtocol.h"
#import "PresenterProtocol.h"
#import "NetworkRequestProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject <DataModelProtocol>

@property (strong, nonatomic) id<NetworkRequestProtocol> networkService;
- (instancetype)initWithPresenter:(id<PresenterProtocol>) presenter;

@end

NS_ASSUME_NONNULL_END
