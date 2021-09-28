//
//  TrackerViewController.m
//  AmuseGameDemo
//
//  Created by Balalaika on 2020/8/12.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "TrackerViewController.h"
#import <AmuseGameSDK/AmuseGameSDK.h>
#import "Header.h"

@interface TrackerViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;

@end

@implementation TrackerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navHeight.constant = Nav_StatusBar_Height;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)activity1:(id)sender {
    [[TTkGameManager defaultManager] tracker_event:TTGCTrackEvent_Activity withValues:@{TTGCTrackParamActivityId:@"activity1",
                                                                                        TTGCTrackParamActivityAction:@"click"}];
    TTGCHUD_SUCCESS(@"success")
}

- (IBAction)activity2:(id)sender {
    [[TTkGameManager defaultManager] tracker_event:TTGCTrackEvent_Activity withValues:@{TTGCTrackParamActivityId:@"activity2",
                                                                                        TTGCTrackParamActivityAction:@"click"}];
    TTGCHUD_SUCCESS(@"success")
}

- (IBAction)guide1:(id)sender {
    [[TTkGameManager defaultManager] tracker_event:TTGCTrackEvent_Guide withValues:@{TTGCTrackParamGuideId:@"guide_test1",
                                                                                     TTGCTrackParamGuideDetail:@"guide1"}];
    TTGCHUD_SUCCESS(@"success")
}

- (IBAction)guide2:(id)sender {
    [[TTkGameManager defaultManager] tracker_event:TTGCTrackEvent_Guide withValues:@{TTGCTrackParamGuideId:@"guide_test2",
                                                                                     TTGCTrackParamGuideDetail:@"guide2"}];
    TTGCHUD_SUCCESS(@"success")
}

- (IBAction)guide3:(id)sender {
    [[TTkGameManager defaultManager] tracker_event:TTGCTrackEvent_Guide withValues:@{TTGCTrackParamGuideId:@"guide_test3",
                                                                                     TTGCTrackParamGuideDetail:@"guide3"}];
    TTGCHUD_SUCCESS(@"success")
}

- (IBAction)guide4:(id)sender {
    [[TTkGameManager defaultManager] tracker_event:TTGCTrackEvent_GuideCompletion withValues:@{TTGCTrackParamGuideId:@"guide_test",
                                                                                               TTGCTrackParamGuideSuccess:@YES,
                                                                                               TTGCTrackParamGuideDetail:@"引导测试",}];
    TTGCHUD_SUCCESS(@"success")
}

- (IBAction)reward:(id)sender {
    [[TTkGameManager defaultManager] tracker_event:TTGCTrackEvent_Reward withValues:@{TTGCTrackParamRewardId:@"reward_222"}];
    TTGCHUD_SUCCESS(@"success")
}

- (IBAction)rank:(id)sender {
    [[TTkGameManager defaultManager] tracker_event:TTGCTrackEvent_Rank withValues:@{@"af_rank":@"R0"}];
    TTGCHUD_SUCCESS(@"success")
}

- (IBAction)vip:(id)sender {
    [[TTkGameManager defaultManager] tracker_event:TTGCTrackEvent_VipInfo withValues:@{TTGCTrackParamUserVip:@"Vip5"}];
    TTGCHUD_SUCCESS(@"success")
}

- (IBAction)ad:(id)sender {
    [[TTkGameManager defaultManager] tracker_event:TTGCTrackEvent_AdClick withValues:@{TTGCTrackParamAdId:@"ad_222"}];
    TTGCHUD_SUCCESS(@"success")
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
