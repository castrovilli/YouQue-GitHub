//
//  GameEntity.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 10/9/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Graph.h"
#import "ScoreEntity.h"
#import "achievementsState.h"
@interface GameEntity : NSObject<NSCoding,NSCopying>
{
    
}

@property(nonatomic,retain)Graph *graph;
@property(nonatomic,retain)ScoreEntity *score;
@property(nonatomic,retain)NSMutableArray *nextCellsToAdd;
@property(nonatomic,retain)achievementsState *achievementsState;
@end
