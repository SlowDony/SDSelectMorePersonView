//
//  SmallDuiGouTableViewCell.h
//  tcrj_tcyun
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmallDuiGouTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *cellDuiGouImage;

@property (nonatomic,strong)UILabel *cellLabel;

-(void)setModle:(BOOL)isBool;
@end
