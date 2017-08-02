//
//  ViewController.m
//  kvo
//
//  Created by yg on 2017/8/2.
//  Copyright © 2017年 TBB. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
@interface ViewController ()
@property (nonatomic ,strong)Student *stu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Student *stu = [Student new];
    self.stu = stu;
    stu.age = 10;
    // 添加对age属性的观察，一旦发生变化，立刻响应
    // Observer:哪个对象来观察 stu，谁来观察，谁就负责
    // 响应 value变化时要做的事情
    // keyPath:要观察s的什么属性
    // options：确定观察者可以获取的value的状态有哪些
    // context：被观察者给观察者提供的额外的信息
    [stu addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld context:@"被观察者给观察者提供的额外的信息"];
    
    stu.age = 11;
}
// 成为观察者的对象需要实现以下方法
// 只要观察的属性一发生变化，那么下面的方法就会被自动执行
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    /**
     *  利用KVO 监听到对象属性值改变后,就会调用这个方法
     *
     *  @param keyPath 哪一个属性被改了
     *  @param object  哪一个对象的属性被改了
     *  @param change  改成什么样了
     */
    //NSLog(@"%@对象的%@属性\n改变:%@\n%@",object,keyPath,change,context);
    NSLog(@"新值:%@",[object valueForKeyPath:keyPath]);
    NSLog(@"旧值:%@",change[@"old"]);
    NSLog(@"%@",context);
}

- (void)dealloc
{
    [self.stu removeObserver:self forKeyPath:@"age"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
