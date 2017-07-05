//
//  ViewController.m
//  CFCustomTableView
//
//  Created by YF on 2017/6/23.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "ViewController.h"
#import "CFBaseTableViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnAction:(id)sender {
    CFBaseTableViewController *vc=[CFBaseTableViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
