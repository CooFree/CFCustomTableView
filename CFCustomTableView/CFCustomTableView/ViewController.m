//
//  ViewController.m
//  CFCustomTableView
//
//  Created by YF on 2017/6/23.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "ViewController.h"

#import "CFBaseTableViewCell.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.data = @[@"ParallaxHeader",@"WaterWave"];

    [self.tableView reloadData];
}
- (void)cf_didSelectRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    NSString *str = [self.data[indexPath.row] stringByAppendingString:@"ViewController"];
    UIViewController *vc = [NSClassFromString(str) new];
    [self.navigationController pushViewController:vc animated:YES];

}
- (CFBaseTableViewCell *)cf_cellAtIndexPath:(NSIndexPath *)indexPath {
    CFBaseTableViewCell *cell = [CFBaseTableViewCell cellWithTableView:self.tableView];
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}
- (NSInteger)cf_numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
