//
//  YQMyScene.h
//  YouQue
//

//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SSPieProgressView.h"
#import "MDpopUpView.h"
#import "MatrixView.h"
#import "MDBinarySearch.h"
#import "SKButton.h"
@class YQViewController;
#define MAX_NUMBER_OF_ADDED_CELLS 6
@interface YQMyScene : SKScene<UIAlertViewDelegate,MatrixViewDelegate>
{
    //STABannerView* bannerView_;
    //GADInterstitial *interstitial_;
    IBOutlet UIButton *okBtn;
    IBOutlet UIButton *CancelBtn;
    
    IBOutlet UILabel *LevelLbl;
    IBOutlet SSPieProgressView *progressView;
    
    SKButton *undoBtn;
    SKLabelNode *ScoreBoard;
    SKSpriteNode *quitBtn;
    
    SKSpriteNode *NextCellsView;
    
    SKLabelNode *personalHighScoreLbl;
    
    BOOL firstLoad;
    
    MDpopUpView *scorePopUpView;
    
    SKAction *matrixSlideInSequense;
    
    SKTransition *quitTransition;
}
@property(nonatomic,weak)YQViewController *viewController;
@property(nonatomic,retain)GameEntity *ResumedGame;
@property(nonatomic,assign)BOOL IsResumedGame;
@property(nonatomic,retain)MatrixView *matrix;
-(void)ReloadNewGame;
-(IBAction)QuitAction:(id)sender;
-(void)saveGame;
-(void)reloadGame:(GameEntity*)game;
-(IBAction)UndoAction:(id)sender;
@end
