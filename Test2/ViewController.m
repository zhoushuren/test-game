//
//  ViewController.m
//  Test2
//
//  Created by zhoujun on 2017/12/29.
//  Copyright © 2017年 zhoujun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) CGFloat count;
@property (nonatomic,strong) NSMutableArray * enemeArr;
@property (nonatomic,strong) NSMutableArray * bulletArr;
@property  (nonatomic,strong) UIView * heroView;
@property (nonatomic,strong) NSTimer * timer1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.count = 0;
//    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.navigationController.navigationBar.translucent = NO;
    self.enemeArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.heroView = [UIView new];
    CGRect rect = self.view.frame;
    self.heroView.frame = CGRectMake(rect.size.width/2.0, rect.size.height-100, 50, 50);
    [self.view addSubview:self.heroView];
    self.heroView.backgroundColor = [UIColor greenColor];
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:gesture];
    
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timer2) userInfo:nil repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(timer3) userInfo:nil repeats:YES];
    
    //[self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)removeTimer1 {
    [self.timer1 invalidate];
    self.timer1 = nil;
}

- (void)timer {
    self.count +=0.1;
    NSLog(@"-------------   %f",   self.count);
    
    for (int i=0;i<self.enemeArr.count; i++) {
        UIView * view =  self.enemeArr[i];
        CGRect rect = view.frame;
        if(rect.origin.y > self.view.frame.size.height){
            [view removeFromSuperview];
            [self.enemeArr removeObject:view];
            continue;
        }
        rect.origin.y +=1;
        view.frame = rect;
    }
    
    CGRect rect = self.view.frame;
    rect.size.width;
    rect.size.height;
    arc4random() % (int)rect.size.width;
    UIView *view;
    [view removeFromSuperview];
}

-(void) timer2{
    UIView * enemy = [UIView new];
    CGRect rect = self.view.frame;
    enemy.frame = CGRectMake(arc4random() % (int)rect.size.width, 0, 40, 40);
    enemy.backgroundColor = [UIColor redColor];
    [self.view addSubview:enemy];
    [self.enemeArr addObject:enemy];
}

-(void) timer3{
    for (int i=0; i<self.enemeArr.count; i++) {
        UIView * view =  self.enemeArr[i];
        CGRect rect = view.frame;
        
        if (CGRectIntersectsRect(rect, self.heroView.frame)) {
            [self removeTimer1];
        }
        
        for (int j = 0; j<self.bulletArr.count; j++) {
            UIView * bulleView =  self.enemeArr[i];
            CGRect bulleRect = bulleView.frame;
            if (CGRectIntersectsRect(rect, bulleRect)) {
                //
            }
        }
    }
}

- (void)panGesture:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            
        }
            break;
            
        case UIGestureRecognizerStateEnded: {
            
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            CGPoint panPoint = [pan locationInView:self.view];
            NSLog(@"%f   ,   %f",panPoint.x, panPoint.y);
            NSLog(@"%@", NSStringFromCGPoint(panPoint));
            self.heroView.center = panPoint;
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
