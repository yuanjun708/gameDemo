//
//  DFTFinishViewController.m
//  AmuseGameDemo
//
//  Created by Balalaika on 2020/8/27.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "DFTFinishViewController.h"
#import <TTkGameSDK/TTkGameSDK.h>
#import "Header.h"

#import <objc/message.h>

@interface DFTFinishViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;

@end

@implementation DFTFinishViewController
{
    TTGCDriftManager *manager;
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
    [manager getRoomInfoEndGame:^(id  _Nullable room, NSError * _Nullable error) {
        if (room) {
            TTGCDriftRoomModel *roomModel = (TTGCDriftRoomModel *)room;
            NSMutableString *text = [NSString stringWithFormat:@"%@",[self ttgc_description:roomModel]].mutableCopy;
            
            for (TTGCDriftRoomUserModel *user in roomModel.userList) {
                NSString *userString = [NSString stringWithFormat:@"%@",[self ttgc_description:user]];
                [text appendFormat:@"\nuser:%@",userString];
            }
            self.contentText.text = text;
        }
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
