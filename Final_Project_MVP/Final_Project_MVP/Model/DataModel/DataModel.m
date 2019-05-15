//
//  MenuModel.m
//  Final_Project_MVP
//
//  Created by Вова on 07.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "DataModel.h"
#import "Images+CoreDataClass.h"
#import "AppDelegate.h"

@interface DataModel()

@property (nonatomic, strong) id<PresenterProtocol> presenter;
@property (nonatomic, strong) NSArray *processingArray;
@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;

@end

@implementation DataModel

- (instancetype)initWithPresenter:(id<PresenterProtocol>) presenter
{
    if (self = [super init])
    {
        _processingArray = @[@"Тэги", @"Классификация", @"Интеллектуальная обрезка", @"Цвета"];
        _presenter = presenter;
    }
    return self;
}

- (NSArray *)getProcessingArray
{
    return _processingArray;
}

- (void)saveImageData:(NSData *)imageData
{
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"SelectImage"];
}

- (NSData *)getImageData
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectImage"];
}

#pragma mark - Core Data

- (void)saveImageToCoreData:(NSData *)imageData
{
    Images *image = [NSEntityDescription insertNewObjectForEntityForName:@"Images" inManagedObjectContext: [self coreDataContext]];
    image.image = imageData;
    
    if (![image.managedObjectContext save:nil])
    {
        NSLog(@"Ошибка сохранения !");
    }
}

- (NSArray *)getPhotoArray
{
    NSArray *photoArray = [self.coreDataContext executeFetchRequest:self.fetchRequest ? : [Images fetchRequest] error:nil];
    return photoArray;
}

- (NSManagedObjectContext *)coreDataContext
{
    if (_coreDataContext)
    {
        return _coreDataContext;
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
}

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Images"];
    
    return fetchRequest;
}

#pragma mark - Nerwork Service

- (void)getTags
{
    [self.networkService networkRequestWithEndpoint:@"Tags"];
}

- (void)getCategories
{
    [self.networkService networkRequestWithEndpoint:@"Categories"];
}

- (void)getColors
{
    [self.networkService networkRequestWithEndpoint:@"Colors"];
}

- (void)getCropImage
{
    [self.networkService networkRequestWithEndpoint:@"Crop"];
}

#pragma mark - Network Protocol

- (void)loadingTagsIsDoneWithData:(NSDictionary *)responseDict
{
    [self.presenter uploadTableViewWithTagsDict:responseDict];
}

- (void)loadingCategoriesIsDoneWithData:(NSDictionary *)responseDict
{
    [self.presenter uploadTableViewWithCategoriesDict:responseDict];
}

- (void)loadingColorsIsDoneWithData:(NSDictionary *)responseDict
{
    [self.presenter uploadTableViewWithColorsDict:responseDict];
}

- (void)loadingCropImageIsDoneWithData:(NSDictionary *)responseDict
{
    [self.presenter loadingCropIsDoneWithDataRecieved:responseDict];
}

@end
