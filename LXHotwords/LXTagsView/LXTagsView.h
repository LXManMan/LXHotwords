//
//  LXTagsView.h
//  LXHotwords
//
//  Created by zhongzhi on 2017/8/25.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^itemClickBlock) (NSInteger index);
@interface LXTagsView : UIView

-(instancetype)initWithFrame:(CGRect)frame ItemClick:(itemClickBlock)click;

@property(nonatomic,strong)UIFont *btnFont;//先赋值；
@property(nonatomic,assign)CGFloat tagInsetSpace;//标签内间距 (左右各间距)
@property(nonatomic,assign)CGFloat tagsLineSpace;//标签行间距
@property(nonatomic,assign)CGFloat tagsMargin;//标签之间的间距
@property(nonatomic,assign)CGFloat tagSpace;// 整体左右边距

@property(nonatomic,strong)NSArray *tagsArray; // 文字标签数组



@property(nonatomic,assign)CGFloat totalH; //返回总高度
@end
