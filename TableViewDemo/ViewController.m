//
//  ViewController.m
//  TableViewDemo
//
//  Created by CHLMA2015 on 2017/7/12.
//  Copyright © 2017年 MACHUNLEI. All rights reserved.
//

#import "ViewController.h"
#import "MTableViewCell.h"
#import "DataModel.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, MTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, assign) NSInteger editCellIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _editCellIndex = -1;
    _mArray = [NSMutableArray array];
    for (int i = 0; i < 15; i ++) {
        DataModel *model = [[DataModel alloc] init];
        [_mArray addObject:model];
    }
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshCellUI:(NSInteger)tag withSelected:(BOOL)select{

    if (select) {
        _editCellIndex = tag;
    }else {
        _editCellIndex = -1;
    }
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_editCellIndex != -1 && _editCellIndex == indexPath.row) {
        return 71 + 56;
    }
    return 71;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;//CGFLOAT_MIN 这个宏表示 CGFloat 能代表的最接近 0 的浮点数，64 位下大概是 0.00(300左右个)0225 这个样子，这里用 0.1 效果是一样的。
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MTableViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    DataModel *model = _mArray[indexPath.row];
    [cell fillCellWithModel:model sectionTag:indexPath.row];
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didMoreActionWith:(ActionBtnIndex)actionIndex {

}

- (UITableView *)tableView {
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[MTableViewCell class] forCellReuseIdentifier:@"MTableViewCell"];
    }
    return _tableView;
}

@end
