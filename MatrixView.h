//
//  MatrixView.h
//  DavinciCode
//
//  Created by Mohammed Eldehairy on 12/28/12.
//  Copyright (c) 2012 Mohammed Eldehairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSize.h"

#import <QuartzCore/QuartzCore.h>
#import "FastestPathFinder.h"
#import "Graph.h"
#import "RandomUnOccupiedCellsGenerator.h"
#import <GameKit/GameKit.h>
#import "GameEntity.h"
#import "PersistentStore.h"
#import "ConnectedCellRowsDetector.h"
#import "SIAlertView.h"
#import "UndoManager.h"
#import "LevelProvider.h"
#import <AVFoundation/AVFoundation.h>
#import "GameController.h"
#import "MDBinarySearch.h"
#import "SKButton.h"
#define NUMBER_OF_ADDED_CELLS 3
@protocol MatrixViewDelegate;
typedef void (^AnimationCompletionBlock)();
typedef void(^UndoBlock)(NSArray* lastAddedCells,NSArray *lastRemovedCells,NSNumber *lastStartCellIndex,NSNumber *lastEndCellIndex);
@interface MatrixView : SKSpriteNode<CellViewDelegate,UIAlertViewDelegate,GameControllerDelegate>
{
    SKSpriteNode *contentView;
    
    UIImageView *BackView;
    
    UndoBlock undoBlock;
    
    BOOL IsGameResumed;
    
    
    
    SKSpriteNode *targetImageView;
    
    
    GameController *gameController;
    
    SystemSoundID newLevelSoundID;
}
//UI Controls
@property(nonatomic,retain)SKButton *UndoBtn;
@property(nonatomic,retain)SKLabelNode *ScoreBoard;


//Status Variables
@property(nonatomic,weak)id<MatrixViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame;
-(id)initWithFrame:(CGRect)frame withGame:(GameEntity*)Game gameReumed:(BOOL)resumed;

-(void)ReloadNewGame;
-(void)ReloadGame:(GameEntity*)game;

-(void)saveGame;


-(void)undoLastMove;
-(void)ResetUndo;
@end
@protocol MatrixViewDelegate <NSObject>

-(void)MatrixViewQuit:(MatrixView*)matrixView;
-(void)AddNextCellsWithGraphCells:(NSArray*)GCells;
-(void)setProgress:(CGFloat)progress withLevelNumber:(int)levelNo;
-(void)ResetNextAddedCells;
-(void)authenticatePlayer;
-(void)newScore:(int)score delta:(int)deltaScore;

- (void) showBannerWithMessage:(NSString*)msg withTitle:(NSString*)title;
- (void) showNormalBannerWithMessage:(NSString*)msg withTitle:(NSString*)title;
@end