//
//  Router.h
//  Final_Project_MVP
//
//  Created by Вова on 09.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "UIKit/UIKit.h"
#import <Foundation/Foundation.h>
#import "RouterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Router : NSObject <UINavigationControllerDelegate, RouterProtocol>

- (UINavigationController *)createNavigatioControllerWithRootViewController:(UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END
