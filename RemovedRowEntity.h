//
//  RemovedRowEntity.h
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/29/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    removedRowOrientationVertical,
    removedRowOrientationHorizontal,
    removedRowOrientationDiagonalToTheRight,
    removedRowOrientationDiagonalToTheLeft
}removedRowOrientation;
@interface RemovedRowEntity : NSObject
@property(nonatomic,retain)NSArray *row;
@property(nonatomic)removedRowOrientation orientation;
@end
