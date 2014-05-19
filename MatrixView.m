//
//  MatrixView.m
//  DavinciCode
//
//  Created by Mohammed Eldehairy on 12/28/12.
//  Copyright (c) 2012 Mohammed Eldehairy. All rights reserved.
//

#import "MatrixView.h"

@implementation MatrixView
-(id)initWithFrame:(CGRect)frame
{
   /* self.size = [[MSize alloc] init] ;
    self.size.width = 7;
    self.size.height = 7;
    
    Graph *graph = [[Graph alloc] initWithSize:self.size];
    GameEntity *game = [[GameEntity alloc] init];
    game.graph = graph;
    game.score = 0;*/
    return [self initWithFrame:frame withGame:nil gameReumed:NO];
}
-(id)initWithFrame:(CGRect)frame withGame:(GameEntity*)Game gameReumed:(BOOL)resumed
{
    self = [super initWithColor:[UIColor clearColor] size:frame.size];
    if (self) {
        
        self.anchorPoint = CGPointMake(0.0, 0.0);
        
        
        IsGameResumed = resumed;
        
        if(Game)
        {
            gameController = [[GameController alloc] initWithGame:Game];
            
        }else
        {
            MSize *size = [[MSize alloc] init] ;
            size.width = 7;
            size.height = 7;
            Graph *graph = [[Graph alloc] initWithSize:size];
            ScoreEntity *Score = [[ScoreEntity alloc] init];
            
            GameEntity *game = [[GameEntity alloc] init];
            
            game.graph = graph;
            game.score = Score;
            game.nextCellsToAdd = [NSMutableArray array];
            
            game.achievementsState = [[achievementsState alloc] init];
            
            gameController = [[GameController alloc] initWithGame:game];
        }
        gameController.delegate = self;
        MSize *size = gameController.currentGame.graph.size;
        contentView = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake((CELL_SIZE*size.width)+20, (CELL_SIZE*size.height)+20)];
        contentView.anchorPoint = CGPointMake(0.0, 0.0);
        contentView.position = CGPointMake(0.0, 0.0);
        contentView.zPosition = 10;
        [self addChild:contentView];
        
        gameController.SelectedPath = [NSMutableArray array];
        
        
        //self.clipsToBounds = NO;
        
        
        targetImageView = [[SKSpriteNode alloc] initWithColor:[UIColor redColor] size:CGSizeMake(150, 150)];
        targetImageView.texture = [SKTexture textureWithImageNamed:[[TemplateConfiguration sharedInstance] valueForKey:TARGET_IMAGE_KEY]] ;
        
      //  draggedCellTage = -1;
        
        NSString *filename = @"Ta Da";
        CFBundleRef mainBundle = CFBundleGetMainBundle ();
        CFURLRef soundFileUrl = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef)filename, CFSTR("wav"), NULL);
        AudioServicesCreateSystemSoundID(soundFileUrl, &newLevelSoundID);
        
    }
    return self;
}
-(void)playCelebrationSound
{
    AudioServicesPlaySystemSound(newLevelSoundID);
}
-(void)saveGame
{
    [gameController saveGame];
    
}

-(void)undoLastMove
{
    [gameController undoLastMove];
}
-(void)ResetUndo
{
    [gameController ResetUndo];
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if(newSuperview)
    {
        if(IsGameResumed)
        {
            [self ReloadGame:gameController.currentGame];
        }else
        {
            [self ReloadNewGame];
        }
        
    }
}

-(void)ReloadNewGame
{
    if([_delegate respondsToSelector:@selector(ResetNextAddedCells)])
    {
        [_delegate ResetNextAddedCells];
    }
    
    [gameController.levelProvider ResetLevel];
    [gameController.UndoManager ResetManager];
    _UndoBtn.enabled = NO;
    [gameController.currentGame.score ResetScore];
    [gameController.currentGame.graph ResetGraph];
    [gameController.currentGame.achievementsState resetCounter];
    gameController.currentGame.achievementsState = [[achievementsState alloc] init];
    [self ReloadWithSize:gameController.currentGame.graph.size gameResumed:NO];
}
//**********************MATRIX RELOAD WITH CELLS ***************************************************

-(void)ReloadWithSize:(MSize*)size gameResumed:(BOOL)resumed
{
    
    NSArray *subviews = [contentView children];
    for(CellView *subview in subviews)
    {
        if(subview.tag>=1000)
            [subview removeFromParent];
    }
    
    
    self.size = CGSizeMake((CELL_SIZE*size.width)+20, (CELL_SIZE*size.height)+20);
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        self.position = CGPointMake(0, 0);
    }else
    {
        self.position = CGPointMake(500, 250);
    }
    
    
    
    [self LoadWithCellsGameResumed:resumed];
    
}

-(void)LoadWithCellsGameResumed:(BOOL)Resumed
{
    
    int TotalCellsCount = gameController.currentGame.graph.size.width*gameController.currentGame.graph.size.height;

    
    
    
    CGFloat AnimationDelay =0.0;
    int CurrentX = CELL_SIZE;
    CurrentX *= -1;
    CurrentX -=1;
    CurrentX += 3;
    
    int resetYValue = self.size.height - 3 - CELL_SIZE;
    
    int CurrentY = resetYValue;
    for(int i =0 ;i<TotalCellsCount;i++)
    {
        if(i % gameController.currentGame.graph.size.height != 0 )
        {
            //if did not reach full height
            //increase Y
            
            
            CurrentY-=CELL_SIZE+2;
            
            
        }else
        {
            //if reached full height
            //Reset Y and increase X
            
            
            CurrentY = resetYValue;
            CurrentX+=CELL_SIZE+2;
        }
        
        
        
        
        CellView *cell = [[CellView alloc] initWithFrame:CGRectMake(CurrentX, CurrentY, CELL_SIZE, CELL_SIZE)];
        cell.tag = i+1000;
        cell.delegate = self;
        cell.zPosition = 10;
        cell.name = @"FruitCell";
        
        GraphCell *graphCell = [gameController.currentGame.graph getGraphCellWithIndex:i];
        [cell SetStatusWithGraphCell:graphCell Animatation:CellAnimationTypeNone withCompletionBlock:^(BOOL finished){}];
        
        
        
        
        
        [contentView addChild:cell];
        
        
        
        AnimationDelay += 0.1;

        
        
        
    }
    
    
    
    
    
    [gameController matrixViewDidLoad:Resumed];
    
    
    
    
    
    
    
    
    
}
- (void) showBannerWithMessage:(NSString*)msg withTitle:(NSString*)title
{
 
    [self.delegate showBannerWithMessage:msg withTitle:title];
}
- (void) showNormalBannerWithMessage:(NSString*)msg withTitle:(NSString*)title
{
    
    [self.delegate showNormalBannerWithMessage:msg withTitle:title];
}




-(void)ReportScoreToGameCenter
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    if(localPlayer.authenticated)
    {
        [gameController ReportScoreToGameCenter];
    }else
    {
        if([_delegate respondsToSelector:@selector(authenticatePlayer)])
        {
            [_delegate authenticatePlayer];
        }
    }
    

}

//******************HANDLE TOUCH EVENT************************************************************
-(void)CellViewTouched:(CellView *)touchedCell
{
    NSLog(@"%@",@"cell Touched");
    if(touchedCell.IsOccupied==YES)
    {
        if(gameController.startCellIndex)
        {
            //deselect prevoiusly selected Start Cell View
            
            CellView *LastSelectedStartCellView = [self getCellViewWithIndex:gameController.startCellIndex.intValue];
            [LastSelectedStartCellView cellUnTouched];
            
        }
        NSLog(@"%@",@"cell Touched : start cell");
        
        [touchedCell cellTouched];
        gameController.startCellIndex = [NSNumber numberWithInteger:touchedCell.tag-1000];
        
        
        
    }else
    {
        
        if(!gameController.startCellIndex)
        {
            return;
        }
        
        NSLog(@"%@",@"cell Touched : end cell");
        
        gameController.endCellIndex = [NSNumber numberWithInteger:touchedCell.tag-1000] ;
        NSArray *path = [gameController FindFastesPathWithCompletionBlock:^(NSArray *path){}];
        
        [gameController.SelectedPath removeAllObjects];
        [gameController.SelectedPath addObjectsFromArray:path];
        
        if(path.count==0)
        {
            [self showBannerWithMessage:@"The path must be clear !" withTitle:@"Sorry"];
        }
        
        [gameController commitMove];
        
        
    }
}


//******************HANDLE cellView dragging ************************************************************************
//*******************************************************************************************************************
-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{

    if(userInteractionEnabled)
    {
        [self setMatrixTouchable];
    }else
    {
        [self setMatrixUnTouchableExceptCellAtIndex:-1];
    }
    
}
-(void)setMatrixUnTouchableExceptCellAtIndex:(NSUInteger)excludedCellIndex
{
    int TotalCellsCount = gameController.currentGame.graph.size.width*gameController.currentGame.graph.size.height;
    for(int i = 0 ; i < TotalCellsCount ; i++)
    {
        CellView *cell = [self getCellViewWithIndex:i];
        
        if(i != excludedCellIndex)
        {
            cell.userInteractionEnabled = NO;
        }
    }
}
-(void)setMatrixTouchable
{
    int TotalCellsCount = gameController.currentGame.graph.size.width*gameController.currentGame.graph.size.height;
    for(int i = 0 ; i < TotalCellsCount ; i++)
    {
        CellView *cell = [self getCellViewWithIndex:i];
        cell.userInteractionEnabled = YES;
    }
}
-(void)cellViewDraggingCanceled:(CellView *)cellview
{
    if(gameController.startCellIndex)
    {
        CellView *startCell = [self getCellViewWithIndex:gameController.startCellIndex.integerValue];
        [self CellViewDragged:startCell withState:UIGestureRecognizerStateEnded withNewPoint:startCell.position];
    }
}
-(void)CellViewDragged:(CellView *)cellView withState:(UIGestureRecognizerState)state withNewPoint:(CGPoint)newPoint
{
    
    if(state == UIGestureRecognizerStateBegan)
    {
        [self setMatrixUnTouchableExceptCellAtIndex:cellView.tag-1000];
        
        CellView *previousFirstCellView = [self getCellViewWithIndex:gameController.startCellIndex.intValue];
        [previousFirstCellView cellUnTouched];
        
        [cellView cellTouched];
        
    }
    
    
    
    
    
    gameController.startCellIndex = [NSNumber numberWithInteger:cellView.tag-1000] ;
    //**************************************************************************************************
    //**************************************************************************************************
    
    
    
    
    
    
    
    
    
    
    //*************** find the cell the dragged cell collides with ***************************
    //*****************************************************************************************
    CellView *collidedCell ;
    
    int TotalCellsCount = gameController.currentGame.graph.size.width*gameController.currentGame.graph.size.height;
    
    for(int i = 0;i < TotalCellsCount;i++)
    {
        CellView *cell = [self getCellViewWithIndex:i];
        
        CGRect cellFrame = cell.frame;
        
        if(CGRectContainsPoint(cellFrame, newPoint))
        {
            collidedCell = cell;
            
        }
    }
    
    
    //**************************************************************************************************
    //**************************************************************************************************
    
    
    
    
    
    
    
    
    
    //**************************** Undraw previous path ************************************************
    //**************************************************************************************************
    
    
    if(gameController.SelectedPath)
    {
        [self UnDrawPathWithPath:gameController.SelectedPath];
    }
    
    //**************************************************************************************************
    
    
    
    
    
    
    
    
    BOOL thereIsCollidedCell = collidedCell != nil;
   // BOOL collidedCellIsFree = !collidedCell.IsOccupied;
    
    __block MatrixView *selfView = self;
    
    
    
    
    
    //**************************** draw path for collided cell ******************************************
    //**************************************************************************************************
    
    gameController.endCellIndex = [NSNumber numberWithInteger:collidedCell.tag-1000];
    [gameController.SelectedPath removeAllObjects];
    
    NSArray *path = [gameController FindFastesPathWithCompletionBlock:^(NSArray *path){}];
    
    
    //*************** add target image view if there is path to end cell **************************
    //**************************************************************************************************
    
    CGFloat targetViewAlpha = 0.0;
    
    if(path.count > 0 )
    {
        targetViewAlpha = 1.0;
    }else
    {
        targetViewAlpha = 0.5;
    }
    
    if(collidedCell == cellView)
    {
        targetViewAlpha = 0.5;
    }
    
    if(thereIsCollidedCell)
    {
        [selfView addCollisionIndicatorViewOnCellAtIndex:collidedCell.tag-1000 withAlpha:targetViewAlpha];
        
    }else
    {
        [selfView removeCollisionIndicatorView];
    }
    //**************************************************************************************************
    //**************************************************************************************************
    
    
    
    
    
    
    
    
    //*************************** draw path to collided cell ********************************************
    //**************************************************************************************************
    
    [gameController.SelectedPath addObjectsFromArray:path];
    GraphCell *startGCell = [gameController.currentGame.graph getGraphCellWithIndex:gameController.startCellIndex.intValue];
    [self DrawPathWithPath:gameController.SelectedPath withStartCellStatus:startGCell.color];
    
    //**************************************************************************************************
    //**************************************************************************************************
    
    
    
    
    
    
    
    
    
    
    
    if(state != UIGestureRecognizerStateEnded)
    {
        return;
    }
    
    
    //*************************** drag ended ************************************************************
    //**************************************************************************************************
    
    
    
    
    
    
    
    //*************************** Undraw path ************************************************************
    
    [self UnDrawPathWithPath:gameController.SelectedPath];
    
    //**************************************************************************************************
    
    
    
    
    
    
    
    
    
    //*************************** set dragged cell un selected *****************************************
    
    [cellView cellUnTouched];
    
    //**************************************************************************************************
    
    
    
    
    
    
    
    
    //*************************** remove path indicator from dragged cell*******************************
    
    [cellView unDrawPathIndictor];
    
    //**************************************************************************************************
    
    
    
    
    
    
    
    
    //*************************** remove target view ***************************************************
    
    [self removeCollisionIndicatorView];
    
    //**************************************************************************************************
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //*************************** commit move ****************************************************
    

    [gameController commitMove];
    
    
    //**************************************************************************************************
    
    
    
    
    
    
    
    
    
    //*************************** clean up ****************************************************
    
    
    
    gameController.startCellIndex = nil;
    gameController.endCellIndex = nil;
    [gameController.SelectedPath removeAllObjects];
    
    //**************************************************************************************************
    
}
//************************* drag collosion indicator adding and removing ********************************************
//*******************************************************************************************************************
-(void)addCollisionIndicatorViewOnCellAtIndex:(NSUInteger)index withAlpha:(CGFloat)alpha
{
    CellView *targetCell = [self getCellViewWithIndex:index];
    
    targetImageView.position = CGPointMake(targetCell.position.x+targetCell.size.width/2, targetCell.position.y+targetCell.size.height/2);
    
    targetImageView.alpha = alpha;
    
    
    
    if(!targetImageView.parent)
    {
        [self addChild:targetImageView];
    }
    
    targetImageView.zPosition = 1000;
}
-(void)removeCollisionIndicatorView
{
    [targetImageView removeFromParent];
}
//************************* Drawing Path for dragging **************************************************************
//*******************************************************************************************************************
-(void)UnDrawPathWithPath:(NSArray*)path
{
    for(int i =1;i<path.count;i++)
    {
        NSNumber *CellIndex = [path objectAtIndex:i];
        CellView *cell = [self getCellViewWithIndex:CellIndex.intValue];
        
        [cell unDrawPathIndictor];
    }
    
}
-(void)DrawPathWithPath:(NSArray*)path withStartCellStatus:(GraphCellStatus)status
{
    for(int i =1;i<path.count;i++)
    {
        NSNumber *CellIndex = [path objectAtIndex:i];
        CellView *cell = [self getCellViewWithIndex:CellIndex.intValue];
        
        [cell drawPathIndictorWithStatus:status];
    }
    
}
//************************* Game Controller delegate implementation ********************************************
//*******************************************************************************************************************

-(void)removeCells:(NSArray *)Rows withCompletionBlock:(void (^)(void))block
{
    if(Rows.count == 0)
    {
        block();
        return;
        
    }
    
    for(int i = 0 ;i < Rows.count;i++)
    {
        RemovedRowEntity *rowEntity = [Rows objectAtIndex:i];
        for(int j = 0 ; j < rowEntity.row.count;j++)
        {
            GraphCell *GCell = [rowEntity.row objectAtIndex:j];
            GraphCellStatus status = GCell.color;
            GCell.color = unOccupied;
            NSUInteger index = [gameController.currentGame.graph getIndexOfGraphCell:GCell];
            
            CellView *cell = [self getCellViewWithIndex:index];
            [cell removeCell:rowEntity.orientation animted:YES withStatus:status withCompletionBlock:^(BOOL finished){
                
                GCell.color = unOccupied;
                if(j == rowEntity.row.count-1 && i == Rows.count-1)
                {
                    
                    block();
                }
                
                
                
                
            }];
            
            /*[self setCellAtIndex:index withStatus:GCell withanimation:CellAnimationTypeRemoval withCompletionBlock:^(BOOL finished){
                
                if(j == rowEntity.row.count-1 && i == Rows.count-1)
                {
                    
                    block();
                }
                
                
                
                
            }];*/
        }
        
    }
}
-(void)onLocalPlayerScoreReceived:(int)highScore
{
    NSLog(@"local Player High Score : %d",highScore);
}

-(void)newLevelReached:(int)level
{
    [self showNormalBannerWithMessage:[NSString stringWithFormat: @"Level %d reached",level] withTitle:@""];
    [self playCelebrationSound];
}


-(void)addNextCellsToSuperView:(NSArray*)nextAddedCells
{
    if([_delegate respondsToSelector:@selector(AddNextCellsWithGraphCells:)])
    {
        [_delegate AddNextCellsWithGraphCells:nextAddedCells];
    }
}


-(void)setUndoBtnEnabled:(BOOL)enabled
{
    _UndoBtn.enabled = enabled;
}

-(void)GameOver
{
    [PersistentStore persistGame:nil];
    [self ReportScoreToGameCenter];
    
    
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Game Over" andMessage:[NSString stringWithFormat:@"Your Score is %d !",gameController.currentGame.score.score ]];
    
    

    
    
    [alertView addButtonWithTitle:@"New Game"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alert) {
                              
                              [self ReloadNewGame];
                              
                          }];
    
    [alertView addButtonWithTitle:@"Quit"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alert) {
                              
                              if([_delegate respondsToSelector:@selector(MatrixViewQuit:)])
                              {
                                  [_delegate MatrixViewQuit:self];
                              }
                          }];
    
    alertView.transitionStyle = SIAlertViewTransitionStyleFade;
    
    [alertView show];
    
    
}

-(void)dropCells:(NSArray*)GCells withCompletionBlock:(void (^) (BOOL finished))completionBlock
{
    for(int i = 0 ;i < GCells.count; i ++)
    {
        
        GraphCell *GCell = [GCells objectAtIndex:i];
        
        CellView *LocalCell = [self getCellViewWithIndex:GCell.index];
        
        [LocalCell SetStatusWithGraphCell:GCell Animatation:CellAnimationTypeAdded withDelay:i withCompletionBlock:^(BOOL finished){
            
            if(i == GCells.count - 1)
            {
                completionBlock(YES);
            }
            
        }];
    }
}

/*-(void)RemoveCells:(NSArray*)cells
{
    for(GraphCell *GCell in cells)
    {
        GCell.color = unOccupied;
        int index = [gameController.currentGame.graph getIndexOfGraphCell:GCell];
        CellView *cellView = [self getCellViewWithIndex:index];
        [self bringSubviewToFront:cellView];
        [cellView SetStatusWithGraphCell:GCell Animatation:CellAnimationTypeRemoval];
    }
    
}*/

-(void)SetScoreInScoreBoard:(int)score delta:(int)delta
{
    
    if([_delegate respondsToSelector:@selector(newScore:delta:)])
    {
        [_delegate newScore:score delta:delta ];
    }
}

-(void)setLevelProgress:(CGFloat)progress withLevelNumber:(int)level
{
    [_delegate setProgress:progress withLevelNumber:level];
}

/*-(void)showPopUpScoreWithDelta:(int)delta
{
    if([_delegate respondsToSelector:@selector(newScore:delta:)])
    {
        [_delegate newScore:delta ];
    }
}*/

-(void)ReloadGame:(GameEntity*)game
{
    gameController.currentGame = game;
    
    
    [self ReloadWithSize:gameController.currentGame.graph.size gameResumed:YES];
}


-(void)setCellAtIndex:(NSUInteger)index withStatus:(GraphCell*)GCell withanimation:(CellAnimationType)animationType withCompletionBlock:(CellAnimationCompletionBlock)completionBlock
{
    CellView *cell = [self getCellViewWithIndex:index];
    [cell SetStatusWithGraphCell:GCell Animatation:animationType withCompletionBlock:completionBlock];
}


-(void)setCellAtIndex:(NSUInteger)index Touched:(BOOL)touched
{
    CellView *cell = [self getCellViewWithIndex:index];
    
    if(touched)
    {
        [cell cellTouched];
    }else
    {
        [cell cellUnTouched];
    }
}


//*******************************************************************************************************************
//*******************************************************************************************************************








-(CellView*)getCellViewWithIndex:(NSUInteger)index
{

    /*CellView *cell = [[CellView alloc] init];
    cell.tag = index+1000;
    CellView *foundCell = [MDBinarySearch searchForItem:cell inArray:contentView.children withCompareBlock:^int(NSObject *cell1,NSObject *cell2){
    
        CellView *cellview1 = (CellView*)cell1;
        CellView *cellview2 = (CellView*)cell2;
        
        if(cellview1.tag > cellview2.tag)
        {
            return 1;
        }else if (cellview1.tag < cellview2.tag)
        {
            return -1;
        }else
        {
            return 0;
        }
    
    }];*/
    return [[contentView children] objectAtIndex:index];
}






-(void)dealloc
{
    AudioServicesDisposeSystemSoundID(newLevelSoundID);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
/*- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect bounds = [self bounds];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat radius = 5.0f;
    
    
    // Create the "visible" path, which will be the shape that gets the inner shadow
    // In this case it's just a rounded rect, but could be as complex as your want
    CGMutablePathRef visiblePath = CGPathCreateMutable();
    CGRect innerRect = CGRectInset(bounds, radius, radius);
    CGPathMoveToPoint(visiblePath, NULL, innerRect.origin.x, bounds.origin.y);
    CGPathAddLineToPoint(visiblePath, NULL, innerRect.origin.x + innerRect.size.width, bounds.origin.y);
    CGPathAddArcToPoint(visiblePath, NULL, bounds.origin.x + bounds.size.width, bounds.origin.y, bounds.origin.x + bounds.size.width, innerRect.origin.y, radius);
    CGPathAddLineToPoint(visiblePath, NULL, bounds.origin.x + bounds.size.width, innerRect.origin.y + innerRect.size.height);
    CGPathAddArcToPoint(visiblePath, NULL,  bounds.origin.x + bounds.size.width, bounds.origin.y + bounds.size.height, innerRect.origin.x + innerRect.size.width, bounds.origin.y + bounds.size.height, radius);
    CGPathAddLineToPoint(visiblePath, NULL, innerRect.origin.x, bounds.origin.y + bounds.size.height);
    CGPathAddArcToPoint(visiblePath, NULL,  bounds.origin.x, bounds.origin.y + bounds.size.height, bounds.origin.x, innerRect.origin.y + innerRect.size.height, radius);
    CGPathAddLineToPoint(visiblePath, NULL, bounds.origin.x, innerRect.origin.y);
    CGPathAddArcToPoint(visiblePath, NULL,  bounds.origin.x, bounds.origin.y, innerRect.origin.x, bounds.origin.y, radius);
    CGPathCloseSubpath(visiblePath);
    
    // Fill this path
    UIColor *aColor = [UIColor colorWithRed:(0.00f) green:(144.0f/255.0f) blue:(250.0f/255.0f) alpha:1.0];
    [aColor setFill];
    CGContextAddPath(context, visiblePath);
    CGContextFillPath(context);
    
    
    // Now create a larger rectangle, which we're going to subtract the visible path from
    // and apply a shadow
    CGMutablePathRef path = CGPathCreateMutable();
    //(when drawing the shadow for a path whichs bounding box is not known pass "CGPathGetPathBoundingBox(visiblePath)" instead of "bounds" in the following line:)
    //-42 cuould just be any offset > 0
    CGPathAddRect(path, NULL, CGRectInset(bounds, -42, -42));
    
    // Add the visible path (so that it gets subtracted for the shadow)
    CGPathAddPath(path, NULL, visiblePath);
    CGPathCloseSubpath(path);
    
    // Add the visible paths as the clipping path to the context
    CGContextAddPath(context, visiblePath);
    CGContextClip(context);
    
    
    // Now setup the shadow properties on the context
    aColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.9f];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.5f, 1.5f), 10.0f, [aColor CGColor]);
    //cgcontextsets
    
    // Now fill the rectangle, so the shadow gets drawn
    [aColor setFill];
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOFillPath(context);
    
    // Release the paths
    CGPathRelease(path);
    CGPathRelease(visiblePath);
    
}*/

@end
