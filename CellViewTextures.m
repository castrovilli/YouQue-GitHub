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
        _strawberryImg = [SKTexture textureWithImageNamed:[[TemplateConfiguration sharedInstance] valueForKey:STRAWBERRY_IMAGE_KEY]];
        _blueberryImg = [SKTexture textureWithImageNamed:[[TemplateConfiguration sharedInstance] valueForKey:BLUEBERRY_IMAGE_KEY]];
        _watermelonImg = [SKTexture textureWithImageNamed:[[TemplateConfiguration sharedInstance] valueForKey:WATERMELON_IMAGE_KEY]];
        _appleImg = [SKTexture textureWithImageNamed:[[TemplateConfiguration sharedInstance] valueForKey:APPLE_IMAGE_KEY]];
        _orangeImg = [SKTexture textureWithImageNamed:[[TemplateConfiguration sharedInstance] valueForKey:ORANGE_IMAGE_KEY]];
        _emptyImg = [SKTexture textureWithImageNamed:[[TemplateConfiguration sharedInstance] valueForKey:EMPTY_CELL_IMAGE_KEY]];
        
        
       /* _strawberryImg_blur = [SKTexture textureWithImageNamed:@"strawberryicon50x50-blur.png"];
        _blueberryImg_blur = [SKTexture textureWithImageNamed:@"blueberrycoloricon50x50-blur.png"];
        _watermelonImg_blur = [SKTexture textureWithImageNamed:@"Watermelonicon50x50-blur.png"];
        _appleImg_blur = [SKTexture textureWithImageNamed:@"Apple50x50-blur.png"];
        _orangeImg_blur = [SKTexture textureWithImageNamed:@"Orange50x50-blur.png"];
        _emptyImg_blur = [SKTexture textureWithImageNamed:@"emptyCell-wooden.png"];*/
    }
    
    return self;
}
@end
