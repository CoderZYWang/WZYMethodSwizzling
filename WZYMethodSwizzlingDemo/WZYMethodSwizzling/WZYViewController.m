//
//  WZYViewController.m
//  WZYMethodSwizzling
//
//  Created by 奔跑宝BPB on 2017/1/17.
//  Copyright © 2017年 wzy. All rights reserved.
//

#import "WZYViewController.h"

@interface WZYViewController ()

@end

@implementation WZYViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.5, 50)];
    [button setTitle:@"dismiss" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor greenColor]];
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    
//    NSLog(@"WZYViewController --- viewDidDisappear");
//}

- (void)buttonClick {
    NSLog(@"2 - button click");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
