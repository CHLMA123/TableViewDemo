//
//  MTableViewCell.m
//  TableViewDemo
//
//  Created by CHLMA2015 on 2017/7/12.
//  Copyright © 2017年 MACHUNLEI. All rights reserved.
//

#import "MTableViewCell.h"
#import "DataModel.h"
#import "Masonry.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define ButtonInterSpace 80
#define ButtonWidth 44

@implementation CustomButton

- (instancetype)initWithFrame:(CGRect)frame withImage:(NSString *)imageName withTitle:(NSString *)titleStr{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self setTitle:titleStr forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:11.f]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 24;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 18;
    CGFloat imageH = 18;
    return CGRectMake((CGRectGetWidth(contentRect)-18)/2, 0, imageW, imageH);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat hightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * hightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end

@interface MTableViewCell ()
@property (nonatomic, strong) UIImageView   *folderImagView;    // 默认封面图
@property (nonatomic, strong) UILabel       *folderTitleLabel;  // 知识集Title
@property (nonatomic, strong) UILabel       *docCountLabel;     // %d 文档
@property (nonatomic, strong) UILabel       *scanCountLabel;    // %d 浏览
@property (nonatomic, strong) UILabel       *comeFromLablel;    // 来自XXX

@property (nonatomic, strong) UIView        *lineView;

/** contentView */
@property (nonatomic ,strong) UIView        *innerContentView;
@property (nonatomic, strong) CustomButton  *deleteBtn;
@property (nonatomic, strong) CustomButton  *editBtn;
@property (nonatomic, strong) CustomButton  *shareBtn;

@end

@implementation MTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.folderImagView];
        [self.contentView addSubview:self.folderTitleLabel];
        [self.contentView addSubview:self.docCountLabel];
        [self.contentView addSubview:self.scanCountLabel];
        [self.contentView addSubview:self.comeFromLablel];
        [self.contentView addSubview:self.arrowImageBtn];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.innerContentView];
        self.innerContentView.hidden = YES;
        //self.comeFromLablel.hidden = YES;
        self.docCountLabel.backgroundColor = [UIColor grayColor];
        self.scanCountLabel.backgroundColor = [UIColor grayColor];
        self.comeFromLablel.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)fillCellWithModel:(DataModel *)model sectionTag:(NSInteger)tag{
    
    self.folderImagView.image = [UIImage imageNamed:@"80"];
    [self.folderTitleLabel setText:model.title];
    [self.docCountLabel setText:[NSString stringWithFormat:@"%@ %@", model.fileCount, @"文档"]];
    [self.scanCountLabel setText:[NSString stringWithFormat:@"%@ %@", model.scanCount, @"浏览"]];
    [self.comeFromLablel setText:[NSString stringWithFormat:@"%@", model.comeFrom]];
    self.arrowImageBtn.tag = 1000 + tag;
    if (self.frame.size.height > 71) {
        self.innerContentView.hidden = NO;
        self.arrowImageBtn.transform = CGAffineTransformIdentity;
    }
    else{
        self.innerContentView.hidden = YES;
        self.arrowImageBtn.transform = CGAffineTransformMakeRotation(M_PI);
    }
    
    
    [self subLayoutViews];
}

-(void)subLayoutViews{
    CGRect frame = self.docCountLabel.frame;
    CGSize constraintSize = CGSizeMake(MAXFLOAT, frame.size.height);
    CGSize docSize = [self.docCountLabel sizeThatFits:constraintSize];
    CGSize scanSize = [self.scanCountLabel sizeThatFits:constraintSize];
    CGSize comeSize = [self.comeFromLablel sizeThatFits:constraintSize];
//    self.docCountLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, docSize.width, frame.size.height);
//    self.scanCountLabel.frame = CGRectMake(CGRectGetMaxX(self.docCountLabel.frame) + 28, frame.origin.y, scanSize.width, frame.size.height);
//    CGFloat tempW = CGRectGetMinX(self.arrowImageBtn.frame) - CGRectGetMaxX(self.scanCountLabel.frame) - 28;
//    self.comeFromLablel.frame = CGRectMake(CGRectGetMaxX(self.scanCountLabel.frame) + 28, frame.origin.y, tempW, frame.size.height);
    
    [self.folderImagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(12);
        make.left.equalTo(self.contentView).with.offset(17);
        make.width.mas_equalTo(47);
        make.height.mas_equalTo(47);
    }];
    
    [self.folderTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(15);
        make.left.equalTo(self.folderImagView.mas_right).with.offset(12);
        make.right.equalTo(self.contentView).with.offset(-35);
        make.height.equalTo(@25);
        
    }];
    
    [self.docCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(40);
        make.left.equalTo(self.folderImagView.mas_right).with.offset(12);
        make.size.mas_equalTo(docSize);

    }];
    
    [self.scanCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(40);
        make.left.equalTo(self.docCountLabel.mas_right).with.offset(28);
        make.size.mas_equalTo(scanSize);

    }];
    
    [self.comeFromLablel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(40);
        make.left.equalTo(self.scanCountLabel.mas_right).with.offset(28);
        make.size.mas_equalTo(comeSize);

    }];
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(70.5);
        make.left.equalTo(self.contentView).with.offset(17);
        make.right.equalTo(self.contentView).with.offset(0);
        make.height.equalTo(@0.5);
    }];

}

- (void)showMoreActionView:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshCellUI:withSelected:)]) {
        [self.delegate refreshCellUI:sender.tag - 1000 withSelected:sender.selected];
    }
}

- (void)moreBtnActionView:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didMoreActionWith:)]) {
        [self.delegate didMoreActionWith:sender.tag];
    }
}

#pragma mark - Setter && Getter

- (UIImageView *)folderImagView{
    
    if (_folderImagView == nil) {
        _folderImagView = [[UIImageView alloc] init];
        _folderImagView.layer.cornerRadius = 3.0;
        _folderImagView.image = [UIImage imageNamed:@"Default"];
    }
    return _folderImagView;
}

- (UILabel *)folderTitleLabel{
    
    if (_folderTitleLabel == nil) {
        _folderTitleLabel = [[UILabel alloc] init];
        _folderTitleLabel.textColor = [UIColor blackColor];
        _folderTitleLabel.font = [UIFont systemFontOfSize:17.f];
        //_folderTitleLabel.backgroundColor = [UIColor greenColor];
    }
    return _folderTitleLabel;
}

- (UILabel *)docCountLabel
{
    if (_docCountLabel == nil) {
        _docCountLabel = [[UILabel alloc] init];
        _docCountLabel.textColor = [UIColor blackColor];
        _docCountLabel.font = [UIFont systemFontOfSize:12.f];
    }
    return _docCountLabel;
}

- (UILabel *)scanCountLabel
{
    if (_scanCountLabel == nil) {
        _scanCountLabel = [[UILabel alloc] init];
        _scanCountLabel.textColor = [UIColor blackColor];
        _scanCountLabel.font = [UIFont systemFontOfSize:12.f];
    }
    return _scanCountLabel;
}

- (UILabel *)comeFromLablel
{
    if (_comeFromLablel == nil) {
        _comeFromLablel = [[UILabel alloc] init];
        _comeFromLablel.textColor = [UIColor blackColor];
        _comeFromLablel.font = [UIFont systemFontOfSize:12.f];
    }
    return _comeFromLablel;
}


- (CustomButton *)arrowImageBtn{
    if (!_arrowImageBtn) {
        _arrowImageBtn = [CustomButton buttonWithType:UIButtonTypeCustom];
        _arrowImageBtn.frame = CGRectMake(SCREENWIDTH - 31, 31.5, 14.f, 8.f);
        //_arrowImageBtn.backgroundColor = [UIColor greenColor];
        [_arrowImageBtn setBackgroundImage:[UIImage imageNamed:@"Message@2x"] forState:UIControlStateNormal];
        [_arrowImageBtn addTarget:self action:@selector(showMoreActionView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowImageBtn;
}

- (UIView *)lineView{
    
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UIView *)innerContentView{
    if (!_innerContentView) {
        _innerContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 71, SCREENWIDTH, 56)];
        _innerContentView.backgroundColor = [UIColor lightTextColor];
        [_innerContentView addSubview:self.deleteBtn];
        [_innerContentView addSubview:self.editBtn];
        [_innerContentView addSubview:self.shareBtn];
    }
    return _innerContentView;
}

- (CustomButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[CustomButton alloc] initWithFrame:CGRectMake((SCREENWIDTH - 3*ButtonWidth - ButtonInterSpace*2)/2, 11, ButtonWidth, 34.f) withImage:@"Album3_Selected@2x" withTitle:@"删除"];
        _deleteBtn.tag = ActionBtnDeleteIndex;
        [_deleteBtn addTarget:self action:@selector(moreBtnActionView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (CustomButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [[CustomButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.deleteBtn.frame)+ButtonInterSpace, 11, ButtonWidth, 34.f) withImage:@"Album3_Selected@2x" withTitle:@"重命名"];
        _editBtn.tag = ActionBtnEditIndex;
        [_editBtn addTarget:self action:@selector(moreBtnActionView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

- (CustomButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [[CustomButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.editBtn.frame)+ButtonInterSpace, 11, ButtonWidth, 34.f) withImage:@"Album3_Selected@2x" withTitle:@"分享"];
        _shareBtn.tag = ActionBtnShareIndex;
        [_shareBtn addTarget:self action:@selector(moreBtnActionView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
