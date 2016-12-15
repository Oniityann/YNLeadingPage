//
//  ZYNLeadingPageCell.h
//  JPSConcept
//
//  Created by 郑一楠 on 2016/11/22.
//  Copyright © 2016年 YCSJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZYNEnterButtonClickHandler)(UIButton *button);

@interface ZYNLeadingPageCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) UIButton *enterButton;

- (void)setclickAction:(ZYNEnterButtonClickHandler)enterButtonClickHandler;

@end
