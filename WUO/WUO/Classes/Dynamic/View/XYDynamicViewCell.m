//
//  XYDynamicViewCell.m
//  WUO
//
//  Created by mofeini on 17/1/2.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYDynamicViewCell.h"
#import <UIImageView+WebCache.h>
#import "XYDynamicViewModel.h"
#import "XYDynamicToolButton.h"
#import "UIImage+XYExtension.h"
#import "XYPictureCollectionView.h"

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
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet XYPictureCollectionView *pictureCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picBottomLayoutConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picHeightLayoutConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picWidthLayoutConst;
@property (weak, nonatomic) IBOutlet UIView *toolView;


@end

@implementation XYDynamicViewCell {
    BOOL _isRefreshed;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //不透明，提升渲染性能
        self.contentView.opaque = YES;
    }
    return self;
}

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
- (void)setViewModel:(XYDynamicViewModel *)viewModel {
    
    _viewModel = viewModel;
    
    XYDynamicItem *item = viewModel.item;
    self.pictureCollectionView.dynamicItem = item;
    
    self.pictureCollectionView.hidden = item.imgCount == 0;
    [self.headerImageView sd_setImageWithURL:item.headerImageURL placeholderImage:[UIImage imageNamed:@"mine_HeadImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.headerImageView.image = [self.headerImageView.image xy_circleImage];
    }];
    self.jobLabel.text = item.job;
    self.jobLabel.hidden = !item.job.length;
    self.nameLabel.text = item.name;
    self.title_label.text = item.title;
    self.contenLabel.text = item.content;
    self.contenLabel.hidden = !item.content.length;
    [self.readCountBtn setTitle:[NSString stringWithFormat:@"%ld人预览", item.readCount] forState:UIControlStateNormal];
    
    [self.shareCountBtn setTitle:[NSString stringWithFormat:@"%ld", item.shareCount] forState:UIControlStateNormal];
    [self.commentCountBtn setTitle:[NSString stringWithFormat:@"%ld", item.commentCount] forState:UIControlStateNormal];
    [self.investCountBtn setTitle:[NSString stringWithFormat:@"%ld", item.rewardCount] forState:UIControlStateNormal];
    [self.praiseCountBtn setTitle:[NSString stringWithFormat:@"%ld", item.praiseCount] forState:UIControlStateNormal];
    
    CGSize picViewSize = [self caculatePicViewSize:item.imgList.count];
    self.picWidthLayoutConst.constant = picViewSize.width;
    self.picHeightLayoutConst.constant = picViewSize.height;
    
    [self layoutIfNeeded];
    
    CGFloat contentMaxY = 0.0;
    // 计算cell的高度
    if (item.content.length && item.title.length && self.pictureCollectionView.hidden) {
        contentMaxY = CGRectGetMaxY(self.contenLabel.frame);
    } else if (!item.content.length && item.title.length && self.pictureCollectionView.hidden) {
        contentMaxY = CGRectGetMaxY(self.title_label.frame);
    } else if (item.content.length && item.title.length && !self.pictureCollectionView.hidden ) {
        contentMaxY = CGRectGetMaxY(self.contenLabel.frame);
    } else if (!item.content.length && !item.title.length && !self.pictureCollectionView.hidden) {
        contentMaxY = CGRectGetMaxY(self.pictureCollectionView.frame);
    } else if (!item.content.length && !self.pictureCollectionView.hidden && item.title.length) {
        contentMaxY = CGRectGetMaxY(self.title_label.frame);
    }
    
    if (viewModel.cellHeight == 0) {
        _isRefreshed = [[NSUserDefaults standardUserDefaults] integerForKey:@"isRefreshedKey"];
        if (_isRefreshed == NO) {
            UITableView *tableView = self.superview.superview;
            [tableView reloadData];
            [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"isRefreshedKey"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        [self layoutIfNeeded];
        viewModel.cellHeight = contentMaxY + CGRectGetHeight(self.toolView.frame) + 5 + 10 + 20 + CGRectGetHeight(self.readCountBtn.frame) + 20;
        
    }
}


// 计算collectionView的尺寸
- (CGSize)caculatePicViewSize:(NSInteger)count {
    
    CGFloat itemWH = 0.0;
    CGFloat itemMargin = 5;
    
    if (count == 0) {
        self.picBottomLayoutConst.constant = 0;
        return CGSizeZero;
    }
    
    self.picBottomLayoutConst.constant = 10;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.pictureCollectionView.collectionViewLayout;
    
    if (count == 1) {
        itemWH = 150;
        layout.itemSize = CGSizeMake(itemWH, itemWH);
        return CGSizeMake(itemWH, itemWH);
    }

    // 其他
    // 计算行数
    NSInteger rows = (count - 1) / 3 + 1;

    CGFloat contentWidth = kScreenW - 10 - self.nameLabel.frame.origin.x;
    
    itemWH = (contentWidth - 2 * itemMargin) / 3;
    
    if (count == 4) {
        layout.itemSize = CGSizeMake(itemWH, itemWH);
        return CGSizeMake(itemWH * 2 + itemMargin, itemWH * 2 + itemMargin);
    }

    layout.itemSize = CGSizeMake(itemWH, itemWH);
    
    CGFloat picViewW = contentWidth;
    CGFloat picViewH = rows * itemWH + (rows - 1) * itemMargin;
    
    
    return CGSizeMake(picViewW, picViewH);
}
@end
