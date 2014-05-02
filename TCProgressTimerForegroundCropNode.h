//
//  TCProgressTimerForegroundCropNode.h
//  TCProgressTimerDemo
//
//  Created by Tony Chamblee on 11/17/13.
//  Copyright (c) 2013 Tony Chamblee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TCProgressTimerForegroundCropNode : SKCropNode

- (id)initWithTexture:(SKTexture *)texture;
- (void)setProgress:(CGFloat)progress;

@end
