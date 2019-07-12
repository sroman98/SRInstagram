//
//  SignUpViewController.m
//  SRInstagram
//
//  Created by sroman98 on 7/8/19.
//  Copyright © 2019 sroman98. All rights reserved.
//

#import "SignUpViewController.h"
@import Parse;

@interface SignUpViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) IBOutlet UIImage *photo;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)registerUser:(PFUser *)newUser {
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"registerToHomeSegue" sender:self];
        }
    }];
}

- (IBAction)didTapRegister:(id)sender {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    
    NSData *imageData;
    if(self.photo != nil) {
        imageData = UIImageJPEGRepresentation(self.photo, 1.0);
    } else {
        UIImage *pic = [UIImage imageNamed:@"profile_tab"];
        imageData = UIImageJPEGRepresentation(pic, 1.0);
    }
    PFFileObject *img = [PFFileObject fileObjectWithName:@"profilePic.png" data:imageData];
    [img saveInBackground];
    
    [newUser setObject:img forKey:@"image"];
    [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Uploaded profile pic!");
        } else {
            NSLog(@"Error uploading profile pic: %@", error);
        }
    }];
    
    NSString *usernameNoSpaces = [self.usernameField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if([usernameNoSpaces isEqualToString:@""] || [newUser.password isEqualToString:@""]) {
        NSLog(@"Username or password missing!");
    } else {
        [self registerUser:newUser];
    }
}

- (IBAction)didTapImage:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    //UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Do something with the images (based on your use case)
    UIImage *resizedImage = [self resizeImage:editedImage withSize:CGSizeMake(350, 350)];
    self.photo = resizedImage;
    self.photoImageView.image = self.photo;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (IBAction)didTapReturn:(id)sender {
    [self.usernameField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
