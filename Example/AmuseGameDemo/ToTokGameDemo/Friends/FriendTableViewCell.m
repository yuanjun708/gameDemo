//
//  FriendTableViewCell.m
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/2/19.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "FriendTableViewCell.h"

@implementation FriendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.photoImage.layer.cornerRadius = 23;
    self.photoImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
