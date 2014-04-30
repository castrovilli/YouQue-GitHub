//
//  CellView.m
//  DavinciCode
//
//  Created by Mohammed Eldehairy on 12/28/12.
//  Copyright (c) 2012 Mohammed Eldehairy. All rights reserved.
//

#import "CellView.h"

@implementation CellView

- (id)initWithFrame:(CGRect)frame
{
    //frame = CGRectMake(frame.origin.x, frame.origin.y, CELL_SIZE-0.5, CELL_SIZE-0.5);
    self = [super initWithTexture:[CellViewTextures sharedInstance].emptyImg];
    if (self) {
        
        self.size = frame.size;
        self.name = @"fruitCell";
        
        self.anchorPoint = CGPointMake(0.0, 0.0);

        self.position = CGPointMake(frame.origin.x, frame.origin.y);
        
        self.IsOccupied = NO;
        self.SetTouchable = YES;
        
        
        
        contentView = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(self.size.width-2, self.size.height-2)];
        contentView.position = CGPointMake(self.size.width/2, self.size.height/2);
        contentView.anchorPoint = CGPointMake(0.5, 0.5);
        contentView.color = [UIColor clearColor];
        
        [self addChild:contentView];
        
        
        
        
        
        
        
        
        
        
       /* UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HandleTap:)];
        TapGesture.delegate = self;*/
       // [self addGestureRecognizer:TapGesture];
        
       // TapGesture = nil;
        
       
        
       /* UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cellDragged:)];
        [panGesture setMinimumNumberOfTouches:1];
        [panGesture setMaximumNumberOfTouches:1];*/
       // [contentView addGestureRecognizer:panGesture];
        
        fisrtX = contentView.position.x;
        firtsY = contentView.position.y;
        
        self.userInteractionEnabled = YES;
        
        
        
        
        
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /*if([_delegate respondsToSelector:@selector(CellViewTouched:)])
    {
        [_delegate CellViewTouched:self];
    }*/
    if(!_SetTouchable)
    {
        return;
    }
    
    if(!self.IsOccupied)
    {
        return;
    }
    
    fisrtX = contentView.position.x;
    firtsY = contentView.position.y;
    originalRect = contentView.frame;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInNode:self.parent];
        
    if([_delegate respondsToSelector:@selector(CellViewDragged:withState:withNewPoint:)])
    {
        [_delegate CellViewDragged:self withState:UIGestureRecognizerStateBegan withNewPoint:currentPoint];
    }
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!_SetTouchable)
    {
        return;
    }
    if(!self.IsOccupied)
    {
        return;
    }
    
   // contentView.zPosition = 999;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInNode:self.parent];
    
    
    
    if([_delegate respondsToSelector:@selector(CellViewDragged:withState:withNewPoint:)])
    {
        [_delegate CellViewDragged:self withState:UIGestureRecognizerStateChanged withNewPoint:currentPoint];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!_SetTouchable)
    {
        return;
    }
    
    if(!self.IsOccupied)
    {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInNode:self.parent];
    
    
    if([_delegate respondsToSelector:@selector(CellViewDragged:withState:withNewPoint:)])
    {
        [_delegate CellViewDragged:self withState:UIGestureRecognizerStateEnded withNewPoint:currentPoint];
    }
    
   // contentView.zPosition = 100;
}
/*-(void)cellDragged:(UIPanGestureRecognizer*)sender
{
    if(!self.IsOccupied)
    {
        return;
    }
    self.zPosition = 1000;
    CGPoint translatedPoint = [sender translationInView:self.superview];
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        
        

        
        fisrtX = contentView.position.x;
        firtsY = contentView.position.y;
        originalRect = contentView.frame;
    }
    translatedPoint = CGPointMake(fisrtX+translatedPoint.x, firtsY+translatedPoint.y);
    

    
    
    if([_delegate respondsToSelector:@selector(CellViewDragged:withState:withNewPoint:)])
    {
        [_delegate CellViewDragged:self withState:sender.state withNewPoint:[self convertPoint:translatedPoint toView:self.superview]];
    }
}*/
-(void)resetDrageAnimated:(BOOL)animated
{

    
    if(!animated)
    {
        contentView.position = CGPointMake(fisrtX, firtsY);
        return;
    }
    
    SKAction *moveBack = [SKAction moveTo:CGPointMake(fisrtX, firtsY) duration:0.3];
    
    [contentView runAction:moveBack];
    

}
-(void)drawPathIndictorWithStatus:(GraphCellStatus)status
{
    if(self.IsOccupied == NO)
    {
        contentView.alpha = 0.4;
        contentView.texture = [self getImageForStatus:status];
    }
}
-(void)unDrawPathIndictor
{
    if(self.IsOccupied == NO)
    {
        contentView.texture = nil;
        contentView.alpha = 1.0;
    }
    
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}




-(void)HandleTap:(UIGestureRecognizer*)sender
{
    if([_delegate respondsToSelector:@selector(CellViewTouched:)])
    {
        [_delegate CellViewTouched:self];
    }
}





-(void)cellTouched
{
    
    //self.zPosition = 1000;

    [self startJiggling];
}


-(void)cellUnTouched{
    
    
    [self stopJiggling];
}

- (void)startJiggling {
    [contentView runAction:[CellViewAnimator sharedInstance].jigglingAction withKey:@"jiggle"];
}
- (void)stopJiggling {
    
    [contentView removeActionForKey:@"jiggle"];
    
    [contentView runAction:[CellViewAnimator sharedInstance].resetJigglingAction];
}


-(void)dealloc
{
    
    
}


-(UIColor*)getColorWithStatus:(GraphCellStatus)status
{
    UIColor *backColor ;
    switch (status) {
        case red:
            backColor  = [UIColor redColor];
            break;
        case blue:
            backColor = [UIColor blueColor];
            break;
        case green:
            backColor = [UIColor greenColor];
            break;
        case yellow:
            backColor = [UIColor redColor];
            break;
        case orange:
            backColor = [UIColor orangeColor];
            break;
        default:
            backColor = [UIColor whiteColor];
            break;
    }
    return backColor;
}


-(SKTexture*)getImageForStatus:(GraphCellStatus)status
{
    SKTexture *backColor ;
    switch (status) {
        case red:
            backColor  = [CellViewTextures sharedInstance].strawberryImg;
            break;
        case blue:
            backColor = [CellViewTextures sharedInstance].blueberryImg;
            break;
        case green:
            backColor = [CellViewTextures sharedInstance].watermelonImg;
            break;
        case yellow:
            backColor = [CellViewTextures sharedInstance].appleImg;
            break;
        case orange:
            backColor = [CellViewTextures sharedInstance].orangeImg;
            break;
        default:
            backColor = nil;
            break;
    }
    return backColor;
}

-(SKTexture*)getBlurredImageForStatus:(GraphCellStatus)status
{
    SKTexture *backColor ;
    switch (status) {
        case red:
            backColor  = [CellViewTextures sharedInstance].strawberryImg_blur;
            break;
        case blue:
            backColor = [CellViewTextures sharedInstance].blueberryImg_blur;
            break;
        case green:
            backColor = [CellViewTextures sharedInstance].watermelonImg_blur;
            break;
        case yellow:
            backColor = [CellViewTextures sharedInstance].appleImg_blur;
            break;
        case orange:
            backColor = [CellViewTextures sharedInstance].orangeImg_blur;
            break;
        default:
            backColor = nil;
            break;
    }
    return backColor;
}

-(void)SetStatusWithGraphCell:(GraphCell*)GCell Animatation:(CellAnimationType)animationType withCompletionBlock:(CellAnimationCompletionBlock)completionBlock
{
    
    
    [self SetStatusWithGraphCell:GCell Animatation:animationType withDelay:0.0 withCompletionBlock:completionBlock];
    
    
}


-(void)SetStatusWithGraphCell:(GraphCell*)GCell Animatation:(CellAnimationType)animationType withDelay:(NSTimeInterval)delay withCompletionBlock:(CellAnimationCompletionBlock)completionBlock
{
    if(GCell.color==unOccupied)
    {
        self.IsOccupied = NO;
    }else
    {
        self.IsOccupied = YES;
    }
    SKTexture *backColor  = [self getImageForStatus:GCell.color];
    
    if(_IsOccupied && animationType==CellAnimationTypeAdded)
    {
        [self animateCellWithColor:backColor withDelay:delay withCompletionBlock:completionBlock];
        return;
    }
    if (animationType==CellAnimationTypeRemoval)
    {
        [self animateCellRemovalWithDelay:delay withCompletionBlock:completionBlock];
        return;
    }
    
    if(animationType == CellAnimationTypeNone)
    {
        contentView.texture = backColor;
        completionBlock(YES);
    }
}


-(void)animateCellWithColor:(SKTexture*)Color withDelay:(NSTimeInterval)delay withCompletionBlock:(CellAnimationCompletionBlock)completionBlock
{
    contentView.zPosition = 1000;
    contentView.alpha = 0.0;
    
    contentView.texture  = Color;
    
    
    SKAction *delayAction = [SKAction waitForDuration:delay*0.2];
    
    
    
    
    
    SKAction *squense = [SKAction sequence:@[delayAction,[CellViewAnimator sharedInstance].fadeInScaleUp,[CellViewAnimator sharedInstance].scaleDownAction]];
    
    [contentView runAction:squense completion:^{
    
        
        contentView.zPosition = 10;
        completionBlock(YES);
    
    }];
    
    
}
-(void)removeCell:(removedRowOrientation)orientation animted:(BOOL)animated withStatus:(GraphCellStatus)status withCompletionBlock:(CellAnimationCompletionBlock)completionBlock
{
    self.IsOccupied = NO;
    [self animateCellRemovalWithDelay:0.0 withOrientation:(removedRowOrientation)orientation withStatus:status  withCompletionBlock:completionBlock];
}
-(SKAction*)removalActionWithOrientation:(removedRowOrientation)orientation
{
    SKAction *removalAction;
    
    switch (orientation) {
        case removedRowOrientationVertical:
            removalAction = [CellViewAnimator sharedInstance].removalVertical;
            break;
        case removedRowOrientationHorizontal:
            removalAction = [CellViewAnimator sharedInstance].removalHorizontal;
            break;
        case removedRowOrientationDiagonalToTheRight:
            removalAction = [CellViewAnimator sharedInstance].removalDiagonalToTheRight;
            break;
        case removedRowOrientationDiagonalToTheLeft:
            removalAction = [CellViewAnimator sharedInstance].removalDiagonalToTheLeft;
            break;
            
        default:
            break;
    }
    return removalAction;
}
-(void)animateCellRemovalWithDelay:(NSTimeInterval)delay withOrientation:(removedRowOrientation)orientation withStatus:(GraphCellStatus)status withCompletionBlock:(CellAnimationCompletionBlock)completionBlock
{
    contentView.zPosition = 1000;
    
    SKAction *delayAction = [SKAction waitForDuration:delay*0.15];
    
    contentView.texture = [self getBlurredImageForStatus:status];
    
    SKAction *sequense = [SKAction sequence:@[delayAction,[self removalActionWithOrientation:orientation]]];
    
    [contentView runAction:sequense completion:^{
        
        
        contentView.texture = nil;
        contentView.alpha = 1.0;
        [contentView runAction:[CellViewAnimator sharedInstance].removalReset];
        contentView.zPosition = 10;
        completionBlock(YES);
        
        
    }];
}
-(void)animateCellRemovalWithDelay:(NSTimeInterval)delay withCompletionBlock:(CellAnimationCompletionBlock)completionBlock
{
    contentView.zPosition = 1000;
    
    SKAction *delayAction = [SKAction waitForDuration:delay*0.15];
    

    

    
    
    SKAction *sequense = [SKAction sequence:@[delayAction,[CellViewAnimator sharedInstance].removalDiagonalToTheLeft]];
    
    [contentView runAction:sequense completion:^{
    
        
        contentView.texture = nil;
        contentView.alpha = 1.0;
        [contentView runAction:[CellViewAnimator sharedInstance].removalReset];
        contentView.zPosition = 10;
        completionBlock(YES);
    
    
    }];
    
   
    
}





@end
