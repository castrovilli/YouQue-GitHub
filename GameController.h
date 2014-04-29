//
//  GameController.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/15/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelProvider.h"
#import "GameEntity.h"
#import "UndoManager.h"
#import "PersistentStore.h"
#import "RandomUnOccupiedCellsGenerator.h"
#import "ConnectedCellRowsDetector.h"
#import "FastestPathFinder.h"
#import <GameKit/GameKit.h>
#import "CellView.h"
#import "FaceBookManager.h"
@protocol GameControllerDelegate ;
typedef void (^CompletionBlock)(NSArray* detectedCells);
@interface GameController : NSObject<LevelProviderDelegate>
{
    
    
    
}

@property(nonatomic,retain) UndoManager *UndoManager;

@property(nonatomic,retain) LevelProvider *levelProvider;

@property(nonatomic,retain) NSNumber *startCellIndex;

@property(nonatomic,retain) NSNumber *endCellIndex;

@property(nonatomic,retain)GameEntity *currentGame;

@property(nonatomic,weak)id<GameControllerDelegate> delegate;

@property(nonatomic,retain)NSMutableArray *SelectedPath;




-(void)AddNewCells;

-(void)saveGame;

-(NSArray*)FindFastesPathWithCompletionBlock:(FastestPathFinderBlock)block;

-(void)matrixViewDidLoad:(BOOL)gameIsResumed;

-(void)UpdateScore;

-(void)undoLastMove;

-(void)ResetUndo;

-(void)ReportScoreToGameCenter;

-(void)commitMove;

@end




@protocol GameControllerDelegate <NSObject>


-(void)newLevelReached:(int)level;

-(void)addNextCellsToSuperView:(NSArray*)nextAddedCells;

-(void)setUndoBtnEnabled:(BOOL)enabled;

-(void)GameOver;

-(void)dropCells:(NSArray*)GCells withCompletionBlock:(void (^) (BOOL finished))completionBlock;

-(void)setUserInteractionEnabled:(BOOL)enabled;

-(void)SetScoreInScoreBoard:(int)newScore delta:(int)delta;

-(void)setLevelProgress:(CGFloat)progress withLevelNumber:(int)level ;

-(void)ReloadGame:(GameEntity*)newGame;

-(void)removeCells:(NSArray*)GCells withCompletionBlock:(void (^) (void))block;

-(void)setCellAtIndex:(NSUInteger)index Touched:(BOOL)touched;

-(void)setCellAtIndex:(NSUInteger)index withStatus:(GraphCell*)GCell withanimation:(CellAnimationType)animationType withCompletionBlock:(CellAnimationCompletionBlock)completionBlock;

-(void)onLocalPlayerScoreReceived:(int)highScore;
@end