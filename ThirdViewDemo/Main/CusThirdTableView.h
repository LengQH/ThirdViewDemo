//
//  CusThirdTableView.h
//  ThirdView
//
//  Created by 冷求慧 on 16/9/12.
//  Copyright © 2016年 leng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowDataModel.h"
@class CusThirdTableView;
@protocol CusThirdTableViewDelegate <NSObject>
@optional

/**
 *  代理方法传递对应的三级模型数据(点击了第三级别的Cell)
 *
 *  @param cusTV                CusThirdTableView 对象
 *  @param showDataModel        模型数据数组
 */
-(void)cusThirdTableView:(CusThirdTableView *)cusTV arrModelData:(NSArray<ShowDataModel *> *)arrModelData;

@end

@interface CusThirdTableView : UITableView

@property (nonatomic,weak) id<CusThirdTableViewDelegate> cusDelegate;

@property (nonatomic,assign)NSInteger selectSecIndexNum;

-(instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)arr;

+(instancetype)cusThiedTableView:(CGRect)frame dataArr:(NSArray *)arr;

@end
