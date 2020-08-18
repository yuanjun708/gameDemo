//
//  LoginViewController.m
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/4/17.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "LoginViewController.h"
#import "Header.h"
#import <TTkGameSDK/TTkGameSDK.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;

@property (weak, nonatomic) IBOutlet UIButton *twitterLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *botimLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *appleLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *gamecenterLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *guestLoginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.titleTop.constant = StatusBar_Height + 12;
    self.bottom.constant = KBottomSpace_Height + 25;
    self.appleLoginButton.layer.cornerRadius = 4.0;
    self.gamecenterLoginButton.layer.cornerRadius = 4.0;
    self.facebookLoginButton.layer.cornerRadius = 4.0;
    self.guestLoginButton.layer.cornerRadius = 4.0;
    self.botimLoginButton.layer.cornerRadius = 4.0;
    self.twitterLoginButton.layer.cornerRadius = 4.0;
}

- (IBAction)agreement:(id)sender {
    [[TTkGameManager defaultManager] showAgreementView];
}

- (IBAction)appleLogin:(id)sender {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
    [[TTkGameManager defaultManager] loginWithAppleCompletion:^(id  _Nonnull userInfo, NSError * _Nonnull error) {
        if (!error) {
            //login success
            TTGCHUD_SUCCESS(@"success")
            [weakSelf closeLoginView];
        } else {
            //error info
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (IBAction)gamecenterLogin:(id)sender {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
    [[TTkGameManager defaultManager] loginWithGameCenterCompletion:^(id  _Nonnull userInfo, NSError * _Nonnull error) {
        if (!error) {
            //login success
            TTGCHUD_SUCCESS(@"success")
            [weakSelf closeLoginView];
        } else {
            //error info
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (IBAction)facebookLogin:(id)sender {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
    [[TTkGameManager defaultManager] loginWithFacebookCompletion:^(id  _Nonnull userInfo, NSError * _Nonnull error) {
        if (!error) {
            //login success
            TTGCHUD_SUCCESS(@"success")
            [weakSelf closeLoginView];
        } else {
            //error info
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (IBAction)guestLogin:(id)sender {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
    [[TTkGameManager defaultManager] guestLoginCompletion:^(id  _Nonnull userInfo, NSError * _Nonnull error) {
        if (!error) {
            //login success
            TTGCHUD_SUCCESS(@"success");
            [weakSelf closeLoginView];
        } else {
            //error info
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (IBAction)botimLogin:(id)sender {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
    [[TTkGameManager defaultManager] loginWithBotimCompletion:^(id  _Nonnull userInfo, NSError * _Nonnull error) {
        if (!error) {
            //login success
            TTGCHUD_SUCCESS(@"success");
            [weakSelf closeLoginView];
        } else {
            //error info
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (IBAction)twitterLogin:(id)sender {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
    [[TTkGameManager defaultManager] loginWithTwitterCompletion:^(id  _Nonnull userInfo, NSError * _Nonnull error) {
        if (!error) {
            //login success
            TTGCHUD_SUCCESS(@"success")
            [weakSelf closeLoginView];
        } else {
            //error info
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
        }
    }];
}

- (void)closeLoginView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"login_success" object:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
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
