//
//  ViewController.m
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/1/22.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "ViewController.h"
#import <TTkGameSDK/TTkGameSDK.h>

#import <SDWebImage/SDWebImage.h>
#import "TGWebViewController.h"

#import "Header.h"
#import "DevSettingViewController.h"
#import "PayViewController.h"
#import "ShareViewController.h"
#import "AboutViewController.h"
#import "LoginViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *acountType;

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

@implementation ViewController
{
    UIDeviceOrientation currentOrientation;
    TTGCUserModel *userModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [[TTkGameManager defaultManager] setPayEnvironmentTest];
    [self showLoginView];
    
    [[TTkGameManager defaultManager] accountKickedNotification:^(NSString * _Nullable information) {
        //Your account has been logged in on another device, please login again.
        TTGCHUD_HINT(information);
        [self showLoginView];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [[TTkGameManager defaultManager] userInfoCompletion:^(id  _Nullable userInfo, NSError * _Nullable error) {
        if (!error) {
            self->userModel = userInfo;
            [self freshUserInfo:self->userModel];
        } else {
        }
    }];
}

- (void)setupUI {
    self.photoImageView.layer.cornerRadius = 49;
    self.photoImageView.clipsToBounds = YES;
    self.logoutButton.layer.cornerRadius = 5.0;
}

- (void)showLoginView {
    if ([[TTkGameManager defaultManager] loginType] == TTGCLoginType_unloggedIn) {
        //unlogged in and show login UI
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:NO completion:nil];
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getUserInfo];
        });
    }
}

- (BOOL)isFreshFrameWithOrientation:(UIDeviceOrientation)orientation {
    if ((currentOrientation == UIDeviceOrientationPortrait) && (orientation != UIDeviceOrientationPortrait)) {
        return YES;
    } else if ((currentOrientation != UIDeviceOrientationPortrait) && (orientation == UIDeviceOrientationPortrait)) {
        return YES;
    } else {
        return NO;
    }
}

- (IBAction)clearNotification:(id)sender {
    [[TTkGameManager defaultManager] cleanNotification];
    TTGCHUD_SUCCESS(@"cleared~");
}

- (IBAction)systemNotificationSetting:(id)sender {
    [[TTkGameManager defaultManager] systemNotificationSetting];
}

- (IBAction)devSetting:(id)sender {
    DevSettingViewController *vc = [[DevSettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)purchase:(id)sender {
    PayViewController *vc = [[PayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)social:(id)sender {
    ShareViewController *vc = [[ShareViewController alloc] init];
    vc.userType = userModel.userType;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)about:(id)sender {
    AboutViewController *vc = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getUserInfo {
    TTGCHUD_NO_Stop(@"loading...")
    [[TTkGameManager defaultManager] userInfoCompletion:^(id  _Nullable userInfo, NSError * _Nullable error) {
        if (!error) {
            TTGCHUD_SUCCESS(@"success")
            self->userModel = userInfo;
            [self freshUserInfo:self->userModel];
        } else {
            //error info
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (void)freshUserInfo:(TTGCUserModel *)model {
    if (model.userId) {
        self.userIdLabel.text = model.userId;
    }
    if (model.photoUrl) {
        NSURL *url = [[NSURL alloc] initWithString:model.photoUrl];
        [self.photoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_icon_default"]];
    } else {
        self.photoImageView.image = [UIImage imageNamed:@"user_icon_default"];
    }
    if (model.nickname) {
        self.nicknameLabel.text = model.nickname;
    }
    
    if (model.userType == TTGCLoginType_TTk) {
        self.acountType.text = @"ToTok";
    } else if (model.userType == TTGCLoginType_GameCenter) {
        self.acountType.text = @"GameCenter";
    } else if (model.userType == TTGCLoginType_Facebook) {
        self.acountType.text = @"Facebook";
    } else if (model.userType == TTGCLoginType_Guest) {
        self.acountType.text = @"Guest";
    } else if (model.userType == TTGCLoginType_Apple) {
        self.acountType.text = @"Apple";
    } else if (model.userType == TTGCLoginType_Twitter) {
        self.acountType.text = @"Twitter";
    } else {
        self.acountType.text = @"Unknow";
    }
    
}

- (void)closeLoginView {
    [self getUserInfo];
}

- (IBAction)logout:(id)sender {
    TTGCHUD_NO_Stop(@"logout...")
    [[TTkGameManager defaultManager] logout:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            TTGCHUD_SUCCESS(@"success")
            [self showLoginView];
        } else {
            NSLog(@"%@",error.userInfo);
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            red = 0 ; green = 0 ; blue = 0; alpha = 1;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}



@end
