//
//  MessageListCell.m
//  yindou
//
//  Created by 冯倩 on 16/8/23.
//  Copyright © 2016年 Beijing Orient Wealth information technology Ltd. All rights reserved.
//

#import "MessageListCell.h"
@implementation MessageListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        
        //白色contentView
        _contentMainView = [[UIView alloc] init];
        _contentMainView.layer.masksToBounds = YES;
        _contentMainView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_contentMainView];
        
        //标题 label
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor grayColor];
        [_contentMainView addSubview:_titleLabel];
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    //编辑状态下宽度减少50
    CGFloat x = self.editing ? 34 : 15;
    _contentMainView.frame = CGRectMake(15, 8, self.frame.size.width - x * 2, self.frame.size.height - 8 * 2);
    _contentMainView.layer.cornerRadius = 8;
    _titleLabel.numberOfLines = 0;
    _titleLabel.frame = CGRectMake(15, 8, _contentMainView.frame.size.width - 15 * 2, _contentMainView.frame.size.height - 8 * 2);
    
    
    //设置选中和未选中的图片,未选中时为系统自带圆圈圈,选中时为银豆橘色图片
    for (UIControl *control in self.subviews)
    {
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")])
        {
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]])
                {
                    UIImageView *img=(UIImageView *)v;
                    img.image=[UIImage imageNamed:self.selected ? @"点击" : @"未点击"];
                }
                return;
            }
        }
    }
    
}

- (void)dealloc
{
    _contentMainView = nil;
    _titleLabel      = nil;
}



@end
