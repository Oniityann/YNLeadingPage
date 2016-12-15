//
//  ZYNLeadingPage.m
//  JPSConcept
//
//  Created by 郑一楠 on 2016/11/22.
//  Copyright © 2016年 YCSJ. All rights reserved.
//

#import "ZYNLeadingPage.h"

@interface ZYNLeadingPage ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, copy) ZYNLeadingPageCellHandler cellHandler;
@property (nonatomic, copy) ZYNLeadingPageEnterHadler enterHandler;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger count;

@end

static NSString *const kZYNLeadingPageCellIdentifier = @"ZYNLeadingPageCell";

@implementation ZYNLeadingPage

- (instancetype)initWithPages:(NSInteger)pageCount withCellHandler:(ZYNLeadingPageCellHandler)cellHandler andEnterHandler:(ZYNLeadingPageEnterHadler)enterHandler {
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        
        _count = pageCount;
        
        if (_cellHandler != cellHandler) {
            _cellHandler = cellHandler;
        }
        
        if (_enterHandler != enterHandler) {
            _enterHandler = enterHandler;
        }
        
        [self.view addSubview:self.collectionView];
        [self.view addSubview:self.pageControl];
        
        [_collectionView registerClass:[ZYNLeadingPageCell class] forCellWithReuseIdentifier:kZYNLeadingPageCellIdentifier];
    }
    return self;
}

#pragma mark - collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYNLeadingPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kZYNLeadingPageCellIdentifier forIndexPath:indexPath];
    
    if (indexPath.item != self.count - 1) {
        
        cell.enterButton.hidden = YES;
        
    } else {
        cell.enterButton.hidden = NO;
        
        __weak typeof(self) weakSelf = self;
        [cell setclickAction:^(UIButton *button) {
            if (weakSelf.enterHandler) {
                weakSelf.enterHandler(button);
            }
        }];
    }
    
    if (self.cellHandler) {
        self.cellHandler(cell, indexPath);
    }
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5;
    if (self.pageControl.currentPage != currentPage) {
        self.pageControl.currentPage = currentPage;
    }
}

#pragma mark - lazy loading
- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = self.view.bounds.size;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = self.count;
        pageControl.currentPage = 0;
        CGSize pageControlSize = [pageControl sizeForNumberOfPages:self.count];
        CGFloat pageControlX = (self.view.bounds.size.width - pageControlSize.width) / 2;
        CGFloat pageControlY = (self.view.bounds.size.height - pageControlSize.height - 50.f);
        pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlSize.width, pageControlSize.height);
        _pageControl = pageControl;
    }
    return _pageControl;
}

@end
