//
//  LeftMenuViewController.m
//  CFCustomTableView
//
//  Created by YF on 2017/7/20.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "XLSlideMenu.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)cf_numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (void)cf_didSelectRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    [self.xl_sldeMenu showRootViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
