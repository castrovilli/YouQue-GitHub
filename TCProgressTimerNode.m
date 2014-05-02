//
//  TCProgressTimerNode.m
//  TCProgressTimerDemo
//
//  Created by Tony Chamblee on 11/17/13.
//  Copyright (c) 2013 Tony Chamblee. All rights reserved.
//

#import "TCProgressTimerNode.h"
#import "TCProgressTimerForegroundCropNode.h"

@interface TCProgressTimerNode ()

@property (nonatomic, strong) SKSpriteNode *backgroundImageSpriteNode;
@property (nonatomic, strong) TCProgressTimerForegroundCropNode *foregroundCropNode;
@property (nonatomic, strong) SKSpriteNode *accessorySpriteNode;

@end

@implementation TCProgressTimerNode

#pragma mark - Init / Dealloc

- (id)initWithForegroundImageNamed:(NSString *)foregroundImageName
              backgroundImageNamed:(NSString *)backgroundImageName
               accessoryImageNamed:(NSString *)accessoryImageName;

{
    SKTexture *backgroundTexture = nil;
    SKTexture *foregroundTexture = nil;
    SKTexture *accessoryTexture = nil;
    
    if (backgroundImageName)
    {
        backgroundTexture = [SKTexture textureWithImageNamed:backgroundImageName];
    }
    
    if (foregroundImageName)
    {
        foregroundTexture = [SKTexture textureWithImageNamed:foregroundImageName];
    }
    
    if (accessoryImageName)
    {
        accessoryTexture = [SKTexture textureWithImageNamed:accessoryImageName];
    }
    
    return [self initWithForegroundTexture:foregroundTexture
                         backgroundTexture:backgroundTexture
                          accessoryTexture:accessoryTexture];
}


- (id)initWithForegroundTexture:(SKTexture *)foregroundTexture
              backgroundTexture:(SKTexture *)backgroundTexture
               accessoryTexture:(SKTexture *)accessoryTexture;
{
    if (!foregroundTexture)
    {
        NSAssert(NO, @"Error - must be initialized with foreground texture.");
        return nil;
    }
    
    self = [super initWithColor:[UIColor clearColor] size:CGSizeMake(60, 60)];
    
    if (self)
    {
        [self initializeBackgroundImageSpriteNodeWithTexture:backgroundTexture];
        [self initializeForegroundCropNodeWithTexture:foregroundTexture];
        [self initializeAccessorySpriteNodeWithTexture:accessoryTexture];
    }
    
    return self;
}

#pragma mark - Initialization

- (void)initializeBackgroundImageSpriteNodeWithTexture:(SKTexture *)backgroundTexture
{
    if (backgroundTexture)
    {
        _backgroundImageSpriteNode = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
        _backgroundImageSpriteNode.size = self.size;
        [self addChild:_backgroundImageSpriteNode];
    }
}

- (void)initializeForegroundCropNodeWithTexture:(SKTexture *)foregroundTexture
{
    _foregroundCropNode = [[TCProgressTimerForegroundCropNode alloc] initWithTexture:foregroundTexture];
    [self addChild:_foregroundCropNode];
}

- (void)initializeAccessorySpriteNodeWithTexture:(SKTexture *)accessoryTexture
{
    if (accessoryTexture)
    {
        _accessorySpriteNode = [SKSpriteNode spriteNodeWithTexture:accessoryTexture];
        [self addChild:_accessorySpriteNode];
    }
}

#pragma mark - Public Methods

- (void)setProgress:(CGFloat)progress
{
    [self.foregroundCropNode setProgress:progress];
}

@end
