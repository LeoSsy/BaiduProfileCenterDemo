/**************************************************************************
 *
 *  Created by 舒少勇 on 2017/2/21.
 *    Copyright © 2017年 浙江踏潮流网络科技有限公司. All rights reserved.
 *
 * 项目名称：浙江踏潮-汇道-搏击项目
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "SYTableViewController.h"
#import "SYWaveView.h"
#import "UIImageView+SY.h"

static const CGFloat headerVh = 150;

@interface SYTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**header*/
@property(nonatomic,strong)SYWaveView *headerV;

/**icon*/
@property(nonatomic,strong)UIImageView *iconV;

/**setting*/
@property(nonatomic,strong)UIButton *setBtn;


@end

@implementation SYTableViewController

- (SYWaveView *)headerV
{
    if (!_headerV) {
        _headerV = [[SYWaveView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, headerVh)];
        _headerV.backgroundColor = [UIColor redColor];
        __weak typeof(self) weakSelf = self;
        _headerV.waveBlock = ^(CGFloat currentY){
            CGRect frame = weakSelf.iconV.frame;
            frame.origin.y = CGRectGetHeight(weakSelf.headerV.frame)-CGRectGetHeight(weakSelf.iconV.frame)+currentY-weakSelf.headerV.waveHeight;
            weakSelf.iconV.frame = frame;
        };
        [_headerV startWaveAnimation];
    }
    return _headerV;
}

- (UIImageView *)iconV
{
    if (!_iconV) {
        _iconV = [UIImageView gifWithName:@"avater.gif" frame:CGRectMake((self.view.bounds.size.width - 50)*0.5, 0, 50, 50)];
        [self.view addSubview:_iconV];
    }
    return _iconV;
}

- (UIButton *)setBtn
{
    if (!_setBtn) {
        _setBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 50, 20, 40, 40)];
        [_setBtn setTitle:@"设置" forState:UIControlStateNormal];
        [_setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchDown];
    }
    return _setBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.headerV];
    [self.view addSubview:self.setBtn];
    self.tableView.contentInset = UIEdgeInsetsMake(headerVh, 0, 0, 0);

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"个人中心==%zd",indexPath.row];
    return cell;
}

#pragma mark event
- (void)setBtnClick
{
    NSLog(@"setBtnClicksetBtnClicksetBtnClick");
}

@end
