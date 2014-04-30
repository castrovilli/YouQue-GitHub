//
//  CellViewTextures.h
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/27/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
@interface CellViewTextures : NSObject
{
    
}
+(CellViewTextures*)sharedInstance;
@property(nonatomic,retain,readonly)SKTexture *orangeImg;
@property(nonatomic,retain,readonly)SKTexture *watermelonImg;
@property(nonatomic,retain,readonly)SKTexture *strawberryImg;
@property(nonatomic,retain,readonly)SKTexture *blueberryImg;
@property(nonatomic,retain,readonly)SKTexture *appleImg;
@property(nonatomic,retain,readonly)SKTexture *emptyImg;


@property(nonatomic,retain,readonly)SKTexture *orangeImg_blur;
@property(nonatomic,retain,readonly)SKTexture *watermelonImg_blur;
@property(nonatomic,retain,readonly)SKTexture *strawberryImg_blur;
@property(nonatomic,retain,readonly)SKTexture *blueberryImg_blur;
@property(nonatomic,retain,readonly)SKTexture *appleImg_blur;
@property(nonatomic,retain,readonly)SKTexture *emptyImg_blur;
@end
