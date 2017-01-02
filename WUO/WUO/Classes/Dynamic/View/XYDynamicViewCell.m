//
//  XYDynamicViewCell.m
//  WUO
//
//  Created by mofeini on 17/1/2.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYDynamicViewCell.h"

@interface XYDynamicViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *investBtn;

@end

@implementation XYDynamicViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.investBtn.layer.cornerRadius = 5;
    [self.investBtn.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
