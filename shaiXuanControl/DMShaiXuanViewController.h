//
//  ViewController.h
//  test2
//
//  Created by 李邦臣 on 16/5/13.
//  Copyright © 2016年 李邦臣. All rights reserved.
//

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define X [UIScreen mainScreen].bounds.size.width/375
#define Y [UIScreen mainScreen].bounds.size.height/667
#define COLORRED [UIColor colorWithRed:246/255.0 green:82/255.0 blue:44/255.0 alpha:1]

#import <UIKit/UIKit.h>

@interface DMShaiXuanViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
/**
 *  创建tableView  通过更换数据源的方式进行筛洗
 */
@property (nonatomic ,strong)  UITableView * tableView;
/**
 *  第一个按钮的原数组
 */
@property(nonatomic,copy) NSMutableArray *oneArr;
/**
 *  第二个按钮的原数组
 */
@property(nonatomic,copy) NSMutableArray *twoArr;
/**
 *  第三个按钮的原数组
 */
@property(nonatomic,copy) NSMutableArray *threeArr;
/**
 *  3个标题的原数组
 */
@property(nonatomic,copy) NSMutableArray *titleArr;


@end

