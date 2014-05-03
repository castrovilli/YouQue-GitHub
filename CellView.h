//
//  CellView.h
//  DavinciCode
//
//  Created by Mohammed Eldehairy on 12/28/12.
//  Copyright (c) 2012 Mohammed Eldehairy. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GraphCell.h"
#define RIGHT_IMAGE_NAME @"SQUARE2.png"
#define WRONG_IMAGE_NAME @"WRONG TOUCH.png"
#define SQUARE_IMAGE @"SQUARE WHITE UNPRESSED.png"
#import "CellViewAnimator.h"
#import "CellViewTextures.h"
#import "RemovedRowEntity.h"
#define CELL_SIZE ((([[UIDevice currentDevice] userInterfaceIdiom]) == (UIUserInterfaceIdiomPhone)) ? (41) : (60))



@protocol CellViewDelegate;
typedef void (^CellAnimationCompletionBlock)(BOOL finished);
typedef enum
{
    CellAnimationTypeRemoval,
    CellAnimationTypeAdded,
    CellAnimationTypeNone
    
}CellAnimationType;
@interface CellView : SKSpriteNode<UIGestureRecognizerDelegate>
{
    SKSpriteNode *contentView;
    
    CGRect originalRect;
    
    int fisrtX;
    int firtsY;
    
    SKEffectNode *fruitBlurEffect;
    
    SKAction *_fruitBlurAction;
    
    BOOL dragging;
    
}
@property(nonatomic,assign)id<CellViewDelegate> delegate;
@property(nonatomic)BOOL IsOccupied;
@property(nonatomic)BOOL SetTouchable;
@property(nonatomic)NSUInteger tag;

- (id)initWithFrame:(CGRect)frame;


-(void)drawPathIndictorWithStatus:(GraphCellStatus)status;
-(void)unDrawPathIndictor;
-(void)resetDrageAnimated:(BOOL)animated;

//Notify the Cell that it has been touched to glow
-(void)cellTouched;
-(void)cellUnTouched;

// Methods to set the colour status of the cell with animation
-(void)SetStatusWithGraphCell:(GraphCell*)GCell Animatation:(CellAnimationType)animationType withCompletionBlock:(CellAnimationCompletionBlock)completionBlock;
-(void)SetStatusWithGraphCell:(GraphCell*)GCell Animatation:(CellAnimationType)animationType withDelay:(NSTimeInterval)delay withCompletionBlock:(CellAnimationCompletionBlock)completionBlock;
-(void)removeCell:(removedRowOrientation)orientation animted:(BOOL)animated withStatus:(GraphCellStatus)status withCompletionBlock:(CellAnimationCompletionBlock)completionBlock;

-(UIColor*)getColorWithStatus:(GraphCellStatus)status;
@end
@protocol CellViewDelegate <NSObject>
-(void)CellViewTouched:(CellView*)cellView;
-(void)CellViewDragged:(CellView*)cellView withState:(UIGestureRecognizerState)state withNewPoint:(CGPoint)newPoint;
-(void)cellViewDraggingCanceled:(CellView*)cellview ;
@end