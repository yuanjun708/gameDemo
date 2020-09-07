//
//  DFTRoomViewController.m
//  AmuseGameDemo
//
//  Created by Balalaika on 2020/8/27.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "DFTRoomViewController.h"
#import <TTkGameSDK/TTkGameSDK.h>
#import "Header.h"

#import <objc/message.h>

#import "DFTFinishViewController.h"

@interface DFTRoomViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;

@property (nonatomic, strong) NSTimer *queryTimer;
@property (nonatomic) CGFloat queryTime;

@property (weak, nonatomic) IBOutlet UILabel *roomNum;
@property (weak, nonatomic) IBOutlet UILabel *roomStatus;
@property (weak, nonatomic) IBOutlet UILabel *roomOwnerNum;
@property (weak, nonatomic) IBOutlet UILabel *roomOwnerScore;
@property (weak, nonatomic) IBOutlet UILabel *player1Num;
@property (weak, nonatomic) IBOutlet UILabel *player1Score;
@property (weak, nonatomic) IBOutlet UILabel *player2Num;
@property (weak, nonatomic) IBOutlet UILabel *player2Score;

@end

@implementation DFTRoomViewController
{
    TTGCDriftManager *manager;
    int score;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navHeight.constant = Nav_StatusBar_Height;
    manager = [TTGCDriftManager defaultManager];
    score = 0;
    [self loadData];
    [self updateUI];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [manager closeRoom];
}

- (void)updateUI {
    TTGCDriftRoomModel *room = [TTGCDriftManager defaultManager].roomModel;
    int roomStatus = [room.state intValue];
    NSString *status = @"";
    switch (roomStatus) {
        case 0:
            self.startButton.hidden = NO;
            self.endButton.hidden = YES;
            status = @"等待中";
            break;
        case 1:
            self.startButton.hidden = YES;
            self.endButton.hidden = NO;
            status = @"游戏中";
            break;
        case 2:
            self.startButton.hidden = YES;
            self.endButton.hidden = NO;
            status = @"游戏结束";
            break;
        default:
            self.startButton.hidden = NO;
            self.endButton.hidden = YES;
            break;
    }
    self.roomNum.text = room.roomId;
    self.roomStatus.text = status;
    for (TTGCDriftRoomUserModel *user in room.userList) {
        if ([user.userId isEqualToString:room.homeowner]) {
            self.roomOwnerNum.text = user.userId;
            self.roomOwnerScore.text = user.score;
            continue;
        } else if (room.userList.count>1) {
            self.player1Num.text = user.userId;
            self.player1Score.text = user.score;
            continue;
        } else if (room.userList.count>2) {
            self.player2Num.text = user.userId;
            self.player2Score.text = user.score;
            continue;
        }
    }
}

- (void)loadData {
    [manager getRoomInfoInWaiting:^(id  _Nullable room, NSError * _Nullable error) {
        if (room) {
            TTGCDriftRoomModel *roomModel = (TTGCDriftRoomModel *)room;
            NSMutableString *text = [NSString stringWithFormat:@"%@",[self ttgc_description:roomModel]].mutableCopy;
            
            for (TTGCDriftRoomUserModel *user in roomModel.userList) {
                NSString *userString = [NSString stringWithFormat:@"%@",[self ttgc_description:user]];
                [text appendFormat:@"\nuser:%@",userString];
            }
            self.contentText.text = text;
        }
        [self updateUI];
    }];
}

- (IBAction)start:(id)sender {
    [manager startGame:^(id  _Nullable room, NSError * _Nullable error) {
        if (room) {
            TTGCDriftRoomModel *roomModel = (TTGCDriftRoomModel *)room;
            NSMutableString *text = [NSString stringWithFormat:@"%@",[self ttgc_description:roomModel]].mutableCopy;
            
            for (TTGCDriftRoomUserModel *user in roomModel.userList) {
                NSString *userString = [NSString stringWithFormat:@"%@",[self ttgc_description:user]];
                [text appendFormat:@"\nuser:%@",userString];
            }
            self.contentText.text = text;
        }
        [self updateUI];
    }];
    [self startQuering];
}

- (void)startQuering {
    [self stopQuering];
    self.queryTime = 0;
    self.queryTimer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(uploadScore) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.queryTimer forMode:NSDefaultRunLoopMode];
}

- (void)stopQuering {
    [self.queryTimer invalidate];
    self.queryTimer = nil;
    self.queryTime = 0;
}

- (void)uploadScore {
    score += (arc4random() % 100);
    [manager updateScore:[NSString stringWithFormat:@"%d",score] completion:^(id  _Nullable room, NSError * _Nullable error) {
        if (room) {
            TTGCDriftRoomModel *roomModel = (TTGCDriftRoomModel *)room;
            NSMutableString *text = [NSString stringWithFormat:@"%@",[self ttgc_description:roomModel]].mutableCopy;
            
            for (TTGCDriftRoomUserModel *user in roomModel.userList) {
                NSString *userString = [NSString stringWithFormat:@"%@",[self ttgc_description:user]];
                [text appendFormat:@"\nuser:%@",userString];
            }
            self.contentText.text = text;
        }
        [self updateUI];
    }];
}

- (IBAction)end:(id)sender {
    [self stopQuering];
    [manager endGameScore:[NSString stringWithFormat:@"%d",score] completion:^(id  _Nullable room, NSError * _Nullable error) {
        if (room) {
            TTGCDriftRoomModel *roomModel = (TTGCDriftRoomModel *)room;
            NSMutableString *text = [NSString stringWithFormat:@"%@",[self ttgc_description:roomModel]].mutableCopy;
            
            for (TTGCDriftRoomUserModel *user in roomModel.userList) {
                NSString *userString = [NSString stringWithFormat:@"%@",[self ttgc_description:user]];
                [text appendFormat:@"\nuser:%@",userString];
            }
            self.contentText.text = text;
            DFTFinishViewController *vc = [[DFTFinishViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        [self updateUI];
    }];
}

- (NSString *)ttgc_description:(id)model{
    //判断是否时NSArray 或者NSDictionary NSNumber 如果是的话直接返回 debugDescription
    if ([model isKindOfClass:[NSArray class]] || [model isKindOfClass:[NSDictionary class]] || [model isKindOfClass:[NSString class]] || [model isKindOfClass:[NSNumber class]]) {
        return [model debugDescription];
    }
    //声明一个字典
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    //得到当前class的所有属性
    uint count;
    objc_property_t *properties = class_copyPropertyList([model class], &count);
    
    //循环并用KVC得到每个属性的值
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [model valueForKey:name]?:@"nil";//默认值为nil字符串
        [dictionary setObject:value forKey:name];//装载到字典里
    }
    
    //释放
    free(properties);
    
    //return
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[model class],model,dictionary];
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
