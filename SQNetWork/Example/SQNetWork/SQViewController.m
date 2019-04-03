//
//  SQViewController.m
//  SQNetWork
//
//  Created by heiguoliangle@163.com on 03/21/2019.
//  Copyright (c) 2019 heiguoliangle@163.com. All rights reserved.
//

#import "SQViewController.h"
#import <SQNetWork/SQNetWork.h>
#import "SQCompressHelp.h"

@interface SQViewController ()

@end

@implementation SQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[SQCompressHelp new]upload];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
