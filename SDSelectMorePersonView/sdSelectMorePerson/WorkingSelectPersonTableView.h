//
//  WorkingSelectPersonTableView.h
//  tcrj_oa
//
//  Created by apple on 2017/2/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol WorkingSelectPersonTableViewDelegate <NSObject>

//-(void)WorkingSelectPersonSelectView:(UIView *)yiXiangChanPinSelectView AndChongzhiClicked:(UIButton *)sender;

-(void)WorkingSelectPersonSelectView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath AndSelectArr:(NSArray *)selectArr;

@end
@interface WorkingSelectPersonTableView : UITableView
@property (nonatomic,assign)id<WorkingSelectPersonTableViewDelegate>w_delegate;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong )NSMutableDictionary *selectedIndexs;
@property (nonatomic,strong)NSMutableArray *selectedArr;
@end
