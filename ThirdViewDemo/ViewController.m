//
//  ViewController.m
//  ThirdViewDemo
//
//  Created by 冷求慧 on 16/11/10.
//  Copyright © 2016年 Leng. All rights reserved.
//

#import "ViewController.h"
#import "CusThirdTableView.h"
#import "ShowDataModel.h"

#define screenWidthW  [[UIScreen mainScreen] bounds].size.width
#define screenHeightH [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()<CusThirdTableViewDelegate>{
    NSString *linkThird;
}
/**
 *  三级视图
 */
@property (nonatomic,strong)CusThirdTableView *thirdView;
/**
 *  添加商品分类数据
 */
@property (nonatomic,strong)NSMutableArray *addChoiceModel;


@end

@implementation ViewController

-(CusThirdTableView *)thirdView{
    if (_thirdView==nil) {
        _thirdView=[CusThirdTableView cusThiedTableView:CGRectMake(0,100,screenWidthW,screenHeightH-100) dataArr:self.addChoiceModel];
        _thirdView.hidden=YES;
        _thirdView.cusDelegate=self;
        [self.view addSubview:_thirdView];
    }
    return _thirdView;
}
-(NSMutableArray *)addChoiceModel{
    if (_addChoiceModel==nil) {
        _addChoiceModel=[NSMutableArray array];
    }
    return _addChoiceModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addModelData];
}
#pragma mark 加载模型数据
-(void)addModelData{
    
    /**
     *  superID:父节点的下标 (等于上一级节点的下标,如:深圳的parentId=广东的nodeId=5)
     *  myID:本节点的下标(数组的下标)
     *  grade:缩放等级(第一级别:0 第一级别:1 第一级别:2)
     *  isOpen:是否处于展开状态(YES 或者 NO)
     *  showName:显示的数据名字
     */
    
    
    
    linkThird=@"";
    ShowDataModel *num0=[ShowDataModel showDataModel:-2 myID:0 grade:0 isOpen:YES showName:@"中国" rightShowName:nil];// 第一级别数据
    
    ShowDataModel *num1=[ShowDataModel showDataModel:0 myID:1 grade:1 isOpen:NO showName:@"全部" rightShowName:nil]; // 第二级别
    ShowDataModel *num2=[ShowDataModel showDataModel:0 myID:2 grade:1 isOpen:NO showName:@"江苏" rightShowName:nil];
    ShowDataModel *num7=[ShowDataModel showDataModel:0 myID:7 grade:1 isOpen:NO showName:@"广东" rightShowName:nil];
    ShowDataModel *num11=[ShowDataModel showDataModel:0 myID:11 grade:1 isOpen:NO showName:@"浙江" rightShowName:nil];
    
    
    ShowDataModel *num3=[ShowDataModel showDataModel:2 myID:3 grade:2 isOpen:NO showName:@"全部" rightShowName:nil]; //
    ShowDataModel *num4=[ShowDataModel showDataModel:2 myID:4 grade:2 isOpen:NO showName:@"南通" rightShowName:nil];
    ShowDataModel *num5=[ShowDataModel showDataModel:2 myID:5 grade:2 isOpen:NO showName:@"南京" rightShowName:nil];
    ShowDataModel *num6=[ShowDataModel showDataModel:2 myID:6 grade:2 isOpen:NO showName:@"苏州" rightShowName:nil];
    
    
    ShowDataModel *num8=[ShowDataModel showDataModel:7 myID:8 grade:2 isOpen:NO showName:@"全部" rightShowName:nil];
    ShowDataModel *num9=[ShowDataModel showDataModel:7 myID:9 grade:2 isOpen:NO showName:@"深圳" rightShowName:nil];
    ShowDataModel *num10=[ShowDataModel showDataModel:7 myID:10 grade:2 isOpen:NO showName:@"广州" rightShowName:nil];
    
    
    ShowDataModel *num12=[ShowDataModel showDataModel:11 myID:12 grade:2 isOpen:NO showName:@"全部" rightShowName:nil];
    ShowDataModel *num13=[ShowDataModel showDataModel:11 myID:13 grade:2 isOpen:NO showName:@"杭州" rightShowName:nil];
    
    

    ShowDataModel *num14=[ShowDataModel showDataModel:-1 myID:14 grade:0 isOpen:YES showName:@"美国" rightShowName:nil]; // 第一级别
    
    ShowDataModel *num15=[ShowDataModel showDataModel:14 myID:15 grade:1 isOpen:NO showName:@"全部" rightShowName:nil]; // 第二级别
    ShowDataModel *num16=[ShowDataModel showDataModel:14 myID:16 grade:1 isOpen:NO showName:@"纽约州" rightShowName:nil];
    ShowDataModel *num19=[ShowDataModel showDataModel:14 myID:19 grade:1 isOpen:NO showName:@"德州" rightShowName:nil];
    ShowDataModel *num22=[ShowDataModel showDataModel:14 myID:22 grade:1 isOpen:NO showName:@"加州" rightShowName:nil];
    
    ShowDataModel *num17=[ShowDataModel showDataModel:16 myID:17 grade:2 isOpen:NO showName:@"全部" rightShowName:nil]; // 第三级别
    ShowDataModel *num18=[ShowDataModel showDataModel:16 myID:18 grade:2 isOpen:NO showName:@"纽约州(3)" rightShowName:nil]; // 第三级别
    
    
    ShowDataModel *num20=[ShowDataModel showDataModel:19 myID:20 grade:2 isOpen:NO showName:@"全部" rightShowName:nil]; // 第三级别
    ShowDataModel *num21=[ShowDataModel showDataModel:19 myID:21 grade:2 isOpen:NO showName:@"休斯顿" rightShowName:nil];
    
    
    ShowDataModel *num23=[ShowDataModel showDataModel:22 myID:23 grade:2 isOpen:NO showName:@"全部" rightShowName:nil]; // 第三级别
    ShowDataModel *num24=[ShowDataModel showDataModel:22 myID:24 grade:2 isOpen:NO showName:@"洛杉矶" rightShowName:nil];
    ShowDataModel *num25=[ShowDataModel showDataModel:22 myID:25 grade:2 isOpen:NO showName:@"旧金山" rightShowName:nil];
    
    NSArray *arrModel=@[num0,num1,num2,num3,num4,num5,num6,num7,num8,num9,num10,num11,num12,num13,num14,num15,num16,num17,num18,num19,num20,num21,num22,num23,num24,num25];
    [self.addChoiceModel addObjectsFromArray:arrModel];
}
#pragma mark 点击了按钮的操作
- (IBAction)showAction:(UIButton *)sender {
    self.thirdView.hidden=!self.thirdView.hidden;
}
#pragma mark 代理方法
-(void)cusThirdTableView:(CusThirdTableView *)cusTV arrModelData:(NSArray<ShowDataModel *> *)arrModelData{
    for (ShowDataModel *model in arrModelData) {
        NSLog(@"传过来的值:%@",model.showName);
    }
    
}

@end
