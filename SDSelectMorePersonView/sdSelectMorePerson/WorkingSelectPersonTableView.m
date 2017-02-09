//
//  WorkingSelectPersonTableView.m
//  tcrj_oa
//
//  Created by apple on 2017/2/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "WorkingSelectPersonTableView.h"

#import "SmallDuiGouTableViewCell.h"

#import "Header.h"

@interface WorkingSelectPersonTableView () <UITableViewDelegate,UITableViewDataSource>
{
    NSIndexPath *seleceIndexPath;
    BOOL isShow;
    
}


@end
@implementation WorkingSelectPersonTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self =[super initWithFrame:frame style:style];
    if (self) {
        self.dataSource=self;
        self.delegate=self;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        isShow=YES;
        self.selectedIndexs =[[NSMutableDictionary alloc]init];
        self.selectedArr =[[NSMutableArray alloc]init];
        self.tableFooterView =[[UIView alloc]init];
    }
    return self;
}

#pragma mark ----------UITabelViewDataSource----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellID";
    SmallDuiGouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell =[[SmallDuiGouTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    //配置数据
    NSDictionary *dic =self.dataArray[indexPath.row];
    
    cell.cellLabel.text=dic[@"StaffName"];
    
    [cell setModle:[self cellISSelected:indexPath]];
    return cell;
}


-(BOOL)cellISSelected:(NSIndexPath *)indexPath{
    NSNumber *selectedIndex  =[self.selectedIndexs objectForKey:indexPath];
    return selectedIndex ==nil ? FALSE :[selectedIndex boolValue];
}
#pragma mark ----------UITabelViewDelegate----------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    seleceIndexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    isShow=!isShow;
    
    if (![self.selectedIndexs objectForKey:indexPath])
    {
        NSDictionary *dic= self.dataArray[indexPath.row];
        NSNumber *selectIndex =[NSNumber numberWithBool:YES];
        [self.selectedIndexs setObject:selectIndex forKey:indexPath];
        [self.selectedArr addObject:dic];
        
    }else{
        NSDictionary *dict= self.dataArray[indexPath.row];
        NSNumber *selectIndex =[NSNumber numberWithBool:NO];
        [self.selectedIndexs setObject:selectIndex forKey:indexPath];
        [self.selectedIndexs removeObjectForKey:indexPath];
        [self.selectedArr removeObject:dict];
        
    }
    [tableView reloadData];
    if ([self.w_delegate respondsToSelector:@selector(WorkingSelectPersonSelectView:didSelectRowAtIndexPath:AndSelectArr:)]){
        [self.w_delegate WorkingSelectPersonSelectView:tableView didSelectRowAtIndexPath:indexPath AndSelectArr:self.selectedArr];
    }
//    DLog(@"self.selectedArr:%@",self.selectedArr);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

@end
