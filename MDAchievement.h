//
//  MDAchievement.h
//  YouQue
//
//  Created by Mohammed Eldehairy on 5/3/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDAchievement : NSObject
-(id)initWithIdentifier:(NSString*)identifier title:(NSString*)title points:(int)points;
@property(nonatomic,retain,readonly)NSString *identifier;
@property(nonatomic,retain,readonly)NSString *title;
@property(nonatomic,readonly)int points;
@end