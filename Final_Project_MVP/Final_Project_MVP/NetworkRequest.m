//
//  NetworkRequest.m
//  Final_Project_MVP
//
//  Created by Вова on 10.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "NetworkRequest.h"
#import <UNIRest.h>

@implementation NetworkRequest

- (void)requestTags
{
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectImage"];
    NSString *base64String = [imageData base64EncodedStringWithOptions:0];
    
    [[UNIRest post:^(UNISimpleRequest *request) {
        [request setUrl:@"https://api.imagga.com/v2/uploads"];
        [request setHeaders:@{@"Accept": @"application/json"}];
        [request setUsername:@"acc_d1e957a26e527be"];
        [request setPassword:@"dce0cf78829a0bd00cb4c433da2885fb"];
        [request setParameters:@{@"image_base64": base64String}];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        
        if (response.code != 200)
        {
            NSLog(@"Ошибка с кодом %li", response.code);
        }
        
        NSString *upload_id = [response.body.JSONObject valueForKeyPath:@"result.upload_id"];
        
        [[UNIRest get:^(UNISimpleRequest *request) {
            [request setUrl: [NSString stringWithFormat:@"https://api.imagga.com/v2/tags?image_upload_id=%@", upload_id]];
            [request setHeaders:@{@"Accept": @"application/json"}];
            [request setUsername:@"acc_d1e957a26e527be"];
            [request setPassword:@"dce0cf78829a0bd00cb4c433da2885fb"];
            [request setParameters:@{@"language": @"ru"}];
        }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
            
            if (response.code != 200)
            {
                NSLog(@"Ошибка с кодом %li", response.code);
            }
            
            UNIJsonNode *body = response.body;
            NSDictionary *responseDict = body.JSONObject;
            [[NSThread currentThread] isMainThread] ? NSLog(@"Главный поток!!!") : NSLog(@"Не главный поток!!!");
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.model loadingTagsIsDoneWithData:responseDict];
            });
        }];
    }];
}

- (void)requestCategories
{
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectImage"];
    NSString *base64String = [imageData base64EncodedStringWithOptions:0];
    
    [[UNIRest post:^(UNISimpleRequest *request) {
        [request setUrl:@"https://api.imagga.com/v2/uploads"];
        [request setHeaders:@{@"Accept": @"application/json"}];
        [request setUsername:@"acc_ad7cf76fba2a73d"];
        [request setPassword:@"b7e63296f7d3b70227879c6439842173"];
        [request setParameters:@{@"image_base64": base64String}];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        
        if (response.code != 200)
        {
            NSLog(@"Ошибка с кодом %li", response.code);
        }
        
        NSString *upload_id = [response.body.JSONObject valueForKeyPath:@"result.upload_id"];
        
        [[UNIRest get:^(UNISimpleRequest *request) {
            [request setUrl: [NSString stringWithFormat:@"https://api.imagga.com/v2/categories/personal_photos?image_upload_id=%@", upload_id]];
            [request setHeaders:@{@"Accept": @"application/json"}];
            [request setUsername:@"acc_ad7cf76fba2a73d"];
            [request setPassword:@"b7e63296f7d3b70227879c6439842173"];
            [request setParameters:@{@"language": @"ru"}];
        }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
            
            if (response.code != 200)
            {
                NSLog(@"Ошибка с кодом %li", response.code);
            }
            
            UNIJsonNode *body = response.body;
            NSDictionary *responseDict = body.JSONObject;
            [[NSThread currentThread] isMainThread] ? NSLog(@"Главный поток!!!") : NSLog(@"Не главный поток !!!");
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.model loadingCategoriesIsDoneWithData:responseDict];
            });
        }];
    }];
}

- (void)requestColors
{
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectImage"];
    NSString *base64String = [imageData base64EncodedStringWithOptions:0];
    
    [[UNIRest post:^(UNISimpleRequest *request) {
        [request setUrl: @"https://api.imagga.com/v2/colors"];
        [request setHeaders:@{@"Accept": @"application/json"}];
        [request setUsername:@"acc_ad7cf76fba2a73d"];
        [request setPassword:@"b7e63296f7d3b70227879c6439842173"];
        [request setParameters:@{@"image_base64": base64String}];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        
        if (response.code != 200)
        {
            NSLog(@"Ошибка с кодом - %lu", response.code);
        }
        
        UNIJsonNode *body = response.body;
        NSDictionary *responseDict = body.JSONObject;
        [[NSThread currentThread] isMainThread] ? NSLog(@"Главный поток!!!") : NSLog(@"Не главный поток !!!!!");
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.model loadingColorsIsDoneWithData:responseDict];
        });
    }];
}

- (void)requestCropImage
{
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectImage"];
    NSString *base64String = [imageData base64EncodedStringWithOptions:0];
    
    [[UNIRest post:^(UNISimpleRequest *request) {
        [request setUrl: @"https://api.imagga.com/v2/croppings"];
        [request setHeaders:@{@"Accept": @"application/json"}];
        [request setUsername:@"acc_d1e957a26e527be"];
        [request setPassword:@"dce0cf78829a0bd00cb4c433da2885fb"];
        [request setParameters:@{@"image_base64": base64String,  @"no_scaling": @"1", @"rect_percentage": @"30", @"image_resut": @"1" }];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        if (response.code != 200)
        {
            NSLog(@"Ошибка с кодом - %lu", response.code);
        }
        
        UNIJsonNode *body = response.body;
        NSDictionary *responseDict = body.JSONObject;
        [[NSThread currentThread] isMainThread] ? NSLog(@"Главный поток!!!") : NSLog(@"Не главный поток !!!!!");
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.model loadingCropImageIsDoneWithData:responseDict];
        });
    }];
}


@end
