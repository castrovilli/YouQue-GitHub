//
//  YQMyScene.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/26/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "YQMyScene.h"
#import "YQViewController.h"

@implementation YQMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        
        
        
        
        
        

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newAchievementsActions:) name:FRUITS5_ACHIEVEMENT object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(highScoreUpdated) name:HIGH_SCORE_UPDATED_NOTIFICATION object:nil];
        
       
       /* self.backgroundColor = [UIColor colorWithRed:(75.0f/255.0f) green:(157.0f/255.0f) blue:(153.0f/255.0f) alpha:1.0];*/
        UIImage *bg = [UIImage imageNamed:[[TemplateConfiguration sharedInstance] valueForKey:BACKGROUND_IMAGE_KEY]];
        SKSpriteNode *BGNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:bg ]];
        BGNode.size = size;
        BGNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self insertChild:BGNode atIndex:0];
        
        
        
        progressView = [[TCProgressTimerNode alloc] initWithForegroundImageNamed:[[TemplateConfiguration sharedInstance] valueForKey:PROGRESS_PIE_FILL_IMAGE_KEY]
                                                            backgroundImageNamed:[[TemplateConfiguration sharedInstance] valueForKey:PROGRESS_PIE_BACKGROUND_IMAGE_KEY]
                                                             accessoryImageNamed:nil];
        progressView.position = CGPointMake(280, 465);
        [self addChild:progressView];
        [progressView setProgress:0.0f];
        
        LevelLbl = [[SKLabelNode alloc] init];
        LevelLbl.position = CGPointMake(280, 460);
        LevelLbl.fontColor = [UIColor yellowColor];
        LevelLbl.fontSize = 15;
        [self addChild:LevelLbl];
        
        
        undoBtn = [SKButton spriteNodeWithImageNamed:[[TemplateConfiguration sharedInstance] valueForKey:UNDO_IMAGE_KEY]];
        undoBtn.position = CGPointMake(290, 520);
        undoBtn.size = CGSizeMake(40, 40);
        undoBtn.name = @"undoBtn";
        undoBtn.zPosition = 1000;
        [self addChild:undoBtn];
        
        
        SKCropNode *cropNode = [[SKCropNode alloc] init];
        cropNode.position = CGPointMake(CGRectGetMidX(self.frame), 515);
        [self addChild:cropNode];
        
        ScoreBoard = [[SKLabelNode alloc] init];
        ScoreBoard.fontColor = [UIColor blackColor];
        [cropNode addChild:ScoreBoard];
        
        SKSpriteNode *maskNode = [[SKSpriteNode alloc] initWithColor:[UIColor redColor] size:CGSizeMake(200, 50)];
        cropNode.maskNode = maskNode;
        
        
        quitBtn = [SKSpriteNode spriteNodeWithImageNamed:[[TemplateConfiguration sharedInstance] valueForKey:PAUSE_IMAGE_KEY]];
        quitBtn.size = CGSizeMake(40, 40);
        quitBtn.position = CGPointMake(30, 520);
        quitBtn.name = @"quitBtn";
        quitBtn.zPosition = 1000;
        [self addChild:quitBtn];
        
        SKCropNode *personalHighcropNode = [[SKCropNode alloc] init];
        personalHighcropNode.position = CGPointMake(CGRectGetMidX(self.frame), 490);
        [self addChild:personalHighcropNode];
        
        personalHighScoreLbl = [[SKLabelNode alloc] init];
        personalHighScoreLbl.fontSize = 15;
        personalHighScoreLbl.fontColor = [UIColor blackColor];
        [personalHighcropNode addChild:personalHighScoreLbl];
        
        SKSpriteNode *personalHighmaskNode = [[SKSpriteNode alloc] initWithColor:[UIColor redColor] size:CGSizeMake(180, 50)];
        personalHighcropNode.maskNode = personalHighmaskNode;
        
        quitTransition = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.5];
        
        
        SKAction *slideOutAction = [SKAction moveTo:CGPointMake(500, _matrix.position.y) duration:0.0];
        
        SKAction *slideInAction = [SKAction moveTo:CGPointMake(0, 0) duration:0.6];
        slideInAction.timingMode = SKActionTimingEaseOut;
        
        
        matrixSlideInSequense = [SKAction sequence:@[slideOutAction,slideInAction]];
        
        
        if(floorf([[UIDevice currentDevice] systemVersion].floatValue)>= 7)
        {
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        }
        //[self.navigationController setNavigationBarHidden:YES];
        SKSpriteNode *gameContainerView = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(600, 400)];
        gameContainerView.anchorPoint = CGPointMake(0.0, 0.0);
        gameContainerView.position = CGPointMake(5, 120);
        [self addChild:gameContainerView];
        
        
        
        
        
        if(_IsResumedGame)
        {
            _matrix = [[MatrixView alloc] initWithFrame:CGRectZero withGame:self.ResumedGame gameReumed:YES];
        }else
        {
            _matrix = [[MatrixView alloc] initWithFrame:CGRectZero] ;
        }
        _matrix.position = CGPointMake(0, 0.0);
        _matrix.delegate = self;
        _matrix.ScoreBoard = ScoreBoard;
        
        
        NextCellsView = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(210, 32)];
        NextCellsView.position = CGPointMake(5, 320);
        NextCellsView.anchorPoint = CGPointMake(0, 0);
        [gameContainerView addChild:NextCellsView];
        
        int y = 480;
        int xOffset = 80;
        int padding = 2;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            y = 0;
            xOffset = -15;
        }
        int cellSize = 32;
        
        for(int i = 0;i<MAX_NUMBER_OF_ADDED_CELLS;i++)
        {
            CellView *cell = [[CellView alloc] initWithFrame:CGRectMake(20+i*(cellSize+padding)+xOffset, 0 , cellSize, cellSize)];
            cell.tag = 4000+i;
            [NextCellsView addChild:cell];
        }
        
        
        _matrix.UndoBtn = undoBtn;
        
        
        
        [gameContainerView addChild:_matrix];
        
       /* CGRect _matrixFrame = _matrix.frame;
        UIView *matrixBorderView = [[UIView alloc] initWithFrame:_matrixFrame];
        matrixBorderView.layer.borderColor = [UIColor colorWithRed:(57.0f/255.0f) green:(57.0f/255.0f) blue:(57.0f/255.0f) alpha:1.0].CGColor;
        matrixBorderView.layer.borderWidth = 3;
        matrixBorderView.layer.cornerRadius = 10.0;
        matrixBorderView.backgroundColor = [UIColor clearColor];
        [gameContainerView insertSubview:matrixBorderView belowSubview:_matrix];*/
        
        
        
        
     /*   progressView.pieFillColor = [UIColor colorWithRed:(37.0f/255.0f) green:(37.0f/255.0f) blue:(37.0f/255.0f) alpha:1.0];
        progressView.pieBorderColor = [UIColor whiteColor];
        progressView.pieBackgroundColor = [UIColor lightGrayColor];*/
        

        playAhievementSoundAction = [SKAction playSoundFileNamed:@"magic_spell_trick_sound_002.wav" waitForCompletion:NO];
        
        [self updateHighScoreLabel];
        firstLoad = YES;
    }
    return self;
}
-(void)newAchievementsActions:(NSNotification *)notification
{
    NSArray *achievements = [notification.userInfo objectForKey:ACHIEVEMENTS_INFO_KEY];
    
    if(achievements.count>0)
    {
        [self runAction:playAhievementSoundAction];
    }
    [self showAchievements:achievements currentIndex:0];
}
-(void)showAchievements:(NSArray*)achievements currentIndex:(int)index
{
    if(index == achievements.count)
    {
        return;
    }
    
    MDAchievement *ach = [achievements objectAtIndex:index++];
    
    if(!achievementsPopUpView)
    {
        achievementsPopUpView = [[MDpopUpView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-300)/2, 50, 300, 100) withTextColor:[UIColor redColor] withFontSize:50];
    }
    
    [achievementsPopUpView showInView:self.view withText:ach.title withCompletionBlock:^(BOOL finished){
        
        [achievementsPopUpView removeFromSuperview];
        [self showAchievements:achievements currentIndex:index];
        
    }];
}
- (void) showBannerWithMessage:(NSString*)msg withTitle:(NSString*)title
{
    [TSMessage showNotificationInViewController:self.viewController title:title subtitle:msg type:TSMessageNotificationTypeError];
}
- (void) showNormalBannerWithMessage:(NSString*)msg withTitle:(NSString*)title
{
    [TSMessage showNotificationInViewController:self.viewController title:title subtitle:msg type:TSMessageNotificationTypeSuccess];
    
}

-(void)highScoreUpdated
{
    [self updateHighScoreLabel];
}
-(void)updateHighScoreLabel
{
    personalHighScoreLbl.text = [NSString stringWithFormat:@"Your Highest  %llu",[ICloudManager getLocalPlayerHighScore]];
}
-(void)authenticatePlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    __weak GKLocalPlayer *player = localPlayer;
    
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil)
        {
            
            
            [self.viewController presentViewController:viewController animated:YES completion:nil];
        }
        else if (player.isAuthenticated)
        {
            [self getPlayerHighScore];
        }
        else
        {
            
        }
    };
}
-(void)getPlayerHighScore
{
    
    
    NSString *playerID = [GKLocalPlayer localPlayer].playerID;
    GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] initWithPlayerIDs:[NSArray arrayWithObject:playerID]];
    
    if((floorf([[UIDevice currentDevice] systemVersion].floatValue))>=7.0)
    {
        leaderboardRequest.identifier = @"YouQueMainLeaderboard";
    }
    
    leaderboardRequest.timeScope = GKLeaderboardTimeScopeAllTime;
    
    if (leaderboardRequest != nil) {
        [leaderboardRequest loadScoresWithCompletionHandler:^(NSArray *scores, NSError *error){
            if (error != nil) {
                NSLog(@"error : %@",error.localizedDescription);
            }
            else{
                
                [ICloudManager saveLocalPlayerHighScore:leaderboardRequest.localPlayerScore.value];
               // NSLog(@"local player High %ll",[ICloudManager getLocalPlayerHighScore]);
                
            }
        }];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    
    if ([node.name isEqualToString:@"undoBtn"]) {
        [self UndoAction:nil];
    }else if([node.name isEqualToString:@"quitBtn"])
    {
        [self QuitAction:nil];
    }
    
}

-(void)update:(CFTimeInterval)currentTime {
    
}
-(BOOL)adRemovalPurchased
{
    return [ICloudManager IsAdsRemovalPurchased];
}
- (BOOL)hasFourInchDisplay {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}
-(void)newScore:(int)score delta:(int)deltaScore
{
    ScoreBoard.text = [NSString stringWithFormat:@"%d",score];
    if(!scorePopUpView)
    {
        scorePopUpView = [[MDpopUpView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-100)/2, 10, 300, 100) withTextColor:[UIColor greenColor] withFontSize:60];
    }
   /* if(deltaScore > 12)
    {
        [scorePopUpView showInView:self.view withText:[NSString stringWithFormat:@"+ %d",deltaScore] withCompletionBlock:nil];
    }*/
    
    
    
}
-(void)MatrixViewQuit:(MatrixView *)matrixView
{
    [self.viewController quitGameScene];
}
-(void)AddNextCellsWithGraphCells:(NSArray *)GCells
{
    
    
    
    for(int i =0 ;i<MAX_NUMBER_OF_ADDED_CELLS;i++)
    {
        CellView *cellToBeFound = [[CellView alloc] init];
        cellToBeFound.tag = i+4000;
        
        CellView *cell = (CellView*)[MDBinarySearch searchForItem:cellToBeFound inArray:NextCellsView.children withCompareBlock:^int(NSObject *obj1,NSObject *obj2){
        
            CellView *cell1 = (CellView*)obj1;
            CellView *cell2 = (CellView*)obj2;
            if(cell1.tag > cell2.tag)
            {
                return 1;
            }else if (cell1.tag < cell2.tag)
            {
                return -1;
            }else
            {
                return 0;
            }
        
        
        
        }];
        if(i<GCells.count)
        {
            [cell SetStatusWithGraphCell:[GCells objectAtIndex:i] Animatation:CellAnimationTypeNone withCompletionBlock:^(BOOL finished){}];
        }else
        {
            GraphCell *emptyCell = [[GraphCell alloc] init];
            emptyCell.color = unOccupied;
            [cell SetStatusWithGraphCell:emptyCell Animatation:CellAnimationTypeNone withCompletionBlock:^(BOOL finished){}];
        }
    }
    
}
-(void)setProgress:(CGFloat)progress withLevelNumber:(int)levelNo
{
    [progressView setProgress:progress];
    LevelLbl.text = [NSString stringWithFormat:@"Level %d",levelNo];
}
-(IBAction)QuitAction:(id)sender
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Pause" andMessage:@""];
    
    
    
    [alertView addButtonWithTitle:@"New Game"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alert) {
                              
                              [self ResetNextCells];
                              [_matrix ReloadNewGame];
                          }];
    
    [alertView addButtonWithTitle:@"Quit"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alert) {
                              
                              [self Quit];
                          }];
    
    
    [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alert) {
                          }];
    
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    [alertView show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [self Quit];
            break;
        default:
        {
            [self ResetNextCells];
            [_matrix ReloadNewGame];
        }
            break;
    }
}
-(void)ResetNextAddedCells
{
    [self ResetNextCells];
}
-(void)ResetNextCells
{
    GraphCell *emptyCell = [[GraphCell alloc] init];
    emptyCell.color = unOccupied;
    for(int i =0 ;i<MAX_NUMBER_OF_ADDED_CELLS;i++)
    {
        CellView *cell = ((CellView*)[self.view viewWithTag:4000+i]);
        [cell SetStatusWithGraphCell:emptyCell Animatation:CellAnimationTypeNone withCompletionBlock:^(BOOL finished){}];
    }
    
}
-(void)Quit
{
    [self saveGame];
    [self.viewController quitGameScene];
    //[self.navigationController popViewControllerAnimated:YES];
}
-(void)saveGame
{
    [_matrix saveGame];
}
-(void)reloadGame:(GameEntity *)game
{
    
    [_matrix ReloadGame:game];
}
-(void)willMoveFromView:(SKView *)view
{
    [super willMoveFromView:view];
    
}
-(void)didMoveToView:(SKView *)view
{
    if(_matrix)
    {
        
        
       /* [_matrix runAction:matrixSlideInSequense completion:^{
        
        
            _matrix.position = CGPointMake(0, 0);
        }];*/
        
        
        
        [_matrix ResetUndo];
    }
}
-(void)ResetProgressAndLevel
{
    [self setProgress:0.0f withLevelNumber:1];
}
-(void)ReloadNewGame
{
    [self ResetProgressAndLevel];
    [self ResetNextCells];
    [_matrix ResetUndo];
    [_matrix ReloadNewGame];
    
}
-(void)dealloc
{
  //  [[NSNotificationCenter defaultCenter] removeObserver:self name:PURCHASE_SUCCEEDED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HIGH_SCORE_UPDATED_NOTIFICATION object:nil];
}
-(void)UndoAction:(id)sender
{
    [_matrix undoLastMove];
}
@end
