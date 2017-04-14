//
//  ShowDataModel.m
//  ThirdView
//
//  Created by 冷求慧 on 16/9/11.
//  Copyright © 2016年 leng. All rights reserved.
//

#import "ShowDataModel.h"

@implementation ShowDataModel
-(instancetype)initWithDataModel:(int)superID myID:(int)myID grade:(int)grade isOpen:(BOOL)isOpen showName:(NSString *)showName rightShowName:(NSString *)rightShowName{
    if (self=[super init]) {
        self.superID=superID;
        self.myID=myID;
        self.grade=grade;
        self.isOpen=isOpen;
        self.showName=showName;
        self.rightShowName=rightShowName;
    }
    return self;
}
+(instancetype)showDataModel:(int)superID myID:(int)myID grade:(int)grade isOpen:(BOOL)isOpen showName:(NSString *)showName rightShowName:(NSString *)rightShowName{
    return [[self alloc]initWithDataModel:superID myID:myID grade:grade isOpen:isOpen showName:showName rightShowName:rightShowName];
}
@end
