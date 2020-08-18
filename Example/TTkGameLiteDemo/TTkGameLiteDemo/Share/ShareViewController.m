//
//  ShareViewController.m
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/3/26.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "ShareViewController.h"
#import "Header.h"
#import "FriendsListViewController.h"

@interface ShareViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gameInviteHeight;
@property (weak, nonatomic) IBOutlet UIView *gameInviteView;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navHeight.constant = Nav_StatusBar_Height;
    if (self.userType == TTGCLoginType_Facebook) {
        self.gameInviteHeight.constant = 60;
        self.gameInviteView.hidden = NO;
    } else {
        self.gameInviteHeight.constant = 0;
        self.gameInviteView.hidden = YES;
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)friendsList:(id)sender {
    FriendsListViewController *vc = [[FriendsListViewController alloc] init];
    vc.isPlaying = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)playingFriendsList:(id)sender {
    FriendsListViewController *vc = [[FriendsListViewController alloc] init];
    vc.isPlaying = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)walink:(id)sender {
}

- (IBAction)wapic:(id)sender {
}

- (IBAction)fbGameInviteFriends:(id)sender {
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
