//
//  GraphCell.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 6/21/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSize.h"
typedef enum {
    red,
    blue,
    green,
    yellow,
    orange,
    unOccupied
} GraphCellStatus;
@interface GraphCell : NSObject<NSCoding,NSCopying>

@property(nonatomic,assign)GraphCellStatus color;
@property(nonatomic,assign)NSUInteger x;
@property(nonatomic,assign)NSUInteger y;
@property(nonatomic,assign)NSUInteger index;
@property(nonatomic,assign)BOOL temporarilyUnoccupied;
-(id)initWithColor:(GraphCellStatus)color;
-(UIColor*)GetUIColor;
-(CGPoint)getPointWithSize:(MSize*)size;
-(void)copySelftoGCell:(GraphCell*)CopyGCell;
@end
