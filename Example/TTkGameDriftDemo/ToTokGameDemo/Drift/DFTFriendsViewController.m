//
//  DFTFriendsViewController.m
//  AmuseGameDemo
//
//  Created by Balalaika on 2020/9/1.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "DFTFriendsViewController.h"
#import <SDWebImage/SDWebImage.h>
#import <TTkGameSDK/TTkGameSDK.h>
#import "FriendTableViewCell.h"
#import "Header.h"

@interface DFTFriendsViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DFTFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navHeight.constant = Nav_StatusBar_Height;
    [self setupTableView];
    [self loadData];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)edit:(id)sender {
    NSString *title = @"";
    if ([self.editButton.titleLabel.text isEqualToString:@"Select"]) {
        title = @"Create";
        [self.tableView setEditing:YES animated:YES];
    } else {
        title = @"Select";
        if (self.friendsList) {
            self.friendsList([self selectedFriends]);
        }
        [self.tableView setEditing:NO animated:YES];
        [self back:nil];
    }
    [self.editButton setTitle:title forState:UIControlStateNormal];
}

- (NSArray *)selectedFriends {
    if (self.tableView.indexPathsForSelectedRows.count<1) {
        return @[];
    }
    NSMutableArray *list = [NSMutableArray array];
    for (NSIndexPath *path in self.tableView.indexPathsForSelectedRows) {
        TTGCDriftFriendsModel *model = self.dataArray[path.row];
        [list addObject:model];
    }
    return list.copy;
}

- (void)setupTableView {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"FriendTableViewCell"];
}

- (void)loadData {
    [[TTGCDriftManager defaultManager] getPlayingFriends:^(id  _Nullable list, NSError * _Nullable error) {
        if (list) {
            self.dataArray = ((NSArray *)list).mutableCopy;
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendTableViewCell"];
    
    TTGCDriftFriendsModel *model = self.dataArray[indexPath.row];
    cell.nameLabel.text = model.nickName;
    cell.ttkUidLabel.text = model.thirdUid;
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"user_icon_default"] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {}];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!tableView.isEditing) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
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
