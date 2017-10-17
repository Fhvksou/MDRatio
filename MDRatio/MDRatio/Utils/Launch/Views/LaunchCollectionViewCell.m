//
//  LaunchCollectionViewCell.m
//  MDRatio
//
//  Created by fhkvsou on 2017/10/16.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "LaunchCollectionViewCell.h"

@interface LaunchCollectionViewCell ()

@property (nonatomic ,strong) UIImageView * imageVc;
@property (nonatomic ,strong) UIButton * startButton;

@end

@implementation LaunchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

- (void)initViews{
    _imageVc = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _imageVc.contentMode = UIViewContentModeScaleAspectFit;
    _imageVc.clipsToBounds = YES;
    [self.contentView addSubview:_imageVc];

    _startButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    _startButton.backgroundColor = [UIColor redColor];
    _startButton.center = CGPointMake(ScreenWidth / 2, ScreenHeight - 100);
    [_startButton addTarget:self action:@selector(clickStartButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_startButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageVc.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    _startButton.center = CGPointMake(ScreenWidth / 2, ScreenHeight - 100);
}

- (void)clickStartButton{
    if (_delegate && [_delegate respondsToSelector:@selector(clickStartAppButton)]) {
        [_delegate clickStartAppButton];
    }
}

- (void)hidenStartButton:(BOOL)hiden{
    _startButton.hidden = hiden;
}

- (void)updateWithImageUrl:(NSString *)url{
    _imageVc.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",url]];
}

@end
