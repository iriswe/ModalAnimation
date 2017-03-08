//
//  ViewController.m
//  PushPopPresentDismissAnimation
//
//  Created by ludashen on 2017/3/5.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, copy) NSArray *array;
@property (nonatomic, copy) NSArray *vcArray;

@end

@implementation ViewController

- (NSArray *)array {
    if (!_array) {
        _array = [@[@"presentdismiss 选择卡动画", @"圆形扩散动画"] copy];
    }
    return _array;
}

- (NSArray *)vcArray
{
    if (!_vcArray) {
        _vcArray = [@[@"PresentViewController", @"CircleViewController"] copy];
    }
    return _vcArray;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"自定义转场动画Demo";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = self.array[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[[NSClassFromString(self.vcArray[indexPath.row]) alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
