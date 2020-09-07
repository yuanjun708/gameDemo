//
//  DFTLaunchViewController.m
//  AmuseGameDemo
//
//  Created by Balalaika on 2020/8/27.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "DFTLaunchViewController.h"
#import <TTkGameSDK/TTkGameSDK.h>
#import "Header.h"

#import "DFTRoomViewController.h"
#import "DFTFriendsViewController.h"

@interface DFTLaunchViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation DFTLaunchViewController
{
    TTGCDriftManager *manager;
    TTGCDriftRoomModel *invite_room;
    NSArray *userList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navHeight.constant = Nav_StatusBar_Height;
    manager = [TTGCDriftManager defaultManager];
    [self loadData];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData {
    //发送邀请信息的设置
    NSString *titile = @"全民漂移";
    NSString *description = @"快来呀！漂移啦！";
    NSString *imgUrl = @"https://image.game.uc.cn/2015/8/18/10900994.jpg";
    manager.roomInviteTitle = titile;
    manager.roomInviteDescription = description;
    manager.roomInviteImageUrl = imgUrl;
    
    //上传我的车辆信息
    [manager uploadCarInfo:@"my-car" completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            //upload success
        }
    }];
    
    //获取个人信息
    [manager getUserInfo:^(id  _Nullable user, NSError * _Nullable error) {
        if (user) {
            TTGCDriftUserInfoModel *userModel = user;
        }
    }];
    
    //获取邀请自己游戏的房间列表（这里取了第一个弹出操作）
    [manager getInvitationList:^(id  _Nullable roomList, NSError * _Nullable error) {
        if (roomList) {
            if (((NSArray *)roomList).count>0) {
                self->invite_room = ((NSArray *)roomList).firstObject;
                [self alertView];
            }
        }
    }];
    
}

- (IBAction)createRoom:(id)sender {
    DFTFriendsViewController *vc = [[DFTFriendsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.friendsList = ^(NSArray * _Nonnull friends) {
        if (friends.count>0) {
            self->userList = friends;
            [self->manager createRoomWithUsers:self->userList completion:^(id  _Nullable room, NSError * _Nullable error) {
                if (room) {
                    DFTRoomViewController *vc = [[DFTRoomViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
        }
    };
}

- (void)alertView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"游戏邀请" message:@"来呀~来呀~" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"接受" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self->manager acceptGameInviteRoom:self->invite_room.roomId completion:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                DFTRoomViewController *vc = [[DFTRoomViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self->manager refuseGameInviteRoom:self->invite_room.roomId completion:^(BOOL success, NSError * _Nullable error) {
        }];
    }]];
    [self presentViewController:alertController animated:true completion:nil];
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
