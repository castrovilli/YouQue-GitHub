//
//  GameController.m
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/15/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "GameController.h"

@implementation GameController
-(id)init
{
    self = [super init];
    if(self)
    {
        _levelProvider = [[LevelProvider alloc] initWithNumberOfLevels:4];
        _levelProvider.delegate = self;
        
        _UndoManager = [[UndoManager alloc] init];
        newGame = NO;
    }
    return self;
}
-(id)initWithGame:(GameEntity *)game
{
    self = [self init];
    _currentGame = game;
    _currentGame.achievementsState.delegate = self;
    return self;
}
-(void)matrixViewDidLoad:(BOOL)gameIsResumed
{
    newGame = !gameIsResumed;
    if(!gameIsResumed)
    {
        [self GenerateRandomCellsAndAddToSuperView:NO];
        [self performSelector:@selector(AddNewCells) withObject:nil afterDelay:0.5];
    }else
    {
        [_delegate addNextCellsToSuperView:_currentGame.nextCellsToAdd];
    }
    [self UpdateScore];
}
-(void)levelProvider:(LevelProvider*)lvlProvider LevelChanged:(LevelEntity*)newLevel
{
    if(newLevel == [lvlProvider GetCurrentLevel])
    {
        return;
    }
    
    if (newLevel.LevelIndex > [lvlProvider GetCurrentLevel].LevelIndex && [lvlProvider GetCurrentLevel])
    {
        if([_delegate respondsToSelector:@selector(newLevelReached:)])
        {
            [_delegate newLevelReached:newLevel.LevelIndex];
        }
    }
    
    for(int i=0 ;i<newLevel.numberOfAddedCells;i++)
    {
        if(i>=_currentGame.nextCellsToAdd.count)
        {
            GraphCell *Gcell = [[GraphCell alloc] init];
            Gcell.color = [self getRandomColor];
            [_currentGame.nextCellsToAdd addObject:Gcell];
        }
    }
    
    if([_delegate respondsToSelector:@selector(addNextCellsToSuperView:)])
    {
        [_delegate addNextCellsToSuperView:_currentGame.nextCellsToAdd];
    }
    
}
-(GraphCellStatus)getRandomColor
{
    int randomIndex = arc4random_uniform(5);
    
    if(randomIndex==0)
    {
        return blue;
        
    }else if (randomIndex==1)
    {
        return green;
        
    }else if (randomIndex==2)
    {
        return red;
        
    }else if (randomIndex==3)
    {
        return yellow;
        
    }else //if (randomIndex==4)
    {
        return orange;
    }
}
-(void)saveGame
{
    [self PersistGameToPermenantStore];
  /*  if(!newGame)
    {
        [self SaveGameToUndoManager];
    }
    newGame = NO;*/
    
    
    
}
-(void)SaveGameToUndoManager
{
    
    [_UndoManager EnqueueGameInUndoList:_currentGame];
    if([_UndoManager CanUndo])
    {
        if([_delegate respondsToSelector:@selector(setUndoBtnEnabled:)])
        {
            [_delegate setUndoBtnEnabled:YES];
        }
    }
}
-(void)undoLastMove
{
    GameEntity *UndoneGame = [_UndoManager UndoLastMove];
    if(UndoneGame)
    {
        [_delegate ReloadGame:UndoneGame];
        [self PersistGameToPermenantStore];
        [_delegate setUndoBtnEnabled:NO];
    }
}
-(void)ResetUndo
{
    if(_UndoManager)
    {
        [_UndoManager ResetManager];
        [_delegate setUndoBtnEnabled:NO];
    }
}
-(void)ReportScoreToGameCenter
{
    
    [_currentGame.achievementsState reportYouQueAchievements];
    
    GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:@"YouQueMainLeaderboard"];
    scoreReporter.value = _currentGame.score.score;
    scoreReporter.context = 0;
    

    
    [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError *error) {
        
        if(_currentGame.score.score > [ICloudManager getLocalPlayerHighScore])
        {
            [ICloudManager saveLocalPlayerHighScore:_currentGame.score.score];
            
            ShareEntity *entity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved new personal high score %d !",[[FaceBookManager sharedInstance] FullName],_currentGame.score.score] link:@"" name:@"YouQue" description:@"New personal high score"];
            
            [[FaceBookManager sharedInstance] share:entity];
        }
        
    }];

    
    
}

-(void)PersistGameToPermenantStore
{
    
    [PersistentStore persistGame:_currentGame];
}
-(void)gameOver
{
    [_currentGame.achievementsState postAchievementsToFacebook];
    if([_delegate respondsToSelector:@selector(GameOver)])
    {
        [_delegate GameOver];
    }
}
-(void)AddNewCells
{
    NSArray *unoccupiedCells = [_currentGame.graph getUnOccupiedCells];
    
    
    
    if(unoccupiedCells.count<[_levelProvider GetCurrentLevel].numberOfAddedCells)
    {
        [self gameOver];
        
        return;
    }
    NSArray *result = [RandomUnOccupiedCellsGenerator GenerateRandomUnOccupiedCellsIndexes:[_levelProvider GetCurrentLevel].numberOfAddedCells WithUnOccupiedCells:unoccupiedCells withCompletionBlock:^(NSArray* result){}];
    
    NSMutableArray *AddedCells = [NSMutableArray array];
    for(int i=0 ;i<[_levelProvider GetCurrentLevel].numberOfAddedCells;i++)
    {
        GraphCell *AddedGCell = [_currentGame.nextCellsToAdd objectAtIndex:i];
        GraphCell *LocalGCell = [_currentGame.graph getGraphCellWithIndex:((NSNumber*)[result objectAtIndex:i]).intValue];
        LocalGCell.color = AddedGCell.color;
        
        [AddedCells addObject:LocalGCell];
        
    }
    
    [_delegate dropCells:AddedCells withCompletionBlock:^(BOOL finished){
        
        
        [self DetectAndRemoveConnectedCellsAndUpdateScoreWithCompetionBlock:^(NSArray* detectedCells){
            
            
            [_delegate setUserInteractionEnabled:YES];
            
            NSArray *unoccupiedCells = [_currentGame.graph getUnOccupiedCells];
            
            if(unoccupiedCells.count==0)
            {
                [self gameOver];
                
            }else
            {
                [self GenerateRandomCellsAndAddToSuperView:YES];
                [self saveGame];
            }
            
            
            
        } withVerticesArray:AddedCells];
        
        
    }];

    
}
-(void)GenerateRandomCellsAndAddToSuperView:(BOOL)addToSuperView
{
    
    NSMutableArray *addedCells = [NSMutableArray array];
    for(int i=0 ;i<[_levelProvider GetCurrentLevel].numberOfAddedCells;i++)
    {
        GraphCell *CopyGCell = [[GraphCell alloc] init];
        [addedCells addObject:CopyGCell];
        
        CopyGCell.color = [self getRandomColor];
        
    }
    
    _currentGame.nextCellsToAdd = addedCells;
    if(addToSuperView)
        [_delegate addNextCellsToSuperView:addedCells];
}
-(void)DetectAndRemoveConnectedCellsAndUpdateScoreWithCompetionBlock:(CompletionBlock) block withVerticesArray:(NSArray*)vertices
{
    
    // get detected rows from the ConnectedCellsDetector helper class
    NSArray *result = [ConnectedCellRowsDetector getConnectedCellsWithGraph:_currentGame.graph withVertices:vertices withCompletionBlock:^(NSArray *result){}];
    
    
    // iterate on detected cells and remove them
    NSUInteger numberOfCellsDetected = 0;
    for(RemovedRowEntity *row in result)
    {
        numberOfCellsDetected += row.row.count;
    }
    
    
    [_delegate removeCells:result withCompletionBlock:^{
        
        int oldLevel = [_levelProvider GetCurrentLevel].LevelIndex;
        
        //Update Score
        int deltaScore = [_currentGame.score ReportScoreWithNumberOfDetectedCells:numberOfCellsDetected];
        
        //Update level
        [_levelProvider ReportScore:_currentGame.score.score];
        
        // track achievements
        [_currentGame.achievementsState reportAchievementWithNumberOfClearedOutCells:numberOfCellsDetected Newlevel:[_levelProvider GetCurrentLevel].LevelIndex OldLevel:oldLevel];
        
        
        
    
        
        
        [self UpdateScoreWithDeltaScore:deltaScore];
        
        //call completion block
        block(result);
        
    }];
    
    
    
    
    
    

    
    
}
-(void)UpdateScore
{
    [_levelProvider ReportScore:_currentGame.score.score];
    [self UpdateScoreWithDeltaScore:0];
}
-(void)UpdateScoreWithDeltaScore:(int)delta
{
    
    [_delegate SetScoreInScoreBoard:_currentGame.score.score delta:delta];
    if([_delegate respondsToSelector:@selector(setLevelProgress:withLevelNumber:)])
    {
        CGFloat Mod = _currentGame.score.score % (int)(LEVEL_RANGE);
        CGFloat progress = (CGFloat)(Mod/LEVEL_RANGE);
        if([_levelProvider isFinalLevel])
        {
            progress = 1.0f;
        }
        [_delegate setLevelProgress:progress withLevelNumber:[_levelProvider GetCurrentLevel].LevelIndex];
    }
}
-(NSArray*)FindFastesPathWithCompletionBlock:(FastestPathFinderBlock)block
{
    [_currentGame.graph getGraphCellWithIndex:self.startCellIndex.intValue].temporarilyUnoccupied = YES;
    NSArray *path = [FastestPathFinder findFastestPathWithOccupiedCells:[_currentGame.graph getOcuupiedCells] withSize:_currentGame.graph.size withStart:self.startCellIndex WithEnd:self.endCellIndex WithCompletionBlock:^(NSArray *path){}];
    [_currentGame.graph getGraphCellWithIndex:self.startCellIndex.intValue].temporarilyUnoccupied = NO;
    return path;
}
-(void)commitMove
{
    if(self.SelectedPath.count==0 || !self.SelectedPath || [self.startCellIndex isEqualToNumber:self.endCellIndex])
    {
        [_delegate setUserInteractionEnabled:YES];
        
        [self cleanMoveStatusData];
        
        return;
    }
    if(!newGame)
    {
        [self SaveGameToUndoManager];
    }
    newGame = NO;
    
    
    [_delegate setUserInteractionEnabled:NO];
    
    
    
    [self MoveOccupiedCellFromIndex:self.startCellIndex.intValue toIndex:self.endCellIndex.intValue];
    
    CompletionBlock block = ^(NSArray *detectedCells){
    
        if(detectedCells.count==0)
        {
            
            [self AddNewCells];
            
        }else
        {
            
            [_delegate setUserInteractionEnabled:YES];
            
            [self saveGame];
        }
        
        [self cleanMoveStatusData];
    
    
    
    };
    
    
    
    
    
    
    [self DetectAndRemoveConnectedCellsAndUpdateScoreWithCompetionBlock:block withVerticesArray:[NSArray arrayWithObject:[self.currentGame.graph getGraphCellWithIndex:self.endCellIndex.intValue]]];
    
    
    
    
    
    
}

-(void)MoveOccupiedCellFromIndex:(int)Fromindex toIndex:(int)toIndex
{
    
    
    
    GraphCell *FromGCell = [self.currentGame.graph getGraphCellWithIndex:Fromindex];
    
    GraphCell *toGCell = [self.currentGame.graph getGraphCellWithIndex:toIndex];
    
    if(FromGCell.color!=unOccupied && toGCell.color==unOccupied)
    {
        [self.currentGame.graph ExchangeCellAtIndex:Fromindex WithCellAtIndex:toIndex];
    }
    
    
    [_delegate setCellAtIndex:Fromindex withStatus:toGCell withanimation:CellAnimationTypeNone withCompletionBlock:^(BOOL finished){}];
    
    [_delegate setCellAtIndex:toIndex withStatus:FromGCell withanimation:CellAnimationTypeNone withCompletionBlock:^(BOOL finished){}];
    

    
    
    
    
    
}

-(void)cleanMoveStatusData
{
   // [_delegate setCellAtIndex:self.endCellIndex.intValue Touched:NO];
    self.endCellIndex = nil;
    
    [_delegate setCellAtIndex:self.startCellIndex.intValue Touched:NO];
    self.startCellIndex = nil;
}
-(void)addAchievementsPoints:(int)newPoints
{
    [_currentGame.score reportAchievementsPoints:newPoints];
}
@end
