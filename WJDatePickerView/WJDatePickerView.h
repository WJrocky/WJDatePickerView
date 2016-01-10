//
//  WJDatePickerView.h
//  WJDatePickerView
//
//  Created by 王健 on 16/1/4.
//  Copyright © 2016年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _DatePickerType
{
    DatePicker_Day = 0,    // 选择“xx年xx月xx日”
    DatePicker_Year,       // 选择“xx年”
    DatePicker_Month,      // 选择“xx年xx月”
    DatePicker_Hour,       // 选择“xx年xx月xx日xx时”
    DatePicker_Minute,     // 选择“xx时xx分”
    DatePicker_Second,     // 选择“xx时xx分xx秒”
    DatePicker_DayMinute,  // 选择“xxxx－xx－xx xx：xx”
    DatePicker_DaySecond   // 选择“xxxx－xx－xx xx：xx：xx”
}DatePickerType;

@interface WJDatePickerView : UIView

@property (weak, nonatomic) IBOutlet UITableView *yearTableView;

@property (weak, nonatomic) IBOutlet UITableView *monthTableView;

@property (weak, nonatomic) IBOutlet UITableView *dayTableView;

@property (weak, nonatomic) IBOutlet UITableView *hourTableView;

@property (weak, nonatomic) IBOutlet UITableView *minuteTableView;

@property (weak, nonatomic) IBOutlet UITableView *secondTableView;

@property (weak, nonatomic) IBOutlet UILabel *firstSeparate;

@property (weak, nonatomic) IBOutlet UILabel *secondSeparate;

@property (weak, nonatomic) IBOutlet UILabel *middleSeparate;

@property (weak, nonatomic) IBOutlet UILabel *thirdSeparate;

@property (weak, nonatomic) IBOutlet UILabel *fouthSeparate;

@property (weak, nonatomic) IBOutlet UILabel *fifthSeparate;

@property (strong, nonatomic) NSArray *dataArray;
//数据格式为年、月、日、时、分、秒
@property (strong, nonatomic) NSMutableArray *selectedData;

- (void)showDatePickerViewWithType:(DatePickerType)type;

@end
