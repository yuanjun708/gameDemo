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

#import <GameKit/GameKit.h>
#import <AuthenticationServices/AuthenticationServices.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <TwitterKit/TWTRKit.h>

@interface LoginViewController () <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;

@property (weak, nonatomic) IBOutlet UIButton *appleLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *gamecenterLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *guestLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterLoginButton;

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
    self.twitterLoginButton.layer.cornerRadius = 4.0;
}

- (IBAction)agreement:(id)sender {
    [[TTkGameManager defaultManager] showAgreementView];
}

- (IBAction)appleLogin:(id)sender {
    TTGCHUD_NO_Stop(@"login...")
    [self appleAuthrization];
}

- (IBAction)gamecenterLogin:(id)sender {
    TTGCHUD_NO_Stop(@"login...")
    [self authenticateLocalPlayer];
}

//facebook
- (IBAction)facebookLogin:(id)sender {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
    FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
        if ([FBSDKAccessToken currentAccessToken]) {
             [manager logOut];
        }
        [manager logInWithPermissions:@[@"email",@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
            
            if (error) {
                
            } else {
                TTGCFacebookLoginParaModel *model = [[TTGCFacebookLoginParaModel alloc] init];
                model.accessToken = result.token.tokenString;
                model.accessExpire = result.token.expirationDate;
                [[TTkGameManager defaultManager] loginWithThirdPartParaModel:model Completion:^(id  _Nullable userInfo, NSError * _Nullable error) {
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
        }];
}

- (IBAction)guestLogin:(id)sender {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
}

- (IBAction)totokLogin:(id)sender {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
}

//twitter
- (IBAction)twitterLogin:(id)sender {
    TTGCHUD_NO_Stop(@"login...")
    __weak __typeof(self)weakSelf = self;
    
    [[Twitter sharedInstance] logInWithViewController:self completion:^(TWTRSession *session, NSError *error) {
      if (session) {
          TTGCTwitterLoginParaModel *model = [[TTGCTwitterLoginParaModel alloc] init];
          model.authToken = session.authToken;
          model.authTokenSecret = session.authTokenSecret;
          model.userID = session.userID;
          
          [[TTkGameManager defaultManager] loginWithThirdPartParaModel:model Completion:^(id  _Nullable userInfo, NSError * _Nullable error) {
              if (!error) {
                  //login success
                  TTGCHUD_SUCCESS(@"success");
                  [weakSelf closeLoginView];
              } else {
                  //error info
                  TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
              }
          }];
      } else {
          NSString *str = [NSString stringWithFormat:@"%@",error.description];
          TTGCHUD_HINT(str);
      }
    }];
}

- (void)closeLoginView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"login_success" object:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

//gamecenter
- (void)authenticateLocalPlayer {
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    __weak __typeof(localPlayer)weakLocalPlayer = localPlayer;
    
    if (localPlayer.isAuthenticated == YES) {
        [self authenticatedPlayer: localPlayer];
        return;
    }
    
    localPlayer.authenticateHandler = ^(UIViewController * _Nullable viewController, NSError * _Nullable error) {
        if (viewController != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
        } else if (weakLocalPlayer.isAuthenticated) {
            [self authenticatedPlayer: weakLocalPlayer];
        } else {
            if (error) {
                NSLog(@"%@",error.description);
            }
        }
    };
    if (!localPlayer.isAuthenticated) {
    }
}

//gamecenter
- (void)authenticatedPlayer:(GKLocalPlayer *)localPlayer {
    __weak __typeof(self)weakSelf = self;
    __block NSData *photoData = nil;
    [localPlayer loadPhotoForSize:GKPhotoSizeNormal withCompletionHandler:^(UIImage * _Nullable photo, NSError * _Nullable error) {
        if (photo != nil) {
            photoData = UIImageJPEGRepresentation(photo, 0.3);
        }
        
        [localPlayer generateIdentityVerificationSignatureWithCompletionHandler:^(NSURL * _Nullable publicKeyUrl, NSData * _Nullable signature, NSData * _Nullable salt, uint64_t timestamp, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@",error.description);
                return;
            }
            
            TTGCGameCenterLoginParaModel *model = [[TTGCGameCenterLoginParaModel alloc] init];
            model.playerID = localPlayer.playerID;
            model.displayName = localPlayer.displayName;
            model.publicKeyUrl = publicKeyUrl;
            model.signature = signature;
            model.salt = salt;
            model.timestamp = timestamp;
            model.photoData = photoData;
            
            [[TTkGameManager defaultManager] loginWithThirdPartParaModel:model Completion:^(id  _Nullable userInfo, NSError * _Nullable error) {
                if (!error) {
                    //login success
                    TTGCHUD_SUCCESS(@"success");
                    [weakSelf closeLoginView];
                } else {
                    //error info
                    TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
                }
            }];
        }];
    }];
}


//appleid
- (void)appleAuthrization {
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
        ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
        request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        
        ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
        controller.delegate = self;
        controller.presentationContextProvider = self;
        [controller performRequests];
    } else {
        TTGCHUD_HINT(@"This feature is not supported in the current system version.");
    }
}

#pragma mark - Delegate
//appleid
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization  API_AVAILABLE(ios(13.0)) {
        
    __weak __typeof(self)weakSelf = self;
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential *appleIDCredential = (ASAuthorizationAppleIDCredential *)authorization.credential;
        
        TTGCAppleIDLoginParaModel *model = [[TTGCAppleIDLoginParaModel alloc] init];
        model.user = appleIDCredential.user;
        if (appleIDCredential.fullName) {
            model.familyName = appleIDCredential.fullName.familyName;
            model.givenName = appleIDCredential.fullName.givenName;
        }
        model.identityToken = appleIDCredential.identityToken;
        [[TTkGameManager defaultManager] loginWithThirdPartParaModel:model Completion:^(id  _Nullable userInfo, NSError * _Nullable error) {
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
}

//! 授权失败的回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  API_AVAILABLE(ios(13.0)) {
    
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"User cancels authorization request";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"Failed authorization request";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"Invalid response to request for authorization";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"Failure to process requests for authorization";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"Request for authorization failed for unknown reasons";
            break;
    }
    
    if (!errorMsg) {
        if (error.localizedDescription) {
            errorMsg = error.localizedDescription;
        }
    }
    
    if (errorMsg.length<1) {
        errorMsg = @"Failed authorization request";
    }
    TTGCHUD_HINT(errorMsg);
}

- (nonnull ASPresentationAnchor)presentationAnchorForAuthorizationController:(nonnull ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
    return self.view.window;
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
