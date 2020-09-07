//
//  DCLogView.m
//  DCLogViewDemo
//
//  Created by DarielChen https://github.com/DarielChen/DCLog
//  Copyright © 2016年 DarielChen. All rights reserved.
//

#import "DCLogView.h"
#import "DCLog.h"
#import <TTkGameSDK/TTkGameSDK.h>

#pragma mark - 导航栏，状态栏，TabBar的高度
#define StatusBar_Height [UIApplication sharedApplication].statusBarFrame.size.height
#define NavBar_Height 44.0
#define Nav_StatusBar_Height (NavBar_Height + StatusBar_Height)
#define TabBar_Height ([UIApplication sharedApplication].statusBarFrame.size.height > 20 ? 83 : 49)
#define KBottomSpace_Height ([UIApplication sharedApplication].statusBarFrame.size.height > 20 ? 34 : 0)

@interface DCLogView()

@property (nonatomic, strong) UITextView *logTextView;
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UIButton *cleanButton;
@property (nonatomic, strong) UIButton *pasteButton;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, assign) NSInteger segmentIndex;

@end

@implementation DCLogView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    self.logTextView = [[UITextView alloc] init];
    self.logTextView.backgroundColor = [UIColor colorWithRed:39/255.0 green:40/255.0 blue:34/255.0 alpha:1.0];
    self.logTextView.textColor = [UIColor whiteColor];
    self.logTextView.font = [UIFont systemFontOfSize:14.0];
    self.logTextView.editable = NO;
    self.logTextView.layoutManager.allowsNonContiguousLayout = NO;
    [self addSubview:self.logTextView];
    
    NSArray *segmentArray = @[@"Normal",@"Crash"];
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:segmentArray];
    self.segmentControl.selectedSegmentIndex = 0;
    self.segmentIndex = 0;
    [self.segmentControl addTarget:self action:@selector(didClickSegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.segmentControl];
    
    self.cleanButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cleanButton.layer.cornerRadius = 5.0f;
    self.cleanButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.cleanButton setTitle:@"Clean" forState:UIControlStateNormal];
    [self.cleanButton addTarget:self action:@selector(cleanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.cleanButton.layer.borderWidth = 1.0f;
    self.cleanButton.layer.borderColor = [UIColor colorWithRed:12/255.0 green:95/255.0 blue:250/255.0 alpha:1.0].CGColor;
    [self addSubview:self.cleanButton];
    
    self.pasteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.pasteButton.layer.cornerRadius = 5.0f;
    self.pasteButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.pasteButton setTitle:@"Copy" forState:UIControlStateNormal];
    [self.pasteButton addTarget:self action:@selector(copyText) forControlEvents:UIControlEventTouchUpInside];
    self.pasteButton.layer.borderWidth = 1.0f;
    self.pasteButton.layer.borderColor = [UIColor colorWithRed:12/255.0 green:95/255.0 blue:250/255.0 alpha:1.0].CGColor;
    [self addSubview:self.pasteButton];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];;
    [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
}

- (void)updateLog:(NSString *)logText {
    if (self.logTextView.contentSize.height <= (self.logTextView.contentOffset.y + CGRectGetHeight(self.bounds))) {
        self.logTextView.text = logText;
        [self.logTextView scrollRangeToVisible:NSMakeRange(self.logTextView.text.length, 1)];
    }else {
        self.logTextView.text = logText;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.logTextView.frame = CGRectMake(0, Nav_StatusBar_Height, self.bounds.size.width, self.bounds.size.height-Nav_StatusBar_Height-KBottomSpace_Height);
    
    self.segmentControl.frame = CGRectMake(50, 0, 150, 30.0);
    self.segmentControl.center= CGPointMake(self.segmentControl.center.x, 42.0);
    
    self.cleanButton.frame = CGRectMake(self.bounds.size.width-16-50, 0, 50.0, 30.0);
    self.cleanButton.center = CGPointMake(self.cleanButton.center.x, 42.0);
    
    self.pasteButton.frame = CGRectMake(self.bounds.size.width-16-50-60, 0, 50.0, 30.0);
    self.pasteButton.center = CGPointMake(self.pasteButton.center.x, 42.0);
    
    self.backButton.frame = CGRectMake(0, StatusBar_Height, 44, 44);
}

- (void)cleanButtonClick {
    
    if (_CleanButtonIndexBlock) {
        _CleanButtonIndexBlock(self.segmentIndex);
    }
}

- (void)didClickSegmentedControlAction:(UISegmentedControl *)control {
    if (_indexBlock) {
        _indexBlock(control.selectedSegmentIndex);
    }
    self.segmentIndex = control.selectedSegmentIndex;
}

- (void)copyText {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.logTextView.text;
    TTGCHUD_HINT(@"copied");
}

- (void)back {
    [DCLog changeVisible];
}

@end
