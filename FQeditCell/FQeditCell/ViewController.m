//
//  ViewController.m
//  FQeditCell
//
//  Created by 冯倩 on 2016/11/15.
//  Copyright © 2016年 冯倩. All rights reserved.
//

#import "ViewController.h"
#import "MessageListCell.h"                         //自定义 cell
#import "messageDetailController.h"                 //详情Controller

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView              *_messageListTableView;     //主 tableView
    UIButton                 *_editBtn;                  //右上角编辑按钮
    UIButton                 *_selectDeleteButton;       //编辑状态下的删除按钮
    NSMutableArray           *_dataArray;                //假数据数组
    NSMutableArray           *_selectArray;              //选中的数据数组
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    
    //initData
    [self initData];
    
    //navigation
    [self navigationUI];
    //tableView
    [self tableViewUI];
    //ToolBar
    [self toolBarUI];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - InitData
- (void)initData
{
    //初始化假数据数组
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"1111111111111111111111111111111111111111111111111111111111”",
                  @"22222222222222222222222222222222222222222222222222222222222",
                  @"333333333333333333333333333333333333333333333333333333333333",
                  @"444444444444444444444444444444444444444444444444444444444444",
                  @"555555555555555555555555555555555555555555555555555555555555",
                  @"666666666666666666666666666666666666666666666666666666666666",
                  @"777777777777777777777777777777777777777777777777777777777777",
                  @"888888888888888888888888888888888888888888888888888888888888",
                  @"999999999999999999999999999999999999999999999999999999999999",
                  nil];
    //初始化选择数据数组
    _selectArray = [[NSMutableArray alloc] init];
}

#pragma mark - LayoutUI
- (void)navigationUI
{
    _editBtn = [[UIButton alloc] init];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_editBtn sizeToFit];
    _editBtn.hidden = _dataArray.count == 0 ? YES : NO;
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:_editBtn];
    self.navigationItem.rightBarButtonItems = @[editItem];
}

- (void)tableViewUI
{
    _messageListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
    _messageListTableView.backgroundColor = [UIColor clearColor];
    _messageListTableView.dataSource = self;
    _messageListTableView.delegate = self;
    [self.view addSubview:_messageListTableView];
}

- (void)toolBarUI
{
    CGFloat itemWidth = (self.view.frame.size.width - 50) / 3;
    //标记已读
    UIButton *marketButton= [UIButton buttonWithType:UIButtonTypeSystem];
    marketButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [marketButton setTitle:@"标记已读" forState:UIControlStateNormal];
    [marketButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [marketButton addTarget:self action:@selector(marketButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [marketButton sizeToFit];
    UIBarButtonItem *marketItem = [[UIBarButtonItem alloc] initWithCustomView:marketButton];
    marketItem.width = itemWidth;
    
    //删除
    _selectDeleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _selectDeleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_selectDeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [_selectDeleteButton addTarget:self action:@selector(selectDeleteItemAction) forControlEvents:UIControlEventTouchUpInside];
    [_selectDeleteButton sizeToFit];
    UIBarButtonItem *selectDeleteItem = [[UIBarButtonItem alloc] initWithCustomView:_selectDeleteButton];
    selectDeleteItem.width = itemWidth;
    //默认灰色不可点击
    [_selectDeleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _selectDeleteButton.enabled = NO;
    
    //全部删除
    UIButton *allDeleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    allDeleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [allDeleteButton setTitle:@"全部删除" forState:UIControlStateNormal];
    [allDeleteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [allDeleteButton addTarget:self action:@selector(allDeleteItemAction) forControlEvents:UIControlEventTouchUpInside];
    [allDeleteButton sizeToFit];
    UIBarButtonItem *allDeleteItem = [[UIBarButtonItem alloc] initWithCustomView:allDeleteButton];
    allDeleteItem.width = itemWidth;
    
    self.toolbarItems = @[marketItem,selectDeleteItem,allDeleteItem];
}

#pragma mark - Methods
- (void)nonEditorState
{
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.navigationController setToolbarHidden:YES animated:YES];
    _messageListTableView.editing = NO;
    if (_selectArray)
    {
        [_selectArray removeAllObjects];
        [_selectDeleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _selectDeleteButton.enabled = NO;
    }
    _editBtn.selected = !_editBtn.selected;
    [_messageListTableView reloadData];
}

#pragma mark - Action
//编辑
- (void)editBtnAction:(UIButton *)button
{
    [button setTitle:button.selected ? @"编辑" : @"取消" forState:UIControlStateNormal];
    _messageListTableView.editing = !button.selected;
    [self.navigationController setToolbarHidden:button.selected animated:YES];
    if (button.selected)
    {
        [_selectArray removeAllObjects];
        [_selectDeleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _selectDeleteButton.enabled = NO;
    }
    
     button.selected = !button.selected;

}
//标记已读
- (void)marketButtonAction
{
    [self nonEditorState];
}
//删除
- (void)selectDeleteItemAction
{
    [_dataArray removeObjectsInArray:_selectArray];
    [_selectDeleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _selectDeleteButton.enabled = NO;
    
    [self nonEditorState];
    if (_dataArray.count == 0)
        _editBtn.hidden = YES;
    
}
//全部删除
- (void)allDeleteItemAction
{
    for (int i = 0; i < _dataArray.count; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [_messageListTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    //弹出提示框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定全部删除吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
    {
        for (int i = 0; i < _dataArray.count; i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [_messageListTableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        [_dataArray removeAllObjects];
        _editBtn.hidden = YES;
        [self nonEditorState];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MessageListId";
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[MessageListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.titleLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
//编辑时前面的图片为系统自带的圈圈
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}

//点击第一下为选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_editBtn.selected)
    {
        [_selectArray addObject:_dataArray[indexPath.row]];
        [_selectDeleteButton setTitleColor:_selectArray.count > 0 ? [UIColor redColor] : [UIColor lightGrayColor] forState:UIControlStateNormal];
        _selectDeleteButton.enabled = _selectArray.count > 0 ? YES : NO;
    }
    //非编辑模式下,跳转界面
    else
    {
        messageDetailController *vc = [[messageDetailController alloc] init];
        vc.messageDetail = _dataArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
//再点击为取消选中
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_editBtn.selected)
    {
        [_selectArray removeObject:_dataArray[indexPath.row]];
        [_selectDeleteButton setTitleColor:_selectArray.count > 0 ? [UIColor redColor] : [UIColor lightGrayColor] forState:UIControlStateNormal];
        _selectDeleteButton.enabled = _selectArray.count > 0 ? YES : NO;
    }
    //非编辑状态下,什么也不做
    else
        return;
}


@end
