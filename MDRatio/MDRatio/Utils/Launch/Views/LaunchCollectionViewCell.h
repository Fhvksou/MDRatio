//
//  LaunchCollectionViewCell.h
//  MDRatio
//
//  Created by fhkvsou on 2017/10/16.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LaunchCollectionViewCellDelegate <NSObject>

- (void)clickStartAppButton;

@end

@interface LaunchCollectionViewCell : UICollectionViewCell

@property (nonatomic ,weak) id<LaunchCollectionViewCellDelegate> delegate;

- (void)hidenStartButton:(BOOL)hiden;
- (void)updateWithImageUrl:(NSString *)url;

@end
