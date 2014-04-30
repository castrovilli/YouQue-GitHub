//
//  CellViewTextures.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/27/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "CellViewTextures.h"

@implementation CellViewTextures
+(CellViewTextures*)sharedInstance
{
    static dispatch_once_t onceToken;
    static CellViewTextures *animator=nil;
    dispatch_once( &onceToken, ^{
        animator = [[[self class] alloc] init];
        
        
    });
    return animator;
}
-(id)init
{
    self = [super init];
    if(self)
    {
        _strawberryImg = [SKTexture textureWithImageNamed:@"strawberryicon50x50.png"];
        _blueberryImg = [SKTexture textureWithImageNamed:@"blueberrycoloricon50x50.png"];
        _watermelonImg = [SKTexture textureWithImageNamed:@"Watermelonicon50x50.png"];
        _appleImg = [SKTexture textureWithImageNamed:@"Apple50x50.png"];
        _orangeImg = [SKTexture textureWithImageNamed:@"Orange50x50.png"];
        _emptyImg = [SKTexture textureWithImageNamed:@"emptyCell1.png"];
        
        
        _strawberryImg_blur = [SKTexture textureWithImageNamed:@"strawberryicon50x50-blur.png"];
        _blueberryImg_blur = [SKTexture textureWithImageNamed:@"blueberrycoloricon50x50-blur.png"];
        _watermelonImg_blur = [SKTexture textureWithImageNamed:@"Watermelonicon50x50-blur.png"];
        _appleImg_blur = [SKTexture textureWithImageNamed:@"Apple50x50-blur.png"];
        _orangeImg_blur = [SKTexture textureWithImageNamed:@"Orange50x50-blur.png"];
        _emptyImg_blur = [SKTexture textureWithImageNamed:@"emptyCell1.png"];
    }
    
    return self;
}
@end
