//
//  JWCollectionViewLayout.m
//  JWDate
//
//  Created by 丽泽 on 2019/6/14.
//  Copyright © 2019年 lize. All rights reserved.
//

#import "JWCollectionViewLayout.h"

// 本类主要是针对瀑布流的
@implementation JWCollectionViewLayout {
    
    NSMutableArray *_layoutAttriArr;
    NSMutableArray *_originYArr;
    NSInteger _collectViewRowCount;
    NSMutableArray <UICollectionViewLayoutAttributes *> *layoutArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _layoutAttriArr = [NSMutableArray new];
        _originYArr = [NSMutableArray new];
        _collectViewRowCount = 3; //
    }
    return self;
}

- (void)prepareLayout
{
    // 准备数据 对每一个cell进行初始化
    // 先清空原有数据
    [_layoutAttriArr removeAllObjects];
    [_originYArr removeAllObjects];
    
    // 添加@（0） 数量 _collectViewRowCount
    for (int i = 0; i < _collectViewRowCount; i++) {
        [_originYArr addObject:@(0)];
    }
    // row
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < cellCount; i++) {
        // 初始化每一个cell的布局属性
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];

        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [_layoutAttriArr addObject:attributes];
    }
}

// 可以用自己的
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    float cellSizeWidth = [UIScreen mainScreen].bounds.size.width/_collectViewRowCount;
    
    // 如果这个cell是一个图片内容，那么就返回图片宽高
    float cellSizeHeight = 50 + arc4random_uniform(100); // 通过indexPath 计算出cell 的响应高度
    
    float cellX = cellSizeWidth * (indexPath.row%_collectViewRowCount);
    
    float cellY = [_originYArr[indexPath.row%3] floatValue];
    _originYArr[indexPath.row%_collectViewRowCount] = @(cellY + cellSizeHeight);
    attributes.frame = CGRectMake(cellX, cellY, cellSizeWidth, cellSizeHeight);
    
    return attributes;
}

- (CGSize)collectionViewContentSize {
    float maxHeight = [_originYArr[0] floatValue];
    for (int i = 1; i < _collectViewRowCount; i++) {
        if (maxHeight < [_originYArr[i] floatValue]) {
            maxHeight = [_originYArr[i] floatValue];
        }
    }
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, maxHeight);
    return size;
}

- (nullable NSArray <__kindof UICollectionViewLayoutAttributes *>*)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _layoutAttriArr;
}

@end
