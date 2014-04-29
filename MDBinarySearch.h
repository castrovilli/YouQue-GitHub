//
//  MDBinarySearch.h
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/26/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDBinarySearch : NSObject
+(id)searchForItem:(NSObject*)item inArray:(NSArray*)items withCompareBlock:(int (^) (NSObject *obj1,NSObject *obj2))compareBlock;
@end
