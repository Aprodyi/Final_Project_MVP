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

@property (strong, nonatomic) id<PresenterProtocol> presenter;
@property (strong, nonatomic) NSArray *processingArray;
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
    return self.processingArray;
}

- (void)saveImageData:(NSData *)imageData
{
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"SelectImage"];
}

- (NSData *)getImageData
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"SelectImage"];
}

- (void)saveImageToCoreData:(NSData *)imageData
{
    Images *image = [NSEntityDescription insertNewObjectForEntityForName:@"Images" inManagedObjectContext: [Images coreDataContext]];
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

#pragma mark - Core Data
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

- (void)getTags
{
    [self.networkService requestTags];
}

- (void)getCategories
{
    [self.networkService requestCategories];
}

- (void)getColors
{
    [self.networkService requestColors];
}

- (void)getCropImage
{
    [self.networkService requestCropImage];
}

#pragma mark - Network Protocol

- (void)loadingTagsIsDoneWithData:(NSDictionary *)responseDict
{
    NSMutableArray *responseArray = [NSMutableArray new];
    for (int i=0; i < [[responseDict valueForKeyPath:@"result.tags.tag.ru"] count]; i++)
    {
        NSString *tag = [responseDict valueForKeyPath:@"result.tags.tag.ru"][i];
        NSString *confidence = [responseDict valueForKeyPath:@"result.tags.confidence"][i];
        [responseArray addObject:[NSString stringWithFormat:@"%@ - %@", tag, confidence]];
    }
    [self.presenter uploadTableViewData:responseArray withIdentifier:@"Tags"];
}

- (void)loadingCategoriesIsDoneWithData:(NSDictionary *)responseDict
{
    NSMutableArray *responseArray = [NSMutableArray new];
    for (int i=0; i < [[responseDict valueForKeyPath:@"result.categories.name.ru"] count]; i++)
    {
        NSString *categories = [responseDict valueForKeyPath:@"result.categories.name.ru"][i];
        NSString *confidence = [responseDict valueForKeyPath:@"result.categories.confidence"][i];
        [responseArray addObject:[NSString stringWithFormat:@"%@ - %@", categories, confidence]];
    }
    [self.presenter uploadTableViewData:responseArray withIdentifier:@"Categories"];
}

- (void)loadingColorsIsDoneWithData:(NSDictionary *)responseDict
{
    NSArray *backgroundColors = [responseDict valueForKeyPath:@"result.colors.background_colors"];
    NSArray *foregroundColors = [responseDict valueForKeyPath:@"result.colors.foreground_colors"];
    NSArray *imageColors = [responseDict valueForKeyPath:@"result.colors.image_colors"];
    NSMutableArray *responseArray = [NSMutableArray arrayWithObjects: backgroundColors, foregroundColors, imageColors, nil];
    [self.presenter uploadTableViewData:responseArray withIdentifier:@"Colors"];
}

- (void)loadingCropImageIsDoneWithData:(NSDictionary *)responseDict
{
    [self.presenter loadingCropIsDoneWithDataRecieved:responseDict];
}

@end
