//
//  WorkingSelectPersonView.h
//  tcrj_oa
//
//  Created by apple on 2017/2/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkingSelectPersonView : UIView
-(instancetype )initWithFrame:(CGRect)frame WithDic:(NSDictionary *)data;
@property (nonatomic,strong)NSDictionary *data;


@property (nonatomic,copy)void(^valueArrBlock)(NSMutableArray *arr);

@end
