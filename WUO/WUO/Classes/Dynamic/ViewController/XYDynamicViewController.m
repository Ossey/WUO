//
//  XYDynamicViewController.m
//  WUO
//
//  Created by mofeini on 17/1/1.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYDynamicViewController.h"
#import "XYDynamicViewCell.h"
#import "WUOHTTPRequest.h"
#import "XYDynamicItem.h"
#import "XYDynamicInfo.h"
#import "XYRefreshGifHeader.h"

@interface XYDynamicViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<XYDynamicItem *> *dynamicList;
@property (nonatomic, strong) XYDynamicInfo *dynamicInfo;
@end

@implementation XYDynamicViewController

static NSString * const cellIdentifier = @"XYDynamicViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = kColor(238, 238, 238, 1.0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYDynamicViewCell" bundle:nil] forCellReuseIdentifier:@"XYDynamicViewCell"];
    
    self.tableView.mj_header = [XYRefreshGifHeader headerWithRefreshingBlock:^{
        
        self.dynamicInfo.idstamp = 0;
        [self loadDataFromNetwork];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadData {
    [self loadDataFromNetwork];
}

- (void)loadDataFromNetwork {
    
    [WUOHTTPRequest setActivityIndicator:YES];
    
    [WUOHTTPRequest dynamicWithIdstamp:[NSString stringWithFormat:@"%ld",self.dynamicInfo.idstamp] finished:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (error) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [WUOHTTPRequest setActivityIndicator:NO];
            [self xy_showMessage:@"网络请求失败"];
            return;
        }
        
        self.dynamicInfo = [XYDynamicInfo dynamicInfoWithDict:responseObject];
        
        if ([responseObject[@"code"] integerValue] == 0) {
            
            for (id obj in responseObject[@"datas"]) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    XYDynamicItem *item = [XYDynamicItem dynamicItemWithDict:obj];
                    item.dynamicInfo = self.dynamicInfo;
                    [self.dynamicList addObject:item];
                }
            }
        }
        
        [WUOHTTPRequest setActivityIndicator:NO];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
    }];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dynamicList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XYDynamicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.item = self.dynamicList[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
}

- (NSMutableArray *)dynamicList {
    
    if (_dynamicList == nil) {
        _dynamicList = [NSMutableArray arrayWithCapacity:0];
    }
    return _dynamicList;
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

@end
