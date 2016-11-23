//
//  messageDetailController.m
//  FQeditCell
//
//  Created by 冯倩 on 2016/11/16.
//  Copyright © 2016年 冯倩. All rights reserved.
//

#import "messageDetailController.h"

@interface messageDetailController ()

@end

@implementation messageDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"详情页";
    NSLog(@"上个界面传来的商品详情是%@",_messageDetail);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
