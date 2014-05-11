//
//  ConnectedCellRowsDetector.m
//  Connect5
//
//  Created by Mohammed Eldehairy on 10/10/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import "ConnectedCellRowsDetector.h"

@implementation ConnectedCellRowsDetector
+(NSArray*)getConnectedCellsWithGraph:(Graph*)graph withVertices:(NSArray*)vertices withCompletionBlock:(DetectedResultArrayBlock)block
{
        
    NSMutableSet *result = [NSMutableSet set];
    
    for(GraphCell *GCell in vertices)
    {
        NSMutableArray *rowsForCurrentVertix = [NSMutableArray array];
        
        NSArray *verticalRow = [self detectConnectedRowsVerticallyWithGraph:graph withVertixe:GCell];
        if(verticalRow.count > 0)
        {
            RemovedRowEntity *verticalRowEntity = [[RemovedRowEntity alloc] init];
            verticalRowEntity.row = [NSMutableArray arrayWithArray:verticalRow];
            verticalRowEntity.orientation = removedRowOrientationVertical;
            [rowsForCurrentVertix addObject:verticalRowEntity];
            
        }
        
        
        NSArray *Horizontal = [self detectConnectedRowsHorizontallyWithGraph:graph withVertixe:GCell];
        if(Horizontal.count > 0)
        {
            RemovedRowEntity *HorizontalEntity = [[RemovedRowEntity alloc] init];
            HorizontalEntity.row = [NSMutableArray arrayWithArray:Horizontal];
            HorizontalEntity.orientation = removedRowOrientationHorizontal;
            [rowsForCurrentVertix addObject:HorizontalEntity];
            
        }
        
        
        NSArray *DiagonallyToTheRight = [self detectConnectedRowsDiagonallyToTheRightWithGraph:graph withVertixe:GCell];
        if(DiagonallyToTheRight.count > 0)
        {
            RemovedRowEntity *DiagonallyToTheRightEntity = [[RemovedRowEntity alloc] init];
            DiagonallyToTheRightEntity.row = [NSMutableArray arrayWithArray:DiagonallyToTheRight];
            DiagonallyToTheRightEntity.orientation = removedRowOrientationDiagonalToTheRight;
            [rowsForCurrentVertix addObject:DiagonallyToTheRightEntity];
            
        }
        
        NSArray *DiagonallyToTheLeft = [self detectConnectedRowsDiagonallyToTheLeftWithGraph:graph withVertixe:GCell];
        if(DiagonallyToTheLeft.count > 0)
        {
            RemovedRowEntity *DiagonallyToTheLeftEntity = [[RemovedRowEntity alloc] init];
            DiagonallyToTheLeftEntity.row = [NSMutableArray arrayWithArray: DiagonallyToTheLeft ];
            DiagonallyToTheLeftEntity.orientation = removedRowOrientationDiagonalToTheLeft;
            [rowsForCurrentVertix addObject:DiagonallyToTheLeftEntity];
            
        }
        
        for(int i = 1 ; i < rowsForCurrentVertix.count; i++)
        {
            RemovedRowEntity *row = [rowsForCurrentVertix objectAtIndex:i];
            [row.row removeObject:GCell];
        }
        
        [result addObjectsFromArray:rowsForCurrentVertix];
    }
        
    return result.allObjects;
}
+(NSArray*)detectConnectedRowsVerticallyWithGraph:(Graph*)graph withVertixe:(GraphCell*)VertixGCell
{
    NSMutableArray *result = [NSMutableArray array];
    
    
    CGPoint VertixCellPoint = [VertixGCell getPointWithSize:graph.size];
    int StartX = VertixCellPoint.x;
    int StartY = 0;
    for(int i = 0;i<graph.size.height;i++)
    {
        
        BOOL breakLoop = [self DetectConnectedCellsInaRowWithConnectedCellsArray:result withCurrentGCell:[graph getGraphCellWithX:StartX withY:StartY+i]];
        if(breakLoop)
        {
            break;
        }
    }
    if(result.count>=CONNECTED_CELLS_COUNT)
    {
        return result;
    }
    return [NSArray array];
}
+(NSArray*)detectConnectedRowsHorizontallyWithGraph:(Graph*)graph withVertixe:(GraphCell*)VertixGCell
{
    NSMutableArray *result = [NSMutableArray array];
    CGPoint VertixCellPoint = [VertixGCell getPointWithSize:graph.size];
    int StartX = 0;
    int StartY = VertixCellPoint.y;
    
    for(int i = 0;i<graph.size.width;i++)
    {
        
        BOOL breakLoop = [self DetectConnectedCellsInaRowWithConnectedCellsArray:result withCurrentGCell:[graph getGraphCellWithX:StartX+i withY:StartY]];
        if(breakLoop)
        {
            break;
        }
    }
    
    if(result.count>=CONNECTED_CELLS_COUNT)
    {
        return result;
    }
    return [NSArray array];
}
+(NSArray*)detectConnectedRowsDiagonallyToTheRightWithGraph:(Graph*)graph withVertixe:(GraphCell*)VertixGCell
{
    NSMutableArray *result = [NSMutableArray array];
    CGPoint VertixCellPoint = [VertixGCell getPointWithSize:graph.size];
    int StartX = VertixCellPoint.x;
    int StartY = VertixCellPoint.y;
    //int limit = 1;
    
    int EndX = VertixCellPoint.x;
    int EndY = VertixCellPoint.y;
    
    BOOL diagonalBelowMainDiagonal = (VertixCellPoint.x+VertixCellPoint.y) >= (graph.size.height-1);
    
    int graphHeightZeroIndexed = graph.size.height-1;
    int graphWidthZeroIndexed = graph.size.width-1;
    
    if(diagonalBelowMainDiagonal)
    {
        StartY = graphHeightZeroIndexed;
        
        StartX = VertixCellPoint.x - (graphHeightZeroIndexed - VertixCellPoint.y);
        
        EndX = graphWidthZeroIndexed;
        EndY = VertixCellPoint.y - (graphWidthZeroIndexed-VertixCellPoint.x);
    }else
    {
        StartX = 0;
        StartY = VertixCellPoint.y + VertixCellPoint.x;
        
        EndY = StartX;
        EndX = StartY;
    }
    
    
    
    /*for(int z=0;z<(graph.size.width>graph.size.height?graph.size.width:graph.size.height);z++)
    {
        
        if(EndY==0 || EndX==graph.size.width-1)
        {
            break;
        }
        EndX++;
        EndY--;
    }
    
    for(int z=0;z<(graph.size.width>graph.size.height?graph.size.width:graph.size.height);z++)
    {
        
        if(StartY==graph.size.height-1 || StartX==0)
        {
            break;
        }
        StartX--;
        StartY++;
    }*/
    
    @try{
        
        for(int i = 0 ;StartX+i<=EndX||StartY-i>=EndY;i++)
        {
            BOOL breakLoop = [self DetectConnectedCellsInaRowWithConnectedCellsArray:result withCurrentGCell:[graph getGraphCellWithX:StartX+i withY:StartY-i]];
            if(breakLoop)
            {
                break;
            }
        }
    }@catch (NSException *e) {
        
        
        CGPoint point = VertixCellPoint;
        int startx = StartX;
        int starty = StartY;
        
        int endx = EndX;
        int endy = EndY;
        
        NSLog(@"vertixe point : (%.0f ,%.0f)\n %@ \n startx : %d \n starty : %d \n endx : %d \n endy : %d ",point.x,point.y,diagonalBelowMainDiagonal?@"below":@"above",startx,starty,endx,endy);
    }@finally {
        
        
    }
    
    
    if(result.count>=CONNECTED_CELLS_COUNT)
    {
        return result;
    }
    return [NSArray array];
}
+(NSArray*)detectConnectedRowsDiagonallyToTheLeftWithGraph:(Graph*)graph withVertixe:(GraphCell*)VertixGCell
{
    NSMutableArray *result = [NSMutableArray array];
    CGPoint VertixCellPoint = [VertixGCell getPointWithSize:graph.size];
    int StartX = 0;
    int StartY = 0;
    int iteratorLimit = 0;
    if(VertixCellPoint.x>VertixCellPoint.y)
    {
        StartY = 0;
        StartX = VertixCellPoint.x-VertixCellPoint.y;
        iteratorLimit = graph.size.width-1-StartX;
    }else if (VertixCellPoint.y>VertixCellPoint.x)
    {
        StartX = 0;
        StartY = VertixCellPoint.y-VertixCellPoint.x;
        iteratorLimit = graph.size.height-1-StartY;
    }else
    {
        StartX = 0;
        StartY = 0;
        iteratorLimit = graph.size.height>graph.size.width?graph.size.width:graph.size.height;
        iteratorLimit--;
    }
    for(int i = 0 ;i<=iteratorLimit;i++)
    {
        BOOL breakLoop = [self DetectConnectedCellsInaRowWithConnectedCellsArray:result withCurrentGCell:[graph getGraphCellWithX:StartX+i withY:StartY+i]];
        if(breakLoop)
        {
            break;
        }
    }
    if(result.count>=CONNECTED_CELLS_COUNT)
    {
        return result;
    }
    return [NSArray array];
}
+(BOOL)DetectConnectedCellsInaRowWithConnectedCellsArray:(NSMutableArray*)ConnectedCells withCurrentGCell:(GraphCell*)CurrentCell
{
    if(CurrentCell.color==unOccupied && [ConnectedCells count]<CONNECTED_CELLS_COUNT)
    {
        [ConnectedCells removeAllObjects];
        return NO;
    }
    
    GraphCell *LastCellInConnectedArray = nil;
    if(ConnectedCells.count>0 )
    {
        LastCellInConnectedArray  = [ConnectedCells lastObject];
        
        if(LastCellInConnectedArray.color!=CurrentCell.color && [ConnectedCells count]<CONNECTED_CELLS_COUNT)
        {
            [ConnectedCells removeAllObjects];
            [ConnectedCells addObject:CurrentCell];
            
        }else if (LastCellInConnectedArray.color!=CurrentCell.color && [ConnectedCells count]>=CONNECTED_CELLS_COUNT)
        {
            return YES;
            
            
        }else if (LastCellInConnectedArray.color==CurrentCell.color)
        {
            [ConnectedCells addObject:CurrentCell];
        }
        
        
        
        
    }else
    {
        [ConnectedCells addObject:CurrentCell];
    }
    
    return NO;
}

@end
