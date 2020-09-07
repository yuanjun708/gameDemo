//
//  AboutViewController.m
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/3/26.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "AboutViewController.h"
#import <TTkGameSDK/TTkGameSDK.h>
#import "Header.h"
#import "TGWebViewController.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation AboutViewController
{
    NSString *webtitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navHeight.constant = Nav_StatusBar_Height;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)agreement:(id)sender {
    [[TTkGameManager defaultManager] showAgreementView];
}

- (IBAction)privicy:(id)sender {
}

- (IBAction)home:(id)sender {
    
}

- (void)openWebView:(NSString *)url {
    TGWebViewController *vc = [[TGWebViewController alloc] init];
    vc.navTitle = webtitle;
    vc.url = [[NSURL alloc] initWithString:url];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)version:(id)sender {
    [[TTkGameManager defaultManager] checkAppVersionCompletion:^(BOOL hasNewVersion, TTGCAppVersionModel * _Nullable versionInfo, NSError * _Nullable error) {
        self.versionLabel.text = versionInfo.currentVersionCode;
        if (!hasNewVersion) {
            TTGCHUD_HINT(@"Already the latest version");
        } else {
            BOOL forceUpdate = versionInfo.forceUpdate;
            if (forceUpdate) {
                // If you need to force update, you cannot continue to use it, and you need to jump to the appstore to update.
                // Open appstore
                [[TTkGameManager defaultManager] openAppStoreWithStoreIdentifier:@"xxx"];
                
            } else {
                // If update is not required, you can optionally prompt for an upgrade.
            }
        }
    }];
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
