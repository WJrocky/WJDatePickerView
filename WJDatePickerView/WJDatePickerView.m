//
//  WJDatePickerView.m
//  WJDatePickerView
//
//  Created by 王健 on 16/1/4.
//  Copyright © 2016年 Rocky. All rights reserved.
//

#import "WJDatePickerView.h"

@interface WJDatePickerView ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstSeparateWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdSeparateWidth;

@property (strong, nonatomic) UIView *view;

@end

@implementation WJDatePickerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _view = [[[NSBundle mainBundle]loadNibNamed:@"WJDatePickerView" owner:self options:nil]lastObject];
        _view.frame = self.bounds;
        [self addSubview:_view];
        
        NSArray *yearArray = [self setUpDataSourceWithStartNumber:1970 EndNumber:2030];
        NSArray *monthArray = [self setUpDataSourceWithStartNumber:01 EndNumber:12];
        NSArray *dayArray = [self setUpDataSourceWithStartNumber:01 EndNumber:31];
        NSArray *hourArray = [self setUpDataSourceWithStartNumber:00 EndNumber:23];
        NSArray *minuteArray = [self setUpDataSourceWithStartNumber:00 EndNumber:59];
        NSArray *secondArray = [self setUpDataSourceWithStartNumber:00 EndNumber:59];
        
        _dataArray = @[yearArray,monthArray,dayArray,hourArray,minuteArray,secondArray];
        
        NSString *currentYear = [NSString stringWithFormat:@"%ld",[[self datePickerViewGetCurrentDateComponents] year]];
        NSString *currentMonth = [self changeFormatWithNumber:[[self datePickerViewGetCurrentDateComponents] month]];
        NSString *currentDay = [self changeFormatWithNumber:[[self datePickerViewGetCurrentDateComponents] day]];
        NSString *currentHour = [self changeFormatWithNumber:[[self datePickerViewGetCurrentDateComponents] hour]];
        NSString *currentMinute = [self changeFormatWithNumber:[[self datePickerViewGetCurrentDateComponents] minute]];
        NSString *currentSecond = [self changeFormatWithNumber:[[self datePickerViewGetCurrentDateComponents] second]];
        _selectedData = [NSMutableArray arrayWithObjects:currentYear,currentMonth,currentDay,currentHour,currentMinute,currentSecond, nil];
        
        NSInteger yearIndex = [yearArray indexOfObject:currentYear];
        NSInteger monthIndex = [monthArray indexOfObject:currentMonth];
        NSInteger dayIndex = [dayArray indexOfObject:currentDay];
        NSInteger hourIndex = [hourArray indexOfObject:currentHour];
        NSInteger minuteIndex = [minuteArray indexOfObject:currentMinute];
        NSInteger secondIndex = [secondArray indexOfObject:currentSecond];
        
        self.yearTableView.contentOffset = CGPointMake(0, (500 - 500%yearArray.count + yearIndex -1 )*44);
        self.monthTableView.contentOffset = CGPointMake(0, (500 - 500%monthArray.count + monthIndex - 1)*44);
        self.dayTableView.contentOffset = CGPointMake(0, (500 - 500%dayArray.count + dayIndex - 1)*44);
        self.hourTableView.contentOffset = CGPointMake(0, (500 - 500%hourArray.count + hourIndex -1)*44);
        self.minuteTableView.contentOffset = CGPointMake(0, (500 - 500%minuteArray.count + minuteIndex -1)*44);
        self.secondTableView.contentOffset = CGPointMake(0, (500 - 500%secondArray.count + secondIndex -1)*44);
    }
    return self;
}

- (void)showDatePickerViewWithType:(DatePickerType)type
{
    if (type == DatePicker_Year) {

        self.firstSeparate.text = @"年";
        [self.secondSeparate removeFromSuperview];
        [self.middleSeparate removeFromSuperview];
        [self.thirdSeparate removeFromSuperview];
        [self.fouthSeparate removeFromSuperview];
        [self.fifthSeparate removeFromSuperview];
        [self.monthTableView removeFromSuperview];
        [self.dayTableView removeFromSuperview];
        [self.hourTableView removeFromSuperview];
        [self.minuteTableView removeFromSuperview];
        [self.secondTableView removeFromSuperview];
        self.firstSeparateWidth.active = NO;
        
        //(w-(20+45))
        NSLayoutConstraint *firstSeparateWidth = [NSLayoutConstraint constraintWithItem:self.firstSeparate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:-65];
        [self.view addConstraint:firstSeparateWidth];
        
    } else if (type == DatePicker_Month) {

        self.firstSeparate.text = @"年";
        self.secondSeparate.text = @"月";
        [self.middleSeparate removeFromSuperview];
        [self.thirdSeparate removeFromSuperview];
        [self.fouthSeparate removeFromSuperview];
        [self.fifthSeparate removeFromSuperview];
        [self.dayTableView removeFromSuperview];
        [self.hourTableView removeFromSuperview];
        [self.minuteTableView removeFromSuperview];
        [self.secondTableView removeFromSuperview];
        self.firstSeparateWidth.active = NO;
        
        //(w-(20+45+24))/2
        NSLayoutConstraint *firstSeparateWidth = [NSLayoutConstraint constraintWithItem:self.firstSeparate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.5 constant:-44.5];
        [self.view addConstraint:firstSeparateWidth];
        
    } else if (type == DatePicker_Day) {

        self.firstSeparate.text = @"年";
        self.secondSeparate.text = @"月";
        self.middleSeparate.text = @"日";
        [self.hourTableView removeFromSuperview];
        [self.minuteTableView removeFromSuperview];
        [self.secondTableView removeFromSuperview];
        [self.thirdSeparate removeFromSuperview];
        [self.fouthSeparate removeFromSuperview];
        [self.fifthSeparate removeFromSuperview];
        self.firstSeparateWidth.active = NO;
        self.thirdSeparateWidth.active = NO;
        
        //(w-(20+45+24*2))/3
        NSLayoutConstraint *firstSeparateWidth = [NSLayoutConstraint constraintWithItem:self.firstSeparate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.334 constant:-37.667];

        [self.view addConstraint:firstSeparateWidth];
        
    } else if (type == DatePicker_Hour) {
    
        self.firstSeparate.text = @"年";
        self.secondSeparate.text = @"月";
        self.middleSeparate.text = @"日";
        self.thirdSeparate.text = @"时";
        [self.minuteTableView removeFromSuperview];
        [self.secondTableView removeFromSuperview];
        [self.fouthSeparate removeFromSuperview];
        [self.fifthSeparate removeFromSuperview];
        self.firstSeparateWidth.active = NO;
        self.thirdSeparateWidth.active = NO;
        
        //(w-(20+45+24*3))/4
        NSLayoutConstraint *firstSeparateWidth = [NSLayoutConstraint constraintWithItem:self.firstSeparate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.25 constant:-34.25];
        NSLayoutConstraint *thirdSeparateWidth = [NSLayoutConstraint constraintWithItem:self.thirdSeparate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.25 constant:-34.25];
        [self.view addConstraints:@[firstSeparateWidth,thirdSeparateWidth]];
        
    } else if (type == DatePicker_Minute) {

        self.thirdSeparate.text = @"时";
        self.fouthSeparate.text = @"分";
        
        [self.yearTableView removeFromSuperview];
        [self.monthTableView removeFromSuperview];
        [self.dayTableView removeFromSuperview];
        [self.secondTableView removeFromSuperview];
        [self.firstSeparate removeFromSuperview];
        [self.secondSeparate removeFromSuperview];
        [self.middleSeparate removeFromSuperview];
        [self.fifthSeparate removeFromSuperview];
        self.thirdSeparateWidth.active = NO;
        
        //(w-(20+24*2))/2
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.hourTableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20];
        NSLayoutConstraint *thirdSeparateWidth = [NSLayoutConstraint constraintWithItem:self.thirdSeparate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.5 constant:-34];
        [self.view addConstraints:@[left,thirdSeparateWidth]];
        
    } else if (type == DatePicker_Second) {
        
        self.thirdSeparate.text = @"时";
        self.fouthSeparate.text = @"分";
        self.fifthSeparate.text = @"秒";
        
        [self.yearTableView removeFromSuperview];
        [self.monthTableView removeFromSuperview];
        [self.dayTableView removeFromSuperview];
        [self.firstSeparate removeFromSuperview];
        [self.secondSeparate removeFromSuperview];
        [self.middleSeparate removeFromSuperview];
        self.thirdSeparateWidth.active = NO;
        
        //(w-(20+24*3))/3
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.hourTableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20];
        NSLayoutConstraint *thirdSeparateWidth = [NSLayoutConstraint constraintWithItem:self.thirdSeparate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.334 constant:-30.667];
        [self.view addConstraints:@[left,thirdSeparateWidth]];
        
    } else if (type == DatePicker_DayMinute) {
        
        self.middleSeparate.hidden = YES;
        [self.fouthSeparate removeFromSuperview];
        [self.secondTableView removeFromSuperview];
        [self.fifthSeparate removeFromSuperview];
        
        self.firstSeparateWidth.active = NO;
        self.thirdSeparateWidth.active = NO;
        //(w-(20+45+24*4+15))/4
        NSLayoutConstraint *firstSeparateWidth = [NSLayoutConstraint constraintWithItem:self.firstSeparate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.25 constant:-44];
        
        NSLayoutConstraint *thirdSeparateWidth = [NSLayoutConstraint constraintWithItem:self.thirdSeparate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.25 constant:-44];
        [self.view addConstraints:@[firstSeparateWidth,thirdSeparateWidth]];
        
    } else if (type == DatePicker_DaySecond) {
        
        self.middleSeparate.hidden = YES;
        [self.fifthSeparate removeFromSuperview];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addSubview:titleLable];
        
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:titleLable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        top.active = YES;
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:titleLable attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        bottom.active = YES;
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:titleLable attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        right.active = YES;
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:titleLable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        left.active = YES;
        [cell.contentView addConstraints:@[top,bottom,right,left]];
    }
    UILabel *titleLabel = [[cell.contentView subviews] lastObject];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    switch (tableView.tag) {
        case 10000:
            titleLabel.text = [_dataArray[0] objectAtIndex:indexPath.row % [_dataArray[0] count]];
            break;
        case 10001:
            titleLabel.text = [_dataArray[1] objectAtIndex:indexPath.row % [_dataArray[1] count]];
            break;
        case 10002:
            titleLabel.text = [_dataArray[2] objectAtIndex:indexPath.row % [_dataArray[2] count]];
            break;
        case 10003:
            titleLabel.text = [_dataArray[3] objectAtIndex:indexPath.row % [_dataArray[3] count]];
            break;
        case 10004:
            titleLabel.text = [_dataArray[4] objectAtIndex:indexPath.row % [_dataArray[4] count]];
            break;
        case 10005:
            titleLabel.text = [_dataArray[5] objectAtIndex:indexPath.row % [_dataArray[5] count]];
            break;
        default:
            break;
    }
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger contentOffset = scrollView.contentOffset.y;
    NSInteger index = scrollView.tag - 10000;
    
    if (contentOffset % 44 !=0 ) {
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, (contentOffset / 44 + 1) * 44);
        } completion:^(BOOL finished) {
            NSString *selectedNumber = [_dataArray[index] objectAtIndex:((contentOffset / 44 +2)%[_dataArray[index] count])];
            [_selectedData setObject:selectedNumber atIndexedSubscript:index];
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.tag - 10000;
    NSInteger count = [_dataArray[index] count];
    if (scrollView.contentOffset.y >= 41795) {
        scrollView.contentOffset = CGPointMake(0, (950 % count + count * 10) * 44);
    } else if (scrollView.contentOffset.y <= 2205) {
        scrollView.contentOffset = CGPointMake(0, (50 % count + count * 10) * 44);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger contentOffset = scrollView.contentOffset.y;
    NSInteger index = scrollView.tag - 10000;
    if (contentOffset % 44 !=0 ) {
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, (contentOffset / 44 + 1) * 44);
        } completion:^(BOOL finished) {
            NSString *selectedNumber = [_dataArray[index] objectAtIndex:((contentOffset / 44 +2)%[_dataArray[index] count])];
            [_selectedData setObject:selectedNumber atIndexedSubscript:index];
        }];
    }
}

- (NSDateComponents *)datePickerViewGetCurrentDateComponents
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    return dateComponent;
}

- (NSArray *)setUpDataSourceWithStartNumber:(NSInteger)number1 EndNumber:(NSInteger)number2
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = number1; i <= number2; i++) {
        if (i < 10) {
            [array addObject:[NSString stringWithFormat:@"0%ld",(long)i]];
        } else {
            [array addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }
    return array;
}

- (NSString *)changeFormatWithNumber:(NSInteger)number
{
    NSString *str;
    if (number < 10) {
        str = [NSString stringWithFormat:@"0%ld",(long)number];
    } else {
        str = [NSString stringWithFormat:@"%ld",(long)number];
    }
    return str;
}

@end
