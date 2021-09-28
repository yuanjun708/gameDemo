//
//  FriendTableViewCell.h
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/2/19.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ttkUidLabel;

@end

NS_ASSUME_NONNULL_END
