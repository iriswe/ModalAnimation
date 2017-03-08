//
//  CircleViewController.m
//  PushPopPresentDismissAnimation
//
//  Created by ludashen on 2017/3/8.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import "CircleViewController.h"
#import "CircledViewController.h"

@interface CircleViewController ()

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg.jpeg"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn = button;
    button.frame = CGRectMake(160, 200, 40, 40);
    button.layer.cornerRadius = 40;
    [button setTitle:@"点击或\n拖动我" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.textAlignment = 1;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor grayColor];
    button.layer.cornerRadius = 20;
    button.layer.masksToBounds = YES;
    
    [self.view addSubview:button];
    UIPanGestureRecognizer *gesturePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [button addGestureRecognizer:gesturePan];
    
}

- (void)handleGesture:(UIPanGestureRecognizer *)pan
{
    CGPoint point = pan.view.center;
    pan.view.center = CGPointMake(point.x + [pan translationInView:pan.view].x , point.y + [pan translationInView:pan.view].y);
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (void)present
{
    CircledViewController *presentVC = [CircledViewController new];
    [self presentViewController:presentVC animated:YES completion:nil];
}

- (UIButton *)btn
{
    return _btn;
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
