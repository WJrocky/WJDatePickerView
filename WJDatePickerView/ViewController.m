//
//  ViewController.m
//  WJDatePickerView
//
//  Created by 王健 on 16/1/4.
//  Copyright © 2016年 Rocky. All rights reserved.
//

#import "ViewController.h"
#import "WJDatePickerView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet WJDatePickerView *datePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
//    [self.datePicker showDatePickerViewWithType:DatePicker_Day];
//    [self.datePicker showDatePickerViewWithType:DatePicker_Year];
//    [self.datePicker showDatePickerViewWithType:DatePicker_Month];
//    [self.datePicker showDatePickerViewWithType:DatePicker_Hour];
    [self.datePicker showDatePickerViewWithType:DatePicker_Minute];
//    [self.datePicker showDatePickerViewWithType:DatePicker_Second];
//    [self.datePicker showDatePickerViewWithType:DatePicker_DayMinute];
//    [self.datePicker showDatePickerViewWithType:DatePicker_DaySecond];
}
- (IBAction)selectedValues:(id)sender {
    NSLog(@"values = %@",self.datePicker.selectedData);
}

@end
