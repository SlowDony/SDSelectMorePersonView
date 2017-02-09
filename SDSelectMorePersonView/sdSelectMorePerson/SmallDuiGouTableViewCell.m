

//
//  SmallDuiGouTableViewCell.m
//  tcrj_tcyun
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SmallDuiGouTableViewCell.h"

#import "Header.h"
@implementation SmallDuiGouTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        //label
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(40, 0, mDeviceWidth-50, 35);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        label.textColor=fontHightColor;
        self.cellLabel=label;
        [self addSubview:label];
        //

    }
    return self;
}
-(void)setModle:(BOOL)isBool
{
 
    if (isBool)
    {
//        self.cellDuiGouImage.hidden=NO;
        self.cellLabel.textColor=mainColor;
        self.backgroundColor=[UIColor whiteColor];
        self.accessoryType =UITableViewCellAccessoryCheckmark;
    }
    else
    {
//      self.cellDuiGouImage.hidden=YES;
        self.cellLabel.textColor=fontHightColor;
        self.backgroundColor=bjColor;
        self.accessoryType =UITableViewCellAccessoryNone;

        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
