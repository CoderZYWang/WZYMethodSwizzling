//
//  ViewController.m
//  WZYMethodSwizzling
//
//  Created by 奔跑宝BPB on 2017/1/16.
//  Copyright © 2017年 wzy. All rights reserved.
//

#import "ViewController.h"

#import "WZYViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.5, 50)];
    [button setTitle:@"modal" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick {
    NSLog(@"1 - button click");

    [self presentViewController:[WZYViewController new] animated:YES completion:nil];
}

//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    
//    NSLog(@"ViewController --- viewDidDisappear");
//}

@end
