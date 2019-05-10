//
//  ResponseImage.m
//  Final_project
//
//  Created by Вова on 24.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "CropImageView.h"

@interface CropImageView ()

@property (strong, nonatomic) UIImageView *inputImageView;
@property (strong, nonatomic) UIView *rectView;

//Activity Indicator
@property (strong, nonatomic) UIActivityIndicatorView *indicatorLoading;
@property (strong, nonatomic) UILabel *loadingLabel;

@end

@implementation CropImageView

CGRect cropRect;

- (instancetype)initWithPresenter:(id<PresenterProtocol>) presenter
{
    if (self = [super init])
    {
        _presenter = presenter;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:self.presenter action:@selector(backButtonWasPressed)];
    newBackButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = newBackButton;
    self.inputImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.inputImageView.image = [UIImage imageWithData:[self.presenter getImageData]];
    self.inputImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.inputImageView.layer.masksToBounds = YES;
    [self.view addSubview:self.inputImageView];
    
    [self setLoadingScreen];
}

- (void)addCropRectOnScreen
{
    [self.indicatorLoading stopAnimating];
    [self.loadingLabel setHidden:YES];
    
    CGRect imageRect = [self frameForImage:self.inputImageView.image inImageViewAspectFit:self.inputImageView];
    
    //cropRect.origin.y = (imageRect.origin.y + cropRect.origin.y);// * (imageRect.size.height / self.inputImageView.frame.size.height);
    //testRect.size.height /= imageRect.size.height;
    
    self.rectView = [[UIView alloc] initWithFrame:cropRect];
    [self.rectView setAlpha:0.5];
    self.rectView.backgroundColor = [UIColor greenColor];
    self.rectView.layer.cornerRadius = 10.f;
    self.rectView.layer.masksToBounds = YES;
    [self.inputImageView addSubview: self.rectView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Обрезать" style:UIBarButtonItemStylePlain target:self.presenter action:@selector(cropButtonWasPressed)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
}

- (void)cutImage
{
    [self.rectView removeFromSuperview];
    self.navigationItem.rightBarButtonItem = nil;
    
//    CGFloat widthRatio = self.inputImageView.image.size.width / self.inputImageView.bounds.size.width;
//    CGFloat heightRatio = self.inputImageView.image.size.height / self.inputImageView.bounds.size.height;
//    CGFloat scalingFactor = widthRatio > heightRatio ? widthRatio : heightRatio;
//
//    cropRect.origin.x *= scalingFactor;
//    cropRect.origin.y *= scalingFactor;
//    cropRect.size.width *= scalingFactor;
//    cropRect.size.height *= scalingFactor;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.inputImageView.image.CGImage, cropRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    self.inputImageView.image = cropped;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonWasPressed)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
}

- (void)setLoadingScreen
{
    self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4 - 20, [UIScreen mainScreen].bounds.size.height/2 + 25, 150, 30)];
    self.loadingLabel.textColor = [UIColor yellowColor];
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.center = self.view.center;
    self.loadingLabel.text = @"Загрузка данных";
    
    self.indicatorLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorLoading.color = [UIColor yellowColor];
    self.indicatorLoading.hidesWhenStopped = YES;
    self.indicatorLoading.frame = CGRectMake(100, 150, 100, 100);
    self.indicatorLoading.center = CGPointMake(self.view.center.x, self.view.center.y - 15.f);
    
    [self.view addSubview:self.indicatorLoading];
    [self.view addSubview:self.loadingLabel];
    
    [self.indicatorLoading startAnimating];
}

#pragma mark - Core Data Save

- (void)saveButtonWasPressed
{
    [self.presenter saveImageToCoreData:UIImagePNGRepresentation(self.inputImageView.image)];
}
- (void)deleteCropButton
{
    self.navigationItem.rightBarButtonItem = nil;
}

- (CGRect)frameForImage:(UIImage*)image inImageViewAspectFit:(UIImageView*)imageView
{
    CGFloat imageRatio = image.size.width / image.size.height;
    CGFloat viewRatio = imageView.frame.size.width / imageView.frame.size.height;
    if(imageRatio < viewRatio)
    {
        CGFloat scale = imageView.frame.size.height / image.size.height;
        CGFloat width = scale * image.size.width;
        CGFloat topLeftX = (imageView.frame.size.width - width) * 0.5;
        
        return CGRectMake(topLeftX, 0, width, imageView.frame.size.height);
    }
    else
    {
        CGFloat scale = imageView.frame.size.width / image.size.width;
        CGFloat height = scale * image.size.height;
        CGFloat topLeftY = (imageView.frame.size.height - height) * 0.5;
        
        return CGRectMake(0, topLeftY, imageView.frame.size.width, height);
    }
}

#pragma mark - Protocol Methods
- (void)cropRectWithX:(float)x1 andY:(float)y1 andHeight:(float)height andWidth:(float)width
{
    height /= [[UIScreen mainScreen] scale];
    width /= [[UIScreen mainScreen] scale];
    cropRect = CGRectMake(x1, y1, width, height);
    [self addCropRectOnScreen];
}

@end
