//
//  DataModel.m
//  TableViewDemo
//
//  Created by CHLMA2015 on 2017/7/12.
//  Copyright © 2017年 MACHUNLEI. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

- (instancetype)init {

    self = [super init];
    if (self) {
        _title = @"title";
        _fileCount = @"123";
        _scanCount = @"123456";
        _comeFrom = @"DataModel";
    }
    return self;
}

@end
