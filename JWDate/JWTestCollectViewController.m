//
//  JWTestCollectViewController.m
//  JWDate
//
//  Created by 丽泽 on 8/2/19.
//  Copyright © 2019 lize. All rights reserved.
//

#import "JWTestCollectViewController.h"
#import "JWDateCell.h"
#import "JWCollectionViewLayout.h"

@interface JWTestCollectViewController () {
    
    NSMutableArray *_colorAry;
}

@end

@implementation JWTestCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _colorAry = [NSMutableArray array];
    [_colorAry addObject:[UIColor whiteColor]];
    [_colorAry addObject:[UIColor blackColor]];
    [_colorAry addObject:[UIColor blueColor]];
    [_colorAry addObject:[UIColor redColor]];
    [_colorAry addObject:[UIColor yellowColor]];
    [_colorAry addObject:[UIColor orangeColor]];
    [_colorAry addObject:[UIColor purpleColor]];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"JWDateCell" bundle:nil] forCellWithReuseIdentifier:@"JWDateCell"];
    
    [_collectionView setCollectionViewLayout:[JWCollectionViewLayout new]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 80;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    JWDateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JWDateCell" forIndexPath:indexPath];
    cell.textLabel.text = [@(indexPath.row) description];
    cell.backgroundColor = [_colorAry objectAtIndex:indexPath.row%_colorAry.count];
    return cell;
}


@end
