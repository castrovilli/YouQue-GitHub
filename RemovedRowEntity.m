//
//  RemovedRowEntity.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/29/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "RemovedRowEntity.h"
#import "GraphCell.h"
@implementation RemovedRowEntity
-(BOOL)isEqual:(id)object
{
    return [_row isEqualToArray:((RemovedRowEntity*)object).row];
}
-(NSUInteger)hash
{
    return [_row hash];
}
@end
