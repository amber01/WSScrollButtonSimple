//
//  ViewController.m
//  WSScrollButtonSimple
//
//  Created by shlity on 15/8/7.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import "ViewController.h"
#import "OneTableViewController.h"
#import "TwoTableViewController.h"
#import "ThreeTableViewController.h"

#define TEXT_COLOR [UIColor colorWithRed:22/255.0 green:150/255.0 blue:249/255.0 alpha:1.0]
#define LINE_COLOR [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]

@interface ViewController ()
{
    UIScrollView *_scrollView;
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    int currPage;
    UIView *line;
    long isShow;
    long isShow2;
    long isShow3;
    OneTableViewController *oneVC;
    TwoTableViewController *twoVC;
    ThreeTableViewController *threeVC;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createdScrollView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"test";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)createdScrollView
{
    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width/3, 45)];
    btn1.backgroundColor = [UIColor whiteColor];
    btn1.titleLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:17];
    [btn1 setTitle:@"学校通知" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"学校通知" forState:UIControlStateSelected];
    [btn1 setTitleColor:TEXT_COLOR forState:UIControlStateSelected];
    [self.view addSubview:btn1];
    btn1.selected = YES;
    [self setBorderWithView:btn1 top:NO left:NO bottom:YES right:YES borderColor:[UIColor grayColor] borderWidth:0.5f];
    [btn1 addTarget:self action:@selector(showValidCoupon:) forControlEvents:UIControlEventTouchUpInside];
    currPage = 0;
    
    btn2 = [[UIButton alloc] initWithFrame:CGRectMake(btn1.frame.size.width, 64, self.view.frame.size.width/3, 45)];
    btn2.backgroundColor = [UIColor whiteColor];
    btn2.titleLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:17];
    [btn2 setTitle:@"年级通知" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"年级通知" forState:UIControlStateSelected];
    [btn2 setTitleColor:TEXT_COLOR forState:UIControlStateSelected];
    [self setBorderWithView:btn2 top:NO left:NO bottom:YES right:YES borderColor:[UIColor grayColor] borderWidth:0.5f];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(showInvalidCoupon:) forControlEvents:UIControlEventTouchUpInside];
    
    
    btn3 = [[UIButton alloc] initWithFrame:CGRectMake(btn1.frame.size.width * 2, 64, self.view.frame.size.width/3, 45)];
    btn3.backgroundColor = [UIColor whiteColor];
    btn3.titleLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:17];
    [btn3 setTitle:@"班级通知" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setTitle:@"班级通知" forState:UIControlStateSelected];
    [btn3 setTitleColor:TEXT_COLOR forState:UIControlStateSelected];
    [self setBorderWithView:btn3 top:NO left:NO bottom:YES right:NO borderColor:[UIColor grayColor] borderWidth:0.5f];
    [self.view addSubview:btn3];
    [btn3 addTarget:self action:@selector(showInvalidCoupon3:) forControlEvents:UIControlEventTouchUpInside];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45 + 64, self.view.frame.size.width, self.view.frame.size.height-45-64)];
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.alwaysBounceHorizontal = YES;  //是否可水平滚动 同时设置bounces=YES
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.tag = 3;
    _scrollView.delegate = self;
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, _scrollView.frame.size.height);
    [self.view addSubview:_scrollView];
    isShow = -1;
    isShow2 = -1;
    
    
    oneVC = [[OneTableViewController alloc]init];
    twoVC = [[TwoTableViewController alloc]init];
    threeVC = [[ThreeTableViewController alloc]init];
    
    oneVC.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    twoVC.tableView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    threeVC.tableView.frame = CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, self.view.frame.size.height);
    [_scrollView addSubview:oneVC.tableView];
    [_scrollView addSubview:twoVC.tableView];
    [_scrollView addSubview:threeVC.tableView];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(0, 44+64, btn1.frame.size.width, 1)];
    line.backgroundColor = TEXT_COLOR;
    [self.view addSubview:line];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 3) {
        float k = scrollView.contentOffset.x/scrollView.frame.size.width;
        //line.center = CGPointMake(self.view.frame.size.width/3.0+self.view.frame.size.width/3.0*k, line.center.y);
        line.frame = CGRectMake(self.view.frame.size.width/3.0*k, 44+64, btn1.frame.size.width, 1);
        
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 3) / pageWidth) + 1;
        NSLog(@"%d...",page);
        if (currPage != page) {
            currPage = page;
            if (currPage == 0) {
                btn1.selected = YES;
                btn2.selected = NO;
                btn3.selected = NO;
            }else if (currPage == 1){
                btn2.selected = YES;
                btn1.selected = NO;
                btn3.selected = NO;
            }else{
                btn1.selected = NO;
                btn2.selected = NO;
                btn3.selected = YES;
            }
        }
    }
}
-(void)showValidCoupon:(UIButton*)btn
{
    if (btn.selected) {
        return;
    }else{
        btn.selected = YES;
        btn2.selected = NO;
        btn3.selected = NO;
        [_scrollView scrollRectToVisible:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
    }
}

-(void)showInvalidCoupon:(UIButton*)btn
{
    if (btn.selected) {
        return;
    }else{
        btn.selected = YES;
        btn1.selected = NO;
        btn3.selected = NO;
        [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
    }
}

-(void)showInvalidCoupon3:(UIButton*)btn
{
    if (btn.selected) {
        return;
    }else{
        btn.selected = YES;
        btn1.selected = NO;
        btn2.selected = NO;
        [_scrollView scrollRectToVisible:CGRectMake(_scrollView.frame.size.width*2, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
    }
}

//
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

