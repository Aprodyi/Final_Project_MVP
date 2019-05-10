//
//  ImageViewController.m
//  Final_project
//
//  Created by Вова on 06.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "ImagePhotoView.h"

@interface ImagePhotoView () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIImageView *fullImageView;

@end

@implementation ImagePhotoView

UIImageView *imageView;
UIView *imageContainerView;
CGFloat screenWidth;
CGFloat screenHeight;

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
    
    [self buildView];
    self.navigationItem.title = @"Изображение";
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:self.presenter action:@selector(backButtonWasPressed)];
    newBackButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = newBackButton;
}

- (void)buildView
{
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat topBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height +
    self.navigationController.navigationBar.frame.size.height;
    
    imageContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    imageContainerView.layer.borderColor = [UIColor grayColor].CGColor;
    imageContainerView.layer.borderWidth = 1.0f;
    [self.view addSubview:imageContainerView];
    
    UIButton *selectCoreDataButton = [[UIButton alloc] initWithFrame:CGRectMake(10, topBarHeight + 10, screenWidth - 20, screenHeight/8 - 25)];
    [selectCoreDataButton setTitle:@"Сохранения в Core Data" forState:UIControlStateNormal];
    selectCoreDataButton.showsTouchWhenHighlighted = YES;
    selectCoreDataButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    selectCoreDataButton.layer.cornerRadius = 20.f;
    selectCoreDataButton.layer.borderWidth = 2.5f;
    selectCoreDataButton.layer.borderColor = [UIColor blackColor].CGColor;
    selectCoreDataButton.backgroundColor = [UIColor brownColor];
    [selectCoreDataButton addTarget:self.presenter action:@selector(imageCoreDataButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [imageContainerView addSubview:selectCoreDataButton];
    
    UIButton *selectImageButton = [[UIButton alloc] initWithFrame:CGRectMake(10, topBarHeight + screenHeight/8 - 12.5, screenWidth/2 - 15, screenHeight/8 - 30)];
    [selectImageButton setTitle:@"Галерея" forState:UIControlStateNormal];
    selectImageButton.showsTouchWhenHighlighted = YES;
    selectImageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    selectImageButton.layer.cornerRadius = 20.f;
    selectImageButton.layer.borderWidth = 2.5f;
    selectImageButton.layer.borderColor = [UIColor blackColor].CGColor;
    selectImageButton.backgroundColor = [UIColor brownColor];
    [selectImageButton addTarget:self.presenter action:@selector(selectImageButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [imageContainerView addSubview:selectImageButton];
    
    UIButton *takePhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2 + 5, topBarHeight + screenHeight/8 - 12.5, screenWidth/2 - 15, screenHeight/8 - 30)];
    [takePhotoButton setTitle:@"Камера" forState:UIControlStateNormal];
    takePhotoButton.showsTouchWhenHighlighted = YES;
    takePhotoButton.layer.cornerRadius = 20.f;
    takePhotoButton.layer.borderWidth = 2.5f;
    takePhotoButton.layer.borderColor = [UIColor blackColor].CGColor;
    takePhotoButton.backgroundColor = [UIColor brownColor];
    takePhotoButton.titleLabel.font = [UIFont systemFontOfSize: 20];
    [takePhotoButton addTarget:self.presenter action:@selector(takePhotoButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [imageContainerView addSubview:takePhotoButton];
    
    self.fullImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, screenWidth, screenHeight - self.navigationController.navigationBar.frame.size.height)];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, topBarHeight + screenHeight/4 - 40, screenWidth - 20, 3*screenHeight/4 - topBarHeight - 20)];
    imageView.layer.cornerRadius = 20.f;
    imageView.layer.borderWidth = 2.5f;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderColor = [UIColor blackColor].CGColor;
    imageView.backgroundColor = [UIColor grayColor];
    [imageContainerView addSubview:imageView];
}

- (void)createNextButton
{
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(10, screenHeight - 50, screenWidth - 20, 40)];
    [nextButton setTitle:@"Далее" forState:UIControlStateNormal];
    nextButton.showsTouchWhenHighlighted = YES;
    nextButton.layer.cornerRadius = 20.f;
    nextButton.layer.borderWidth = 2.5f;
    nextButton.layer.borderColor = [UIColor blackColor].CGColor;
    nextButton.backgroundColor = [UIColor brownColor];
    [nextButton addTarget:self.presenter action:@selector(nextButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [imageContainerView addSubview:nextButton];
}

#pragma mark - Picker Controller

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:picker completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeRedraw;
    self.fullImageView.image = image;
    self.fullImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self createNextButton];
    NSData *imageData = UIImagePNGRepresentation(self.fullImageView.image);
    [self.presenter saveImageToUserDefaults:imageData];
}

#pragma mark - Protocol Methods

- (void)runImagePickerController
{
    UIImagePickerController *pickerViewController = [[UIImagePickerController alloc] init];
    pickerViewController.allowsEditing = YES;
    pickerViewController.delegate = self;
    [pickerViewController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickerViewController animated:YES completion:nil];
}

- (void)runCameraPickerController
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *pickerViewController =[[UIImagePickerController alloc]init];
        pickerViewController.allowsEditing = YES;
        pickerViewController.delegate = self;
        pickerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickerViewController animated:YES completion:nil];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Ошибка" message:@"Камера недоступна" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
