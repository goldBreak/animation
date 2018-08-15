//
//  ViewController.m
//  RefreshAnimation
//
//  Created by xsd on 2017/11/14.
//  Copyright © 2017年 com.shuxuan.fwex. All rights reserved.
//

#import "ViewController.h"
#import "animationModel.h"

#import "AnimationViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *animationList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"动画汇总";
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initAnimationData];
    //animations
    [self.view addSubview:self.tableView];
}

#pragma mark - action
- (void)initAnimationData {
    
    animationModel *animaiton = [animationModel new];
    animaiton.classNameStr = @"Refresh2_Animation_View";
    animaiton.nameString = @"果冻刷新动画";
    animaiton.type = animationType_refresh;
    
    animationModel *qqAnimation = [animationModel new];
    qqAnimation.classNameStr = @"QQRefresh_animation_View";
    qqAnimation.nameString = @"QQ刷新动画";
    qqAnimation.type = animationType_refresh;
    
    animationModel *bossRefreshAnimation = [animationModel new];
    bossRefreshAnimation.classNameStr = @"bossRefreshView";
    bossRefreshAnimation.nameString = @"boss刷新动画";
    bossRefreshAnimation.type = animationType_refresh;
    
    animationModel *littleRedBookAnimation = [animationModel new];
    littleRedBookAnimation.classNameStr = @"littleRedBookView";
    littleRedBookAnimation.nameString = @"小红书刷新动画";
    littleRedBookAnimation.type = animationType_refresh;
    
    [self.animationList setObject:@[animaiton,qqAnimation,bossRefreshAnimation,littleRedBookAnimation] forKey:@"refreshAnimation"];
    
    animationModel *animaiton1 = [animationModel new];
    animaiton1.classNameStr = @"WaterWaveView";
    animaiton1.nameString = @"海浪动画";
    animaiton1.type = animationType_other;
    
    animationModel *textAnimation = [animationModel new];
    textAnimation.classNameStr = @"TextAnimation";
    textAnimation.nameString = @"文字动画";
    textAnimation.type = animationType_other;
  
    animationModel *factorAnimation = [animationModel new];
    factorAnimation.classNameStr = @"FactorView";
    factorAnimation.nameString = @"翻页动画";
    factorAnimation.type = animationType_other;
    
    [self.animationList setObject:@[animaiton1,textAnimation,factorAnimation] forKey:@"others"];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.animationList.allKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.animationList[self.animationList.allKeys[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellFlag = @"cellFlag";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellFlag];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellFlag];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //class...
    NSArray *data = self.animationList[self.animationList.allKeys[indexPath.section]];
    animationModel *model = data[indexPath.row];
    cell.textLabel.text = model.nameString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    NSArray *data = self.animationList[self.animationList.allKeys[indexPath.section]];
    animationModel *model = data[indexPath.row];
    
    AnimationViewController *animationVC = [[AnimationViewController alloc] init];
    animationVC.className = model.classNameStr;
    animationVC.title = model.nameString;
    [self.navigationController pushViewController:animationVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 20.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    static NSString *footerFlag = @"footerFlag";
    
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerFlag];
    
    if (!footerView) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerFlag];
    }
    
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *headerFlag = @"headerFlag";
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerFlag];
    
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerFlag];
    }
    
    headerView.textLabel.text = [self.animationList.allKeys objectAtIndex:section];
    
    return headerView;
}

#pragma mark - lazy

- (NSMutableDictionary *)animationList {
    
    if (!_animationList) {
        
        _animationList = [NSMutableDictionary dictionary];
    }
    return _animationList;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        CGRect frame = self.view.frame;
        frame.origin.y = 64.0;
        frame.size.height -= 64.0;
        
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44.0;
        
    }
    return _tableView;
}

@end
