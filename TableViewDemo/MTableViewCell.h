//
//  MTableViewCell.h
//  TableViewDemo
//
//  Created by CHLMA2015 on 2017/7/12.
//  Copyright © 2017年 MACHUNLEI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ActionBtnIndex) {
    ActionBtnDeleteIndex = 600,
    ActionBtnEditIndex,
    ActionBtnShareIndex,
};

@class DataModel;

@interface CustomButton : UIButton
- (instancetype)initWithFrame:(CGRect)frame withImage:(NSString *)imageName withTitle:(NSString *)titleStr;
@end

@protocol MTableViewCellDelegate <NSObject>

/**
 * 接口说明：个人知识集Cell innerContentView的展示
 * 入参说明：
 * tag:  当前选中知识集Cell Index
 * select: 展开or关闭 innerContentView
 */
- (void)refreshCellUI:(NSInteger)tag withSelected:(BOOL)select;

- (void)didMoreActionWith:(ActionBtnIndex)actionIndex;

@end

@interface MTableViewCell : UITableViewCell

@property (nonatomic, strong) CustomButton  *arrowImageBtn;
@property (nonatomic,   weak) id<MTableViewCellDelegate> delegate;
- (void)fillCellWithModel:(DataModel *)model sectionTag:(NSInteger)tag;

@end
