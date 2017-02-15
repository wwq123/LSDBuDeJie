//
//  LSDMarch.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/9.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDConst.h"

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
#define LSDUserDefaults [NSUserDefaults standardUserDefaults]
#define LSDNotificationCenter [NSNotificationCenter defaultCenter]
#define LSDColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define LSDBackgroundColor LSDColor(220, 220, 220)
#define LSDCurrentVersion [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]
#define LSDWritePlistFileWithFileName(fileName) [responseObject writeToFile:[NSString stringWithFormat:@"/Users/Selena/Desktop/%@.plist",fileName] atomically:YES];

/****************************精华模块****************************/
#define  LSD_ContentSet_Top   (LSD_NavH + LSD_titleViewH)              //上边距
#define  LSD_ContentSet_bottom  (LSD_TabBarH)              //下边距
/****************************精华模块****************************/
