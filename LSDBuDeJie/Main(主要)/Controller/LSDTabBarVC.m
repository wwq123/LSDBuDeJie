//
//  LSDTabBarVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/6.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDTabBarVC.h"
#import "LSDEssenceVC.h"
#import "LSDPublishVC.h"
#import "LSDNewVC.h"
#import "LSDFriendTrendVC.h"
#import "LSDMeVC.h"

@interface LSDTabBarVC ()

@end

@implementation LSDTabBarVC

//设置UITabBarController全局的tabBarItem的字体颜色和大小
+ (void)load{
    //load方法只会调用一次
    
    //获取当前LSDTabBarVC全部的UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //设置字体颜色
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    //设置字体大小
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.f]} forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加对应的子控制器
    [self setChildVC];
}

- (void)setChildVC{
   UINavigationController *nav = [self childNavVCWithVC:[LSDEssenceVC new] Title:@"精华" normalImageName:@"tabBar_essence_icon" selectImageName:@"tabBar_essence_click_icon"];
    
   UINavigationController *nav1 = [self childNavVCWithVC:[LSDNewVC new] Title:@"新帖" normalImageName:@"tabBar_new_icon" selectImageName:@"tabBar_new_click_icon"];
    
    LSDPublishVC *pubVC = (LSDPublishVC *)[self childVCWithVC:[LSDPublishVC new] normalImageName:@"tabBar_publish_icon" selectImageName:@"tabBar_publish_click_icon"];
    
   UINavigationController *nav2 = [self childNavVCWithVC:[LSDFriendTrendVC new] Title:@"关注" normalImageName:@"tabBar_friendTrends_icon" selectImageName:@"tabBar_friendTrends_click_icon"];
    
   UINavigationController *nav3 = [self childNavVCWithVC:[LSDMeVC new] Title:@"我" normalImageName:@"tabBar_me_icon" selectImageName:@"tabBar_me_click_icon"];
    
    [self addChildViewController:nav];
    [self addChildViewController:nav1];
    [self addChildViewController:pubVC];
    [self addChildViewController:nav2];
    [self addChildViewController:nav3];
}

- (UINavigationController *)childNavVCWithVC:(UIViewController *)childVC Title:(NSString *)title normalImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVC];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:normalImageName];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return nav;
}

- (UIViewController *)childVCWithVC:(UIViewController *)childVC normalImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName{
    childVC.tabBarItem.image = [UIImage imageNamed:normalImageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return childVC;
}
@end
