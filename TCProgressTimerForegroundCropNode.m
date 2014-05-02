//
//  TCProgressTimerForegroundCropNode.m
//  TCProgressTimerDemo
//
//  Created by Tony Chamblee on 11/17/13.
//  Copyright (c) 2013 Tony Chamblee. All rights reserved.
//

#import "TCProgressTimerForegroundCropNode.h"

@interface TCProgressTimerForegroundCropNode ()

@property (nonatomic, strong) SKSpriteNode *indicatorSpriteNode;
@property (nonatomic, strong) SKShapeNode *maskShapeNode;

@property (nonatomic) CGFloat radius;

@end

@implementation TCProgressTimerForegroundCropNode

- (id)init
{
    return [self initWithTexture:nil];
}

- (id)initWithTexture:(SKTexture *)texture
{
    if (!texture)
    {
        NSAssert(NO, @"Error - must be initialized with texture.");
        return nil;
    }
    
    self = [super init];
    
    if (self)
    {
        _radius = texture.size.width / 2.0f;
        
        [self initializeIndicatorSpriteNodeWithTexture:texture];
        [self initializeMaskShapeNode];
    }
    
    return self;
}

#pragma mark - Initialization

- (void)initializeIndicatorSpriteNodeWithTexture:(SKTexture *)texture
{
    _indicatorSpriteNode = [SKSpriteNode spriteNodeWithTexture:texture];
    [self addChild:_indicatorSpriteNode];
}

- (void)initializeMaskShapeNode
{
    _maskShapeNode = [SKShapeNode node];
    _maskShapeNode.antialiased = NO;
    _maskShapeNode.lineWidth = _indicatorSpriteNode.texture.size.width;
    
    self.maskNode = _maskShapeNode;
}

- (void)setProgress:(CGFloat)progress
{
    progress = 1.0f - progress;
    
    CGFloat startAngle = M_PI / 2.0f;
    CGFloat endAngle = startAngle + (progress * 2.0f * M_PI);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                                        radius:self.radius
                                                    startAngle:endAngle
                                                    endAngle:startAngle
                                                    clockwise:YES];
    self.maskShapeNode.path = path.CGPath;
}

@end
