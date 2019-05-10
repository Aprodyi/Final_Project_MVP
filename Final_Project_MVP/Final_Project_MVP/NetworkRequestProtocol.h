//
//  NetworkRequestProtocol.h
//  Final_Project_MVP
//
//  Created by Вова on 10.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

@protocol NetworkRequestProtocol <NSObject>

@required
- (void)requestCropImage;
- (void)requestTags;
- (void)requestCategories;
- (void)requestColors;

@end
