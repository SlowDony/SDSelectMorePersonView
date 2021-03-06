//
//  WorkingSelectPersonView.m
//  tcrj_oa
//
//  Created by apple on 2017/2/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "WorkingSelectPersonView.h"
#import "WorkingSelectPersonTableView.h"

#import "Header.h"

@interface  WorkingSelectPersonView()
<UIGestureRecognizerDelegate,
UITableViewDelegate,
UITableViewDataSource,

WorkingSelectPersonTableViewDelegate
>

{
    UIView *bjView;
    NSArray *RoleList; //角色集合
    NSArray *StaffList; //用户集合
    NSArray *DeptList; //部门集合
    UITableView* personTab; //人员列表
    NSMutableArray *tabArr; //部门角色数据源
    NSMutableArray *smallTabArr; //人员数据源
    NSMutableDictionary *selectDic ;//最终选择人员字典
    NSMutableArray *selectArray; //最终多项选择人员的数组集合
    
    WorkingSelectPersonTableView * selectPersonTab; //可选人员可多选
    UIView *tabView; //tableView的背景
}

@end
@implementation WorkingSelectPersonView
-(instancetype )initWithFrame:(CGRect)frame WithDic:(NSDictionary *)data{
    self =[super initWithFrame:frame];
    if (self) {
        
        UIView *v = [[UIView alloc] init];
        v.frame = CGRectMake(0,0 , mDeviceWidth, 300+68);
        v.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
        [self addSubview:v];
        
        
        self.backgroundColor =[UIColor clearColor];
        tabArr =[[NSMutableArray alloc]init];
        smallTabArr =[[NSMutableArray alloc]init];
        selectDic =[[NSMutableDictionary alloc]init];
        self.data =data;
        //点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        tap.delegate = self;
        
        [v addGestureRecognizer:tap];
        
        
        NSLog(@"self.data:%@",self.data);
        RoleList =[NSArray arrayWithArray:self.data[@"RoleList"]];
        StaffList =[NSArray arrayWithArray:self.data[@"StaffList"]];
        DeptList =[NSArray arrayWithArray:self.data[@"DeptList"]];
        NSLog(@"self..........RoleList%@,\n----------------StaffList:%@,\n++++++++++++++DeptList:%@",RoleList,StaffList,DeptList);
        [self setUI];
        
    }
    return self;
}

-(void)tapClick:(UITapGestureRecognizer *)tap{
    
    
    [self removeFromSuperview];
}

#pragma mark - workingSelectPerson把选择的数组返回过来
-(void)WorkingSelectPersonSelectView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath AndSelectArr:(NSArray *)selectArr{
    
    selectArray =[[NSMutableArray alloc]initWithArray:selectArr];
    
    
}

#pragma mark -  筛选条件按钮部门和角色选择点击事件
-(void)boyClik:(UIButton *)sender{
    
    for (int i=0;i<2;i++){
        UIButton *btn =[self viewWithTag:i+101];
        if (sender.tag==btn.tag){
            btn.selected=YES;
        }else {
            btn.selected=NO;
        }
    }
    
    UITextView *textV =[self viewWithTag:20]; //部门选择
    UITextView *personV  =[self viewWithTag:21]; //人员选择
    
    if (sender.tag ==101) //120 部门
    {
        [self DefaultSet ];
        
    }else { //121 角色
        [tabArr removeAllObjects];
        tabArr =[[NSMutableArray alloc]initWithArray:RoleList];
        
        textV.text =tabArr[0][@"RoleName"];
        [smallTabArr removeAllObjects];
        
        for (int i =0;i<StaffList.count;i++){
            
            if ( [[NSString stringWithFormat:@"%@",tabArr[0][@"RoleID"]] isEqualToString:[NSString stringWithFormat:@"%@",StaffList[i][@"RoleID"]]]){
                [smallTabArr addObject:StaffList[i]];
            }
        }
        
        personV.text =smallTabArr[0][@"StaffName"];
        selectDic =[[NSMutableDictionary alloc]initWithDictionary:smallTabArr[0]];
        selectPersonTab.dataArray=[[NSMutableArray alloc]initWithArray:smallTabArr];
         [selectPersonTab.selectedIndexs removeAllObjects];
         [selectPersonTab.selectedArr removeAllObjects];
        [selectPersonTab reloadData];
        
        [personTab reloadData];
        
    }
    
}


#pragma mark - 部门角色/可选人员UI
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
    [bjView addSubview:leftlabel];
    
    UITextView *textV =[[UITextView alloc]init];
    textV.frame =CGRectMake(110, h+10, mDeviceWidth-120, 30);
    textV.backgroundColor = [UIColor clearColor];
    textV.textColor = fontHightColor;
    textV.textAlignment = NSTextAlignmentLeft;
    textV.font = [UIFont systemFontOfSize:15];
    textV.layer.cornerRadius=2;
    textV.layer.masksToBounds=YES;
    textV.layer.borderWidth=0.5;
    textV.layer.borderColor=mainColor.CGColor;
    textV.editable=YES;
    textV.tag=tag;
    
    [bjView addSubview:textV];
    //
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(mDeviceWidth-35, h+15, 20, 20);
    imageView.image = [UIImage imageNamed:@"bg_moreunfold"];
    
    [bjView addSubview:imageView];
    
    //
    UIButton *selectbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectbtn.frame = CGRectMake(110, h+10, mDeviceWidth-120, 30);
    selectbtn.tag=tag+100;
    [selectbtn  addTarget:self action:@selector(selectbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if (tag ==20){
        selectbtn.selected=YES;
    }else {
        selectbtn.selected=NO;
    }
    
    [bjView addSubview: selectbtn];
}
#pragma mark - 部门角色/可选人员按钮点击事件
-(void)selectbtn:(UIButton *)sender{
    
    for (int i=0;i<2;i++){
        UIButton *btn =[self viewWithTag:i+120];
        if (sender.tag==btn.tag){
            btn.selected=YES;
        }else {
            btn.selected=NO;
        }
    }
    
    NSLog(@"sender:%ld",sender.tag);
    if (sender.tag ==120) //120 部门/角色
    {
        tabView.hidden=NO;
        personTab.hidden=NO;
        
        CGFloat tabH =tabArr.count*30;
        if (tabH >300){
            tabH =300;
        }else {
            tabH =tabArr.count*30;
        }
        
        tabView.frame =CGRectMake(110, mDeviceHeight-tabH-300, mDeviceWidth-140, tabH);
        personTab.frame =CGRectMake(0, 0, mDeviceWidth-140, tabH);

        selectPersonTab.dataArray=[[NSMutableArray alloc]initWithArray:smallTabArr];
         [selectPersonTab.selectedIndexs removeAllObjects];
         [selectPersonTab.selectedArr removeAllObjects];
        [selectPersonTab reloadData];
        [personTab reloadData];
        
    }else { //121 人员
        
        
        if ( smallTabArr.count<=0) {
            tabView.hidden=YES;
            
        }else {
            
            tabView.hidden=NO;
        }
        
        CGFloat tabH =smallTabArr.count*30;
        if (tabH >300){
            tabH =300;
        }else {
            tabH =smallTabArr.count*30;
        }
        
        tabView.frame =CGRectMake(110, mDeviceHeight-tabH-300, mDeviceWidth-140, tabH);
        personTab.frame =CGRectMake(0, 0, mDeviceWidth-140, tabH);
        
        [personTab reloadData];
    }
}


#pragma mark - 确定按钮点击事件
-(void)saveBtn:(UIButton *)sender{
    

    
    if (self.valueArrBlock){
        if (selectArray.count<=0){
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"温馨提示"message:@"请选择主办人"delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"好的", nil];
            
            [alertview show];
        }else {
            self.valueArrBlock(selectArray);
            [self removeFromSuperview];
        }
    }
}



#pragma mark ----------UITabelViewDataSource----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    UIButton *btn =[self viewWithTag:120]; //部门角色
    UIButton *btn1 =[self viewWithTag:121];
    if (btn.selected==YES){
        return  [tabArr count];
    }else if (btn1.selected==YES){
        return [smallTabArr count];
    }else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"tabid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        //        cell = [[[NSBundle mainBundle] loadNibNamed:@"<#string#>" owner:self options:nil]lastObject];
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    //配置数据
    UIButton *DeptListBtn =[self viewWithTag:101];
    UIButton *RoleListBtn =[self viewWithTag:102];
    UIButton *btn =[self viewWithTag:120]; //部门角色
    UIButton *btn1 =[self viewWithTag:121]; //人员选择
    
    
    if (btn.selected==YES){
        NSDictionary *dic =tabArr[indexPath.row];
        
        if (DeptListBtn.selected==YES) {
            cell.textLabel.text = dic[@"DeptName"];
        }else if (RoleListBtn.selected==YES){
            cell.textLabel.text = dic[@"RoleName"];
        }
        
    }else if (btn1.selected==YES){
        
        
        NSDictionary *dic =smallTabArr[indexPath.row];
        
        cell.textLabel.text = dic[@"StaffName"];
        
        
    }else {
        return 0;
    }
    
    
    cell.textLabel.font=[UIFont systemFontOfSize:13];
    cell.textLabel.textColor=fontHightColor;
    
    return cell;
}


#pragma mark ----------UITabelViewDelegate----------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIButton *DeptListBtn =[self viewWithTag:101];
    UIButton *RoleListBtn =[self viewWithTag:102];
    UITextView *textV =[self viewWithTag:20]; //部门选择
    UITextView *personV  =[self viewWithTag:21]; //人员选择
    UIButton *btn =[self viewWithTag:120]; //部门角色
    UIButton *btn1 =[self viewWithTag:121]; //人员选择
    
    
    if (btn.selected==YES) //部门角色
    {
        NSDictionary *dic =tabArr[indexPath.row];
        if (DeptListBtn.selected==YES) {
            textV.text = dic[@"DeptName"];
            [smallTabArr removeAllObjects];
            
            for (int i =0;i<StaffList.count;i++){
                
                if ( [[NSString stringWithFormat:@"%@",dic[@"DeptID"]] isEqualToString:[NSString stringWithFormat:@"%@",StaffList[i][@"DeptID"]]]){
                    [smallTabArr addObject:StaffList[i]];
                    
                }
            }
            if (smallTabArr.count<=0){
                
                
                personV.text = @"";
                [selectDic removeAllObjects];
            }else {
                
                personV.text = smallTabArr[0][@"StaffName"];
                selectDic =[[NSMutableDictionary alloc]initWithDictionary:smallTabArr[0]];
                selectPersonTab.dataArray=[[NSMutableArray alloc]initWithArray:smallTabArr];
                 [selectPersonTab.selectedIndexs removeAllObjects];
                 [selectPersonTab.selectedArr removeAllObjects];
                [selectPersonTab reloadData];
                
            }
            [personTab reloadData];
            
        }else if (RoleListBtn.selected==YES){
            textV.text = dic[@"RoleName"];
            [smallTabArr removeAllObjects];
            
            for (int i =0;i<StaffList.count;i++){
                if ( [[NSString stringWithFormat:@"%@",dic[@"RoleID"]] isEqualToString:[NSString stringWithFormat:@"%@",StaffList[i][@"RoleID"]]]){
                    [smallTabArr addObject:StaffList[i]];
                }
            }
            if (smallTabArr.count<=0){
                personV.text = @"";
                [selectDic removeAllObjects];
            }else {
                
                personV.text = smallTabArr[0][@"StaffName"];
                selectDic =[[NSMutableDictionary alloc]initWithDictionary:smallTabArr[0]];
                selectPersonTab.dataArray=[[NSMutableArray alloc]initWithArray:smallTabArr];
                 [selectPersonTab.selectedIndexs removeAllObjects];
                 [selectPersonTab.selectedArr removeAllObjects];
                [selectPersonTab reloadData];
                
            }
            
            [personTab reloadData];
        }
        
    }else if (btn1.selected==YES){
        NSDictionary *dic =smallTabArr[indexPath.row];
        
        personV.text = dic[@"StaffName"];
        selectDic =[[NSMutableDictionary alloc]initWithDictionary:dic];
    }else {
    }
    tabView.hidden=YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
#pragma mark - 默认数据
-(void)DefaultSet{
    UITextView *textV =[self viewWithTag:20]; //部门选择
    UITextView *personV  =[self viewWithTag:21]; //人员选择
    [tabArr removeAllObjects];
    [smallTabArr removeAllObjects];
    tabArr =[[NSMutableArray alloc]initWithArray:DeptList];
    textV.text =tabArr[0][@"DeptName"];
    for (int i =0;i<StaffList.count;i++){
        if ( [[NSString stringWithFormat:@"%@",tabArr[0][@"DeptID"]] isEqualToString:[NSString stringWithFormat:@"%@",StaffList[i][@"DeptID"]]]){
            [smallTabArr addObject:StaffList[i]];
            NSLog(@"smallTabArr:%@",smallTabArr);
        }
    }
    if (smallTabArr<=0)
    {
        personV.text =@"";
        [selectDic removeAllObjects];
    }else {
        personV.text =smallTabArr[0][@"StaffName"];
        selectDic =[[NSMutableDictionary alloc]initWithDictionary:smallTabArr[0]];
        selectPersonTab.dataArray=[[NSMutableArray alloc]initWithArray:smallTabArr];
        [selectPersonTab.selectedIndexs removeAllObjects];
        [selectPersonTab.selectedArr removeAllObjects];
        [selectPersonTab reloadData];
    }
    
    CGFloat tabH =tabArr.count*30;
    if (tabH >300){
        tabH =300;
    }else {
        tabH =tabArr.count*30;
    }
    tabView.frame =CGRectMake(110, mDeviceHeight-tabH-300, mDeviceWidth-140, tabH);
    personTab.frame =CGRectMake(0, 0, mDeviceWidth-140, tabH);
    [personTab reloadData];
}

#pragma mark -  *********************布局UI**********************
-(void)setUI{
    
    bjView = [[UIView alloc] init];
    bjView.frame = CGRectMake(0, mDeviceHeight-300-68-100, mDeviceWidth, 300+100);
    bjView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bjView];
    //
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, mDeviceWidth , 50);
    label.backgroundColor = bjColor;
    label.textColor = fontHightColor;
    label.text = @"选择人员";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    [bjView addSubview:label];
    [self addBtnViewUI:50];
    
    [self addLab:@"部门角色"andtextViewTag:20 andH:100];
    
    
    
    selectPersonTab =[[WorkingSelectPersonTableView alloc]initWithFrame:CGRectMake(0, 160, mDeviceWidth, 170) style:UITableViewStylePlain];
    selectPersonTab.w_delegate=self;
    
    [bjView addSubview:selectPersonTab];
    
    [self DefaultSet]; //默认数据
    
    [self addBtn];
    //
    [self addtable];
}

#pragma mark - 确定按钮
-(void) addBtn {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 230+100+20, mDeviceWidth-40, 35);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn  addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"mainColor"] forState:UIControlStateNormal];
    btn.layer.cornerRadius=5;
    btn.layer.masksToBounds=YES;
    [bjView  addSubview: btn];
    
}
#pragma mark - 添加列表
-(void)addtable{
    
    tabView =[[UIView alloc]init];
    tabView.frame =CGRectMake(110, 250, mDeviceWidth-140, 330);
    tabView.backgroundColor=[UIColor clearColor];
    tabView.hidden=YES;
    [self addSubview:tabView];
    tabView.layer.shadowColor =[UIColor blackColor].CGColor;
    tabView.layer.shadowOffset =CGSizeMake(4, 4);
    tabView.layer.shadowRadius=4;
    tabView.layer.shadowOpacity=0.5;
    
    personTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mDeviceWidth-140, 330) style:UITableViewStylePlain];
    personTab.delegate = self;
    personTab.dataSource = self;
    personTab.showsVerticalScrollIndicator = NO;
    personTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    personTab.backgroundColor = [UIColor whiteColor];
    
    personTab.bounces=YES;
    [tabView addSubview:personTab];
    
    
}

#pragma mark - 筛选条件按钮(部门/角色)
-(void)addBtnViewUI:(CGFloat )h{
    
    UILabel *leftlabel = [[UILabel alloc] init];
    leftlabel.frame = CGRectMake(0, h, 100, 50);
    leftlabel.backgroundColor = [UIColor clearColor];
    leftlabel.textColor = fontHightColor;
    leftlabel.text =@"筛选条件:";
    leftlabel.textAlignment = NSTextAlignmentRight;
    leftlabel.font = [UIFont systemFontOfSize:15];
    leftlabel.numberOfLines = 0;
    [bjView addSubview:leftlabel];
    
    UIButton *boybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    boybtn.frame = CGRectMake(110, h+17.5, 15, 15);
    [boybtn setBackgroundImage:[UIImage imageNamed:@"icon_check_box"] forState:UIControlStateNormal];
    [boybtn setBackgroundImage:[UIImage imageNamed:@"icon_check_box_select"] forState:UIControlStateSelected];
    //    boybtn.backgroundColor=[UIColor redColor];
    [boybtn  addTarget:self action:@selector(boyClik:) forControlEvents:UIControlEventTouchUpInside];
    boybtn.tag=101;
    boybtn.selected=YES;
    [bjView addSubview: boybtn];
    
    
    UILabel *boylab = [[UILabel alloc] init];
    boylab.frame = CGRectMake(130, h, 80, 50);
    boylab.backgroundColor = [UIColor clearColor];
    boylab.textColor = fontHightColor;
    boylab.text =@"按部门选择";
    boylab.textAlignment = NSTextAlignmentLeft;
    boylab.font = [UIFont systemFontOfSize:15];
    boylab.numberOfLines = 0;
    [bjView addSubview:boylab];
    
    //
    UIButton *girlbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    girlbtn.frame = CGRectMake(220, h+17.5, 15, 15);
    
    [girlbtn  addTarget:self action:@selector(boyClik:) forControlEvents:UIControlEventTouchUpInside];
    girlbtn.tag=102;
    [girlbtn setBackgroundImage:[UIImage imageNamed:@"icon_check_box"] forState:UIControlStateNormal];
    [girlbtn setBackgroundImage:[UIImage imageNamed:@"icon_check_box_select"] forState:UIControlStateSelected];
    [bjView addSubview: girlbtn];
    
    UILabel *girllab = [[UILabel alloc] init];
    girllab.frame = CGRectMake(240, h, 80, 50);
    girllab.backgroundColor = [UIColor clearColor];
    girllab.textColor = fontHightColor;
    girllab.text =@"按角色选择";
    girllab.textAlignment = NSTextAlignmentLeft;
    girllab.font = [UIFont systemFontOfSize:15];
    girllab.numberOfLines = 0;
    [bjView addSubview:girllab];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
