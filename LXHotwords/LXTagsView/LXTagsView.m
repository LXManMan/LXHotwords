//
//  LXTagsView.m
//  LXHotwords
//
//  Created by zhongzhi on 2017/8/25.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXTagsView.h"
#import "UIColor+Expanded.h"
@interface LXTagsView()
@property(nonatomic,copy)itemClickBlock itemBlock;
@property(nonatomic,strong)NSMutableArray *tagsFrames;
@end
@implementation LXTagsView

-(instancetype)initWithFrame:(CGRect)frame ItemClick:(itemClickBlock)click{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.itemBlock = click;
        
        _tagsLineSpace = 5;
        _tagsMargin = 10;
        _tagInsetSpace = 10;
        _tagSpace = 10;
        _totalH = 0;
    }
    return self;
}


-(void)setTagsArray:(NSArray *)tagsArray{
    
    _tagsArray  = tagsArray;
    
    
    [self configTagsFrames];
    
    [self setupUI];
    
}
#pragma mark--- 设置frame ---
-(void)configTagsFrames{
    
    
    CGFloat orignHMargin = _tagSpace;// 水平方向左边距
    CGFloat orignVerMargin = 5;//上边距参考父视图
    CGFloat btnH = 25;
    _totalH = 0;
    
    
    [self.tagsFrames removeAllObjects];
    
    
    for (int i = 0; i< _tagsArray.count; i++) {
        NSString *string = _tagsArray[i];
        CGFloat btnW = [self stringSizeWithFont:_btnFont string:string height:btnH].width +  2*_tagInsetSpace;
        //增加个判断，当字符串过长是，超过屏幕总宽度- 两侧间距，重置标签宽度
        if (btnW + _tagSpace *2 >= KScreenW) {
            btnW = KScreenW - 2 *_tagSpace;
        }
        if ( orignHMargin + btnW + _tagSpace > KScreenW) {
            orignVerMargin = orignVerMargin + btnH + _tagsLineSpace;
            orignHMargin = _tagSpace;
        }
        
        CGRect frame= CGRectMake(orignHMargin, orignVerMargin, btnW, btnH);
        [self.tagsFrames addObject:NSStringFromCGRect(frame)];
        
        //判断是 最后一个标签的时候保存其高度；
        if (i == _tagsArray.count -1) {
            _totalH = orignVerMargin + btnH +10;
        }
        
        orignHMargin = orignHMargin + btnW +_tagsMargin;
        
    }
    
    //设置整体高度
    self.height = _totalH;
    
}
#pragma mark---设置UI--
-(void)setupUI{
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    
    for (int i = 0; i< _tagsFrames.count; i++) {
        CGRect frame = CGRectFromString(_tagsFrames[i]);
        
        
        LxButton *button =[LxButton LXButtonWithTitle:_tagsArray[i] titleFont:_btnFont Image:nil backgroundImage:nil backgroundColor:[UIColor hexStringToColor:@"f5f5f5"] titleColor:[UIColor blackColor] frame:frame];
        
        //对于宽度的处理
        if (frame.size.width == KScreenW - 2 *_tagSpace) {
            
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, _tagInsetSpace, 0, _tagInsetSpace)];
        }
        
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(frame.size.height/2, frame.size.height/2)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = button.bounds;
        maskLayer.path = maskPath.CGPath;
        button.layer.mask = maskLayer;
        button.buttonID = i;
        
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    
}

-(void)btnClick:(LxButton *)button
{
    if (_itemBlock) {
        _itemBlock(button.buttonID);
    }
}
-(void)setBtnFont:(UIFont *)btnFont
{
    _btnFont = btnFont;
}
-(void)setTagInsetSpace:(CGFloat)tagInsetSpace
{
    _tagInsetSpace = tagInsetSpace;
}
-(void)setTagsLineSpace:(CGFloat)tagsLineSpace
{
    _tagsLineSpace = tagsLineSpace;
}
-(void)setTagsMargin:(CGFloat)tagsMargin
{
    _tagsMargin = tagsMargin;
}
-(void)setTagSpace:(CGFloat)tagSpace
{
    _tagSpace = tagSpace;
}
-(NSMutableArray *)tagsFrames{
    if (!_tagsFrames) {
        _tagsFrames =[NSMutableArray array];
    }
    return _tagsFrames;
}
#pragma mark---动态高度---
-(CGSize)stringSizeWithFont:(UIFont *)font string:(NSString *)string height:(CGFloat)height
{
    CGRect rect =[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}
@end
