//
//  CusThirdTableView.m
//  ThirdView
//
//  Created by 冷求慧 on 16/9/12.
//  Copyright © 2016年 leng. All rights reserved.
//

#import "CusThirdTableView.h"
#import "ShowDataModel.h"

@interface CusThirdTableView ()<UITableViewDataSource,UITableViewDelegate>{
    ShowDataModel *selectSuperModel;
}
/**
 *  所有的数据模型数组
 */
@property (nonatomic,strong)NSMutableArray *allArrData;
/**
 *  显示的模型数据数组
 */
@property (nonatomic,strong)NSMutableArray *showArrData;
/**
 *  用来添加选中的模型数据数组
 */
@property (nonatomic,strong)NSMutableArray *arrAddSelectModel;

@end
@implementation CusThirdTableView

static NSString *cellID=@"cellID";

-(NSMutableArray *)allArrData{
    if (_allArrData==nil) {
        _allArrData=[NSMutableArray array];
    }
    return _allArrData;
}
-(NSMutableArray *)showArrData{
    if (_showArrData==nil) {
        _showArrData=[NSMutableArray array];
    }
    return _showArrData;
}
-(NSMutableArray *)arrAddSelectModel{
    if (_arrAddSelectModel==nil) {
        _arrAddSelectModel=[NSMutableArray array];
    }
    return _arrAddSelectModel;
}
-(instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)arr{
    if (self=[super initWithFrame:frame style:UITableViewStylePlain]) {
        
        [self dealData:arr]; // 处理数据
        [self someUISet];   // 一些设置
    }
    return self;
}

+(instancetype)cusThiedTableView:(CGRect)frame dataArr:(NSArray *)arr{
    return [[self alloc]initWithFrame:frame dataArr:arr];
}

#pragma mark 处理数据
-(void)dealData:(NSArray *)arr{
    
    [self.allArrData addObjectsFromArray:arr];
    
    for (ShowDataModel *model in self.allArrData) {
        if (model.isOpen) {
            [self.showArrData addObject:model]; // 第一次初始化 添加展开的数据模型
        }
    }
}
#pragma mark 一些UI设置
-(void)someUISet{
    self.delegate=self;
    self.dataSource=self;
    self.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    self.showsHorizontalScrollIndicator=self.showsVerticalScrollIndicator=NO;
}
#pragma mark -TableView的数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *strCellID=@"cellID";
    UITableViewCell *cellWithSystem=[tableView dequeueReusableCellWithIdentifier:strCellID];
    if (cellWithSystem==nil) {
        cellWithSystem=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strCellID];
    }
    cellWithSystem.selectionStyle=UITableViewCellSelectionStyleNone;
    
    ShowDataModel *modelWithIndex=self.showArrData[indexPath.row];
    cellWithSystem.textLabel.text=modelWithIndex.showName;
    cellWithSystem.detailTextLabel.text=modelWithIndex.rightShowName;
    cellWithSystem.detailTextLabel.font=[UIFont systemFontOfSize:12.0];
    
    cellWithSystem.indentationWidth=30;   // 缩放宽度
    cellWithSystem.indentationLevel=modelWithIndex.grade;  // 缩放等级
    
    [self setCellIsSelectAndNor:cellWithSystem modelData:modelWithIndex tableView:tableView];  // 设置cell是打钩还是箭头
    
    return cellWithSystem;

}
#pragma mark -TableView的代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
#pragma mark 点击了Cell的处理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowDataModel *modelData=self.showArrData[indexPath.row]; // 选中的模型
    [self dealWithClickData:modelData index:indexPath.row tableView:tableView];// 删除和添加对应的数据,返回最终的下标
}
/**
 *  设置Cell是打钩还是箭头
 *
 *  @param indexNum  下标
 *  @param modelData 模型数据
 *  @param tableView TableView对象
 */
-(void)setCellIsSelectAndNor:(UITableViewCell *)changeCell modelData:(ShowDataModel *)modelData tableView:(UITableView *)tableView{
    
    //    NSLog(@"数据:%@ 右边数据:%@",modelData.showName,modelData.rightShowName);
    
    if(modelData.rightShowName){
        changeCell.accessoryType=UITableViewCellAccessoryNone; // 没有箭头
        changeCell.accessoryView=nil;
        changeCell.accessoryType=UITableViewCellAccessoryNone;
        UIImageView *choiceImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,15,12)];
        choiceImage.image=[UIImage imageNamed:@"sureChoice"];
        changeCell.accessoryView=choiceImage;
    }
    else{
        if (modelData.grade==2) {
            changeCell.accessoryView=nil;
            changeCell.accessoryType=UITableViewCellAccessoryNone; // 没有箭头
        }
        else{
            changeCell.accessoryView=nil;
            changeCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator; // 有箭头
        }
    }
}

#pragma mark  处理点击后的操作,返回结束的下标
-(NSInteger)dealWithClickData:(ShowDataModel *)modelData index:(NSInteger)index tableView:(UITableView *)tableView{
    
    BOOL isSelectAndHideView=modelData.grade==2||([modelData.showName isEqualToString:@"全部"]); //选中第三级或者选中全选,
    
    if (isSelectAndHideView) {
//        modelData.rightShowName=@"打钩";     //   测试用这个
        modelData.rightShowName=@"";        //   正式用这个
        [self.arrAddSelectModel addObject:modelData];
        self.hidden=YES;
        [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone]; //刷新对于的选中的Cell
        if ([self.cusDelegate respondsToSelector:@selector(cusThirdTableView:arrModelData:)]) { //同时代理传值
            [self.cusDelegate cusThirdTableView:self arrModelData:self.arrAddSelectModel];
        }
    }
    NSInteger nextIndex=index+1;   // 下一个下标
    NSInteger endIndex=nextIndex; // 结束的下标
    
    ShowDataModel *selectModel=modelData;                  //选中的模型数据

    BOOL isOpenSection=NO;
    for (NSInteger i=0;i<self.allArrData.count;i++) {
        ShowDataModel *nextModel=self.allArrData[i];
        if(selectModel.myID==nextModel.superID){ // 选择的cell的ID=所有数据中模型的父节点
            nextModel.isOpen=!nextModel.isOpen;
            if (nextModel.isOpen) {
                [self.showArrData insertObject:nextModel atIndex:endIndex]; // 添加到数组中
                 endIndex++;
                isOpenSection=YES;
            }
            else{
                endIndex=[self deleteDataInShaowDataArr:selectModel]; // 删除对应的数据(只需要删除一次)
                isOpenSection=NO;
                break;
            }
        }
    }
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (NSUInteger i=nextIndex; i<endIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0]; //获得需要修正的indexPath
        [indexPathArray addObject:indexPath];
    }
    
    if (isOpenSection) {
        [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone]; //插入或者删除相关节点
    }else{
        [self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    }
//    NSLog(@"开始位置：%zi 和 结束位置:%zi",nextIndex,endIndex);
    return endIndex;
}

/**
 *  删除该父节点下的所有子节点（包括孙子节点）
 *
 *  @param selectModel 选中的模型
 *
 *  @return 该父节点下一个相邻的统一级别的节点的位置
 */

-(NSUInteger)deleteDataInShaowDataArr:(ShowDataModel *)selectModel{
    
    NSInteger startIndex=[self.showArrData indexOfObject:selectModel]+1;
    NSInteger endIndex=startIndex;
    for (NSInteger i=startIndex; i<self.showArrData.count; i++) {
        ShowDataModel *model=self.showArrData[i];
        model.isOpen=NO;
        if (model.grade>selectModel.grade) { // 通过判断 缩放级别来 要删除的数组下标(删除的缩放级别一定大于选中的缩放级别)
            endIndex++;
        }
        else break;
    }
    NSRange deleteWithRang={startIndex,endIndex-(startIndex)};
    [self.showArrData removeObjectsInRange:deleteWithRang]; // 通过区间删除数据中的元素
    
    return endIndex;
}


@end
