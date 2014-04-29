//
//  MDBinarySearch.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/26/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "MDBinarySearch.h"

@implementation MDBinarySearch
+(id)searchForItem:(NSObject*)item inArray:(NSArray*)items withCompareBlock:(int (^) (NSObject *obj1,NSObject *obj2))compareBlock
{
    
    
    
    return [self searchForItem:item startIndex:0 endIndex:items.count-1 inArray:items withCompareBlock:compareBlock];
}
+(id)searchForItem:(NSObject*)item startIndex:(NSInteger)start endIndex:(NSInteger)end inArray:(NSArray*)items withCompareBlock:(int (^) (NSObject *obj1,NSObject *obj2))compareBlock
{
    if(end < start )
    {
        return nil;
    }
    
    
    NSInteger middleIndex = (end+start)/2;
    
    if(start == end)
    {
        middleIndex = start;
    }
    
    NSObject *middleObject = [items objectAtIndex:middleIndex];
    
    int compareResult = compareBlock(middleObject,item);
    
    if(compareResult > 0)
    {
        return [self searchForItem:item startIndex:start endIndex:middleIndex-1 inArray:items withCompareBlock:compareBlock];
        
    }else if (compareResult < 0)
    {
        return [self searchForItem:item startIndex:middleIndex+1 endIndex:end inArray:items withCompareBlock:compareBlock];
    }else
    {
        return middleObject;
    }
    
    return nil;
}
@end
