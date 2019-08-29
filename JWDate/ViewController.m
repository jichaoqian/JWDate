//
//  ViewController.m
//  JWDate
//
//  Created by 丽泽 on 2019/6/11.
//  Copyright © 2019年 lize. All rights reserved.
//

#import "ViewController.h"
#import "JWDateCell.h"
#import "JWDateModel.h"
#import "JWTestCollectViewController.h"
//#import "JWCollectionViewLayout.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    NSMutableArray *_dayArray; // 每个月的天数
    
    NSInteger _selectedYear;
    NSInteger _selectedMonth;
    NSInteger _selectedDay;
}
@property (nonatomic, strong) NSMutableArray <UIView *>*arr;
@property (nonatomic, strong) NSMutableArray <__kindof UIView *> *arr2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _dayArray = [NSMutableArray array];

    /**
     代码初始化的时候，一定要用 initWithFrame: collectionViewLayout 这个
     UICollectionviewLayout 不能直接初始化这个布局对象（必须实现他的子类）
     更复杂布局需要 自己写 UICollectionViewLayout 的子类（如瀑布流）
     */
//    _collectionView = [UICollectionView alloc] initWithFrame:(CGRect) collectionViewLayout:(nonnull UICollectionViewLayout *)
//    _collectionView setCollectionViewLayout:(UICollectionViewLayout * _Nonnull)
    
    [_collectionView registerNib:[UINib nibWithNibName:@"JWDateCell" bundle:nil] forCellWithReuseIdentifier:@"JWDateCell"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"JWDateHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JWDateHeadView"];
    
    // 更复杂的布局，如瀑布流，需要这里来设置
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0; // 左右间隔
    flowLayout.minimumLineSpacing = 0; // 上下间隔 既有这个，又写了代理的话，最后会根据代理中的设置来生成
    flowLayout.itemSize = CGSizeMake(kScreenWidth/7, kScreenWidth/7); // cell的大小
    flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, kScreenWidth/7);
    [_collectionView setCollectionViewLayout:flowLayout];
    
    [self dataHandle:[[NSDate date] description]];
    [self charReverse];
}

- (void)charReverse
{
    NSString * string2 = @"hello,nanyun!";
    NSLog(@"%@", string2);
    NSMutableString *reverSt = [NSMutableString stringWithString:string2];
    
    for (NSInteger i =  0; i< string2.length /2; i++) {
        [reverSt replaceCharactersInRange:NSMakeRange(i, 1) withString:[string2 substringWithRange:NSMakeRange(string2.length - i - 1, 1)]];
        [reverSt replaceCharactersInRange:NSMakeRange(string2.length - i -1, 1) withString:[string2 substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSLog(@"自己写的算法哈哈哈>>>%@", reverSt);
    
    // C的写法
    char cCh[100];
//    memcpy(<#void *__dst#>, <#const void *__src#>, <#size_t __n#>)
    memcpy(cCh, [string2 cStringUsingEncoding:NSUTF8StringEncoding], [string2 length]);
    
    // 设置两个指针，一个指向字符串开头，一个指向字符串末尾
    char * beginC = cCh;
    char *endC = cCh + strlen(cCh) - 1;
    // 遍历字符数组，逐步交换两个指针所指向的内容，同时移动指针到相对应的下个位置，直至begin>end
    while (beginC< endC) {
        char temp = *beginC;
        *(beginC++) = *endC;
        *(endC--) = temp;
    }
    NSLog(@"zizizjiizj>>>%s", cCh);
}

- (void)dataHandle:(NSString *)dateStr {
    [_dayArray removeAllObjects];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr2 = [formatter stringFromDate:[NSDate date]];
    
    // 补前面的空白 每个月第一天的日期？？？
//    NSInteger firstWeekDay = [JWDateModel weekDayMonthOfFirstDayFromDate:[NSDate date]];
    NSInteger firstWeekDay = [JWDateModel weekDayMonthOfFirstDayFromStr:dateStr2];
    for (int i = 0; i<firstWeekDay; i++) {
        [_dayArray addObject:@""];
    }
    
    NSInteger dayCount = [JWDateModel totalDaysInMonthFromDate:[NSDate date]];
    for (int i = 0; i<dayCount; i++) {
        [_dayArray addObject:@(i+1)];
    }
    
    // 补后面的空白 
    int leftDay = 0;
    if (!_dayArray.count%7) {
        leftDay = 7-_dayArray.count%7;
    }
    for (int i = 0; i< leftDay; i++) {
        [_dayArray addObject:@""];
    }

    
    [_collectionView reloadData];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[JWTestCollectViewController new] animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dayArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JWDateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JWDateCell" forIndexPath:indexPath];
    cell.textLabel.text = [_dayArray[indexPath.row] description];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JWDateHeadView" forIndexPath:indexPath];
        return headView;
    } else {
        return nil;
    }
    return nil;
}

// 点击选中日期
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[JWTestCollectViewController new] animated:YES];
}




@end
