//
//  TCProgressTimerNode.h
//  TCProgressTimerDemo
//
//  Created by Tony Chamblee on 11/17/13.
//  Copyright (c) 2013 Tony Chamblee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TCProgressTimerNode : SKSpriteNode

- (id)initWithForegroundImageNamed:(NSString *)foregroundImageName
              backgroundImageNamed:(NSString *)backgroundImageName
               accessoryImageNamed:(NSString *)accessoryImageName;

- (id)initWithForegroundTexture:(SKTexture *)foregroundTexture
              backgroundTexture:(SKTexture *)backgroundTexture
               accessoryTexture:(SKTexture *)accessoryTexture;

- (void)setProgress:(CGFloat)progress;

@end
