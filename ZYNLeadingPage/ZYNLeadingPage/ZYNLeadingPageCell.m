//
//  ZYNLeadingPageCell.m
//  JPSConcept
//
//  Created by 郑一楠 on 2016/11/22.
//  Copyright © 2016年 YCSJ. All rights reserved.
//

#import "ZYNLeadingPageCell.h"

@interface ZYNLeadingPageCell ()

@property (nonatomic, copy) ZYNEnterButtonClickHandler enterButtonClickHandler;

@end

@implementation ZYNLeadingPageCell

- (void)initPrivate {
    self.bgView = [[UIImageView alloc] init];
    self.bgView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.enterButton];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initPrivate];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initPrivate];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initPrivate];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgView.frame = self.bounds;
    
    [self.enterButton sizeToFit];
    CGFloat margin = 10.f;
    CGFloat buttonW = self.enterButton.bounds.size.width + 2 * margin;
    CGFloat buttonH = self.enterButton.bounds.size.height + 2 * margin;
    CGFloat buttonX = (self.bounds.size.width - buttonW) * 0.5;
    CGFloat buttonY = self.bounds.size.height - buttonH - 100.f;
    self.enterButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
}

#pragma mark - lazy loading
- (UIButton *)enterButton {
    
    if (!_enterButton) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 10.f;
        [button addTarget:self action:@selector(enterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _enterButton = button;
    }
    return _enterButton;
}

#pragma mark - target / action
- (void)enterButtonClick:(UIButton *)button {
    if (self.enterButtonClickHandler) {
        self.enterButtonClickHandler(button);
    }
}

- (void)setclickAction:(ZYNEnterButtonClickHandler)enterButtonClickHandler {
    if (_enterButtonClickHandler != enterButtonClickHandler) {
        self.enterButtonClickHandler = enterButtonClickHandler;
    }
}

@end
