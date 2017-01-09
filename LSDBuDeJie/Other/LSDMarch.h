//
//  LSDMarch.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/9.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//



/****************************屏幕适配****************************/
#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height
//iphone6Plus,iphone7Plus
#define Iphone6PAbove (Screen_height == 736)
//iphone6,iphone7
#define Iphone6 (Screen_height == 667)
#define Iphone5 (Screen_height == 568)
#define Iphone4 (Screen_height == 480)
/****************************屏幕适配****************************/


/****************************自定义Log****************************/
#ifdef DEBUG // 调试
#define LSDLog(...) NSLog(__VA_ARGS__)
#else // 发布
#define LSDLog(...)
#endif

#define LSDFunc LSDLog(@"%s",__func__)
/****************************自定义Log****************************/

#define LSDApplication [UIApplication sharedApplication]
