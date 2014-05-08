//
//  MDAchievement.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 5/3/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "MDAchievement.h"

@implementation MDAchievement
-(id)initWithIdentifier:(NSString *)identifier title:(NSString *)title points:(int)points
{
    self = [super init];
    if(self)
    {
        _identifier = identifier;
        _points = points;
        _title = title;
        
        _gkAchievement = [[GKAchievement alloc] initWithIdentifier:_identifier];
    }
    return self;
}
@end
