//
//  XYDynamicTableView.m
//  WUO
//
//  Created by mofeini on 17/1/3.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYDynamicTableView.h"
#import "XYRefreshGifFooter.h"
#import "XYRefreshGifHeader.h"
#import "XYDynamicViewModel.h"
#import "WUOHTTPRequest.h"
#import "XYDynamicViewCell.h"


@interface XYDynamicTableView () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation XYDynamicTableView {
        
        NSMutableArray<XYDynamicViewModel *> *_dynamicList;
        XYDynamicInfo *_dynamicInfo;
    
}

static NSString * const cellIdentifier = @"XYDynamicViewCell";



- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
       
        _dynamicList = [NSMutableArray arrayWithCapacity:0];
        
        [self registerNib:[UINib nibWithNibName:@"XYDynamicViewCell" bundle:nil] forCellReuseIdentifier:@"XYDynamicViewCell"];
        
        self.mj_header = [XYRefreshGifHeader headerWithRefreshingBlock:^{
            _dynamicInfo.idstamp = 0;
            [self loadData];
        }];
        
        self.mj_footer = [XYRefreshGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        
        [self.mj_header beginRefreshing];
    
        
    }
    return self;
}

- (void)loadData {
    [self loadDataFromNetwork];
}

- (void)loadDataFromNetwork {
    
    [WUOHTTPRequest setActivityIndicator:YES];
    
    [WUOHTTPRequest dynamicWithIdstamp:[NSString stringWithFormat:@"%ld",_dynamicInfo.idstamp] finished:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (error) {
            [self.mj_header endRefreshing];
            [self.mj_footer endRefreshing];
            [WUOHTTPRequest setActivityIndicator:NO];
            [self xy_showMessage:@"网络请求失败"];
            return;
        }
        
        _dynamicInfo = [XYDynamicInfo dynamicInfoWithDict:responseObject];
        
        if ([responseObject[@"code"] integerValue] == 0) {
            
            for (id obj in responseObject[@"datas"]) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    XYDynamicItem *item = [XYDynamicItem dynamicItemWithDict:obj info:_dynamicInfo];
                    XYDynamicViewModel *viewModel = [XYDynamicViewModel dynamicViewModelWithItem:item info:_dynamicInfo];
                    [_dynamicList addObject:viewModel];
                }
            }
        }
        
        [WUOHTTPRequest setActivityIndicator:NO];
        
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
        [self reloadData];
        
    }];
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dynamicList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XYDynamicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    XYDynamicViewModel *viewModel = _dynamicList[indexPath.row];
    cell.viewModel = viewModel;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XYDynamicViewModel *viewModel = _dynamicList[indexPath.row];
    
    return viewModel.cellHeight;
//    return 350;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", NSStringFromCGRect([tableView dequeueReusableCellWithIdentifier:cellIdentifier].frame));
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"%s", __func__);
}

@end
