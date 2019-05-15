//
//  NetworkRequest.h
//  Final_Project_MVP
//
//  Created by Вова on 10.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkRequestProtocol.h"
#import "DataModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkRequest : NSObject <NetworkRequestProtocol>

@property (nonatomic, strong) id<DataModelProtocol> model;

@end

NS_ASSUME_NONNULL_END
