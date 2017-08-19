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

/**
 ###巧用多字符Char(代码取巧法)

 char这个数据类型和它的使用方式：
 char c = 'a'; 这个 c 变量在 ASCII 编码下是 97。
 
 还有一种不常见的多字符 char 的写法：
 int i = 'AaBb';
 这个 i 变量的值按每个 char 的 ASCII 值转 16 进制拼在一起，也就是说：
 
 'AaBb'
 -> '0x41'+'0x61'+'0x42'+'0x62'
 -> '0x41614262' // 十进制1096893026
 PS：这个组合方式和“大小端”有关系，上面是 i386 下的结果
 多字符的长度限度为最多 4 个 char
 
 代码取巧法则一，比如：
 
 self.someButton.tag = 'SHIT';
 ...
 
 if (button.tag == 'SHIT') {
 NSLog(@"I've got this shit button");
 }
 
 当然使用tag是很不推荐的写法，尽量不用。使用这个特性来避免些魔法数字或标记些整型数字还是极好的。
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 'abcd') {
        return 127;
    }else {
        if (_editCellIndex != -1 && _editCellIndex == indexPath.row) {
            return 71 + 56;
        }
        return 71;
    }
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
        _tableView.tag = 'abcd';
        [_tableView registerClass:[MTableViewCell class] forCellReuseIdentifier:@"MTableViewCell"];
    }
    return _tableView;
}

@end
