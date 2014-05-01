//
//  UndoManager.m
//  Connect5
//
//  Created by Mohammed Eldehairy on 10/24/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import "UndoManager.h"

@implementation UndoManager
-(id)init
{
    self = [super init];
    if(self)
    {
        UndoGamesList = [NSMutableArray array];
    }
    return self;
}
-(void)EnqueueGameInUndoList:(GameEntity *)game
{
    
    [UndoGamesList addObject:[game copy]];
}
-(GameEntity*)UndoLastMove
{
    GameEntity *unDoneGame = nil;
    if(UndoGamesList.count>0)
    {
        
        
        
        unDoneGame = [UndoGamesList lastObject];
        [UndoGamesList removeAllObjects];
    }

    return [unDoneGame copy];
}
-(void)ResetManager
{
    [UndoGamesList removeAllObjects];
    
}
-(BOOL)CanUndo
{
    return UndoGamesList.count>0;
}
@end
