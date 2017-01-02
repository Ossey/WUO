//
//  XYDynamicViewCell.m
//  WUO
//
//  Created by mofeini on 17/1/2.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYDynamicViewCell.h"
#import <UIImageView+WebCache.h>
#import "XYDynamicItem.h"
#import "XYDynamicToolButton.h"
#import "UIImage+XYExtension.h"

@interface XYDynamicViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *investBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *contenLabel;
@property (weak, nonatomic) IBOutlet UIButton *readCountBtn;
@property (weak, nonatomic) IBOutlet XYDynamicToolButton *shareCountBtn;
@property (weak, nonatomic) IBOutlet XYDynamicToolButton *commentCountBtn;
@property (weak, nonatomic) IBOutlet XYDynamicToolButton *investCountBtn;
@property (weak, nonatomic) IBOutlet XYDynamicToolButton *praiseCountBtn;

@end

@implementation XYDynamicViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.investBtn.layer.cornerRadius = 5;
    [self.investBtn.layer setMasksToBounds:YES];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(XYDynamicItem *)item {
    
    _item = item;
    
    [self.headerImageView sd_setImageWithURL:item.headerImageURL placeholderImage:[UIImage imageNamed:@"mine_HeadImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.headerImageView.image = [self.headerImageView.image xy_circleImage];
    }];
    
    self.nameLabel.text = item.name;
    self.title_label.text = item.title;
    self.contenLabel.text = item.content;
    [self.readCountBtn setTitle:[NSString stringWithFormat:@"%ld", item.readCount] forState:UIControlStateNormal];
    
    [self.shareCountBtn setTitle:[NSString stringWithFormat:@"%ld", item.shareCount] forState:UIControlStateNormal];
    [self.commentCountBtn setTitle:[NSString stringWithFormat:@"%ld", item.commentCount] forState:UIControlStateNormal];
    [self.investCountBtn setTitle:[NSString stringWithFormat:@"%ld", item.rewardCount] forState:UIControlStateNormal];
    [self.praiseCountBtn setTitle:[NSString stringWithFormat:@"%ld", item.praiseCount] forState:UIControlStateNormal];
}

@end
