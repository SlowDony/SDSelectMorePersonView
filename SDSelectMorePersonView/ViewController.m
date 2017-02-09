//
//  ViewController.m
//  SDSelectMorePersonView
//
//  Created by apple on 2017/2/9.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import "ViewController.h"
#import "WorkingSelectPersonView.h"


#import "Header.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUI{
    
    [self addLab:@"选择人" andtextViewTag:1004 andH:250];
    
    //接访添加选择人员按钮
    UIButton *jiefangbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jiefangbtn.frame = CGRectMake(mDeviceWidth-40, 212.5+50, 25, 25);
    
    [jiefangbtn setImage:[UIImage imageNamed:@"img_addperson"] forState:UIControlStateNormal];
    [jiefangbtn  addTarget:self action:@selector(jiefangbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: jiefangbtn];
    
}
-(void)jiefangbtn{
    
    NSString *rootStr =[[NSBundle mainBundle]pathForResource:@"selectPersonData" ofType:@"plist"];
    NSDictionary *rootDic =[[NSDictionary alloc]initWithContentsOfFile:rootStr];
    NSLog(@"rootDic:%@",rootDic);
    
    UITextView *StaffNameT =[self.view viewWithTag:1004]; //接访人
    WorkingSelectPersonView *selectView = [[WorkingSelectPersonView alloc]initWithFrame:CGRectMake(0, 0, mDeviceWidth , mDeviceHeight) WithDic:rootDic];
    selectView.valueArrBlock =^(NSMutableArray *arr){
        
        NSMutableArray *StaffNameArr =[[NSMutableArray alloc]init];
        NSMutableArray *StaffIDArr =[[NSMutableArray alloc]init];
        for (NSDictionary *dic in arr) {
            [StaffNameArr addObject:dic[@"StaffName"]];
            [StaffIDArr addObject:dic[@"StaffID"]];
        }
        NSString * StaffNameStr=[StaffNameArr componentsJoinedByString:@","];
        NSString * StaffIdStr=[StaffIDArr componentsJoinedByString:@","];
        
        StaffNameT.text =StaffNameStr;
        NSLog(@"StaffIdStr:%@",StaffIdStr);
//        [dataDic setValue:StaffIdStr forKey:@"StaffID"];
        
    };
    [self.view addSubview:selectView];
}

#pragma mark - 布局label和输入框View
-(void)addLab:(NSString *)leftStr andtextViewTag:(NSInteger) tag andH:(CGFloat )h{
    //
    UILabel *leftlabel = [[UILabel alloc] init];
    leftlabel.frame = CGRectMake(0, h, 100, 50);
    leftlabel.backgroundColor = [UIColor clearColor];
    leftlabel.textColor = fontHightColor;
    leftlabel.text =[NSString stringWithFormat:@"%@:",leftStr];
    leftlabel.textAlignment = NSTextAlignmentRight;
    leftlabel.font = [UIFont systemFontOfSize:15];
    leftlabel.numberOfLines = 0;
    [self.view addSubview:leftlabel];
    
    UITextView *textV =[[UITextView alloc]init];
    
    textV.frame =CGRectMake(110, h+10, mDeviceWidth-160, 30);
    textV.editable=NO;
    textV.tag=tag;
    
    textV.backgroundColor = [UIColor clearColor];
    textV.textColor = fontHightColor;
    textV.textAlignment = NSTextAlignmentLeft;
    textV.font = [UIFont systemFontOfSize:15];
    textV.layer.cornerRadius=2;
    textV.layer.masksToBounds=YES;
    textV.layer.borderWidth=0.5;
    textV.layer.borderColor=borderCol.CGColor;
    
    [self.view addSubview:textV];
}


@end
