//
//  FriendsListViewController.m
//
//  Created by Balalaika on 2020/2/19.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "FriendsListViewController.h"
#import <SDWebImage/SDWebImage.h>
#import "FriendTableViewCell.h"
#import "Header.h"

@interface FriendsListViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FriendsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navHeight.constant = Nav_StatusBar_Height;
    [self setupTableView];
    [self loadData];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupTableView {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"FriendTableViewCell"];
}

- (void)loadData {
    if (self.isPlaying) {
        if (self.isBotim) {
            [[TTkGameManager defaultManager] getPlayingFriendsFromBotimCompletion:^(NSArray * _Nullable list, NSError * _Nullable error) {
                if (!error) {
                    self.dataArray = list.mutableCopy;
                    [self.tableView reloadData];
                } else {
                    TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
                }
            }];
        } else {
            [[TTkGameManager defaultManager] getPlayingFriendsFromServerCompletion:^(NSArray * _Nullable list, NSError * _Nullable error) {
                if (!error) {
                    self.dataArray = list.mutableCopy;
                    [self.tableView reloadData];
                } else {
                    TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
                }
            }];
        }
    } else {
        if (self.isBotim) {
            [[TTkGameManager defaultManager] getFriendsFromBotimCompletion:^(NSArray * _Nullable list, NSError * _Nullable error) {
                if (!error) {
                    self.dataArray = list.mutableCopy;
                    [self.tableView reloadData];
                } else {
                    TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
                }
            }];
        } else {
            [[TTkGameManager defaultManager] getFriendsFromServerCompletion:^(NSArray * _Nullable list, NSError * _Nullable error) {
                if (!error) {
                    self.dataArray = list.mutableCopy;
                    [self.tableView reloadData];
                } else {
                    TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
                }
            }];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendTableViewCell"];
    
    if (self.isPlaying) {
        if (self.isBotim) {
            TTGCBotimPlayingFriendModel *model = self.dataArray[indexPath.row];
            cell.nameLabel.text = model.name;
            cell.ttkUidLabel.text = model.bimUid;
            [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"user_icon_default"] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {}];
        } else {
            TTGCPlayingFriendModel *model = self.dataArray[indexPath.row];
            cell.nameLabel.text = model.name;
            cell.ttkUidLabel.text = model.ttkUid;
            [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"user_icon_default"] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {}];
        }
    } else {
        if (self.isBotim) {
            TTGCBotimFriendModel *model = self.dataArray[indexPath.row];
            cell.nameLabel.text = model.name;
            cell.ttkUidLabel.text = model.bimUid;
            [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"user_icon_default"] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {}];
        } else {
            TTGCFriendModel *model = self.dataArray[indexPath.row];
            cell.nameLabel.text = model.name;
            cell.ttkUidLabel.text = model.ttkUid;
            [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"user_icon_default"] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {}];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *uid = @"";
    if (self.isPlaying) {
        if (self.isBotim) {
            TTGCBotimPlayingFriendModel *model = self.dataArray[indexPath.row];
            uid = model.bimUid;
        } else {
            TTGCPlayingFriendModel *model = self.dataArray[indexPath.row];
            uid = model.ttkUid;
        }
    } else {
        if (self.isBotim) {
            TTGCBotimFriendModel *model = self.dataArray[indexPath.row];
            uid = model.bimUid;
        } else {
            TTGCFriendModel *model = self.dataArray[indexPath.row];
            uid = model.ttkUid;
        }
    }
    
    if (self.isDrift) {
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Please select the type of message you want to send" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Invite" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self inviteFriend:uid];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Notice" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sendNoticeToFriend:uid];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)inviteFriend:(NSString *)uid {
    if (self.isBotim) {
        [self sendBotimMessageToFriend:uid];
        return;
    }
    TTGCSocialTTkInvite *model = [[TTGCSocialTTkInvite alloc] init];
    model.ttkUid = uid;
    model.contentString = @"come and join us";
    model.buttonTitle = @"Accept";
    model.imageUrl = @"http://t8.baidu.com/it/u=1484500186,1503043093&fm=79&app=86&f=JPEG?w=1280&h=853";
}

- (void)sendNoticeToFriend:(NSString *)uid {
    if (self.isBotim) {
        [self sendBotimMessageToFriend:uid];
        return;
    }
    TTGCSocialTTkNotice *model = [[TTGCSocialTTkNotice alloc] init];
    model.ttkUid = uid;
    model.contentString = @"come and join us";
    model.title = @"play game";
    model.imageUrl = @"http://t8.baidu.com/it/u=1484500186,1503043093&fm=79&app=86&f=JPEG?w=1280&h=853";
}

- (void)sendBotimMessageToFriend:(NSString *)uid {
    TTGCSocialBimMessage *model = [[TTGCSocialBimMessage alloc] init];
    model.bimUid = uid;
    model.contentString = @"come and join us";
    model.title = @"play game";
    model.imageUrl = @"http://t8.baidu.com/it/u=1484500186,1503043093&fm=79&app=86&f=JPEG?w=1280&h=853";
    [[TTkGameManager defaultManager] sendToMessageToBotim:model Completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            TTGCHUD_SUCCESS(@"sent the message");
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
