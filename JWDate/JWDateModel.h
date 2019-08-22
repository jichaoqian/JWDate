//
//  JWDateModel.h
//  JWDate
//
//  Created by 丽泽 on 2019/6/13.
//  Copyright © 2019年 lize. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JWDateModel : NSObject {
    NSString *name;
}
@property (nonatomic, copy) NSString *name_next;
@property (nonatomic, strong) NSString *name_last;
+ (NSInteger)totalDaysInMonthFromStr:(NSString *)dateStr;
+ (NSInteger)totalDaysInMonthFromDate:(NSDate *)date;

+ (NSInteger)weekDayMonthOfFirstDayFromStr:(NSString *)dateStr;
+ (NSInteger)weekDayMonthOfFirstDayFromDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
