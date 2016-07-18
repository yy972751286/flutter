//
//  ViewController.m
//  test2
//
//  Created by 李邦臣 on 16/5/13.
//  Copyright © 2016年 李邦臣. All rights reserved.
//

#import "DMShaiXuanViewController.h"

@interface DMShaiXuanViewController ()

@end

@implementation DMShaiXuanViewController{
    NSMutableArray * arr;//作为变量数组
    UIImageView * imgView;
    NSInteger index;//记录点击的是哪一个筛选条件
    NSMutableArray * recordArr;//记录下最原始的数据源
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArr = [[NSMutableArray alloc]initWithObjects:@"范围",@"类型",@"按距离", nil];
    _oneArr = [[NSMutableArray alloc]initWithObjects:@"范围 (全部)",@"1KM",@"5KM",@"10KM", nil];
    _twoArr = [[NSMutableArray alloc]initWithObjects:@"类型 (全部)",@"中餐",@"午餐",nil];
    _threeArr = [[NSMutableArray alloc]initWithObjects:@"按距离",@"按人气", nil];
    arr = [NSMutableArray array];
    recordArr = [NSMutableArray array];
    recordArr = _titleArr.copy;
    [self costomShaiXuan:_titleArr];
}

- (void) costomShaiXuan:(NSMutableArray *) senderArr{
    for (int i = 0; i<3; i++) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(Width/3*i, 20*Y,Width/3, 40*Y);
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn setTitle:senderArr[i] forState:(UIControlStateNormal)];
        btn.tag = 390+i;
        [btn addTarget:self action:@selector(senderOnCilck:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:btn];
    }
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60*Y, Width, Height - 20*Y- 40*Y)];
    imgView.userInteractionEnabled = YES;
    imgView.image = [UIImage imageNamed:@"ios_uname_bg"];
    [self addAGesutreRecognizerForYourView];
}


- (void) senderOnCilck:(UIButton *) sender {
    index = sender.tag-390;
    for (int i = 0; i<3; i++) {
        UIButton * btn = [self.view viewWithTag:390+i];
        if (sender.tag == btn.tag) {
            [btn setTitleColor:COLORRED forState:(UIControlStateNormal)];
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
    }
    switch (sender.tag-390) {
        case 0:
            [self costomTableView:_oneArr WithImgView:imgView];
            break;
        case 1:
            [self costomTableView:_twoArr WithImgView:imgView];
            break;
        case 2:
            [self costomTableView:_threeArr WithImgView:imgView];
            break;
    }
}

/**
 *  改变数据源以后刷新button
 */
- (void) refreshButtonWithText {
    for (int i = 0; i<3; i++) {
        UIButton * btn = [self.view viewWithTag:390+i];
        [btn setTitle:_titleArr[i] forState:(UIControlStateNormal)];
    }
}


-(void) costomTableView:(NSMutableArray *) senderArr WithImgView:(UIImageView *)View  {
    arr = senderArr;
    if (_tableView==nil) {
        if ( (Height - 20*Y- 40*Y)/2<30*Y*arr.count) {
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, Width,(Height - 20*Y- 40*Y)/2) style:(UITableViewStylePlain)];
        }else{
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, Width,30*Y*arr.count) style:(UITableViewStylePlain)];
        }
        [self.view addSubview:imgView];
    }else{
        [_tableView reloadData];
    }
    if ( (Height - 20*Y- 40*Y)/2<30*Y*arr.count) {
        _tableView.frame = CGRectMake(0,0, Width,(Height - 20*Y- 40*Y)/2);
    }else{
        _tableView.frame = CGRectMake(0,0, Width,30*Y*arr.count);
    }

    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.tintColor = COLORRED;
    [View addSubview:_tableView];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30*Y;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"cell"];
    }
    cell.textLabel.text =arr[indexPath.row];
    [self costomXuanZhong:index WithTableCell:cell WithIndexPathRow:indexPath.row];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        switch (index) {
            case 0:
                _titleArr[index] = recordArr[0];
                break;
            case 1:
                _titleArr[index] = recordArr[1];
                break;
            case 2:
                _titleArr[index] = recordArr[2];
                break;
        }
    }else{
        switch (index) {
            case 0:
                _titleArr[index] = _oneArr[indexPath.row];
                break;
            case 1:
                _titleArr[index] = _twoArr[indexPath.row];
                break;
            case 2:
                _titleArr[index] = _threeArr[indexPath.row];
                break;
        }
    }
    [_tableView reloadData];
    [self refreshButtonWithText];
    [self tapGesturedDetected];
}

- (void) costomXuanZhong:(NSInteger ) indexRow WithTableCell:(UITableViewCell *) cell WithIndexPathRow:(NSInteger) row{
    switch (indexRow) {
        case 0:
            [self costomXuanZhongArr:_oneArr WithIndexRow:indexRow WithTableCell:cell WithIndexPathRow: row];
            break;
        case 1:
            [self costomXuanZhongArr:_twoArr WithIndexRow:indexRow WithTableCell:cell WithIndexPathRow: row];
            break;
        case 2:
            [self costomXuanZhongArr:_threeArr WithIndexRow:indexRow WithTableCell:cell WithIndexPathRow: row];
            break;
    }
}

-(void) costomXuanZhongArr:(NSMutableArray *) ShaiArr WithIndexRow:(NSInteger ) indexRow WithTableCell:(UITableViewCell *) cell WithIndexPathRow:(NSInteger) row {
    NSInteger rowStr=-1;
    for (int i = 0; i<ShaiArr.count; i++) {
        NSString * str = ShaiArr[i];
        if ([str isEqualToString:_titleArr[indexRow]]) {
            rowStr = i;
        }
    }
    if (rowStr == row) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }else if (rowStr == -1){
        if (row==0) {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
}

//给tableview添加点击手势取消第一响应
- (void)addAGesutreRecognizerForYourView
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.delegate = self;
    [imgView addGestureRecognizer:tapGesture];
    
}


- (void)tapGesturedDetected
{
    [imgView removeFromSuperview];
    [_tableView removeFromSuperview];
    _tableView = nil;
    UIButton * btn = [self.view viewWithTag:390+index];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:_tableView]) {
        return NO;
    }
    return YES;
}


@end
