//
//  ZYNLeadingPage.h
//  JPSConcept
//
//  Created by 郑一楠 on 2016/11/22.
//  Copyright © 2016年 YCSJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYNLeadingPageCell.h"

typedef void(^ZYNLeadingPageCellHandler)(ZYNLeadingPageCell *cell, NSIndexPath *indexPath);
typedef void(^ZYNLeadingPageEnterHadler)(UIButton *button);

@interface ZYNLeadingPage : UIViewController

- (instancetype)initWithPages:(NSInteger)pageCount
              withCellHandler:(ZYNLeadingPageCellHandler)cellHandler
              andEnterHandler:(ZYNLeadingPageEnterHadler)enterHandler;

@property (nonatomic, weak) UIPageControl *pageControl;

@end
