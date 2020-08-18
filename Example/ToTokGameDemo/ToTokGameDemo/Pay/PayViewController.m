//
//  PayViewController.m
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/3/26.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "PayViewController.h"
#import <TTkGameSDK/TTkGameSDK.h>
#import "Header.h"

@interface PayViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navHeight.constant = Nav_StatusBar_Height;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buy1:(id)sender {
    [self buy:@"ttgc_gold_coin_1"];
}

- (IBAction)buy2:(id)sender {
    [self buy:@"ttgc_gold_coin_2"];
}

- (IBAction)buy3:(id)sender {
    [self buy:@"ttgc_gold_coin_3"];
}

- (IBAction)buy4:(id)sender {
    [self buy:@"ttgc_gold_coin_4"];
}

- (IBAction)buy5:(id)sender {
    [self buy:@"ttgc_gold_coin_5"];
}

- (IBAction)buy6:(id)sender {
    [self buy:@"ttgc_gold_coin_6"];
}

- (void)buy:(NSString *)sku {
    TTGCHUD_NO_Stop(@"pay...")
    [[TTkGameManager defaultManager] buyProductWithSKU:sku Progress:^(TTGCOderStatus orderStatus) {
        NSLog(@"Order Status ：%ld",(long)orderStatus);
    } Completion:^(id  _Nullable orderInfo, NSError * _Nullable error) {
        if (orderInfo) {
            TTGCHUD_SUCCESS(@"success")
        }
        if (error) {
            NSLog(@"pay error : %@",error.userInfo);
            TTGCHUD_HINT([error.userInfo objectForKey:@"errorMsg"]);
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
