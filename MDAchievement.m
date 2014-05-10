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
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        _identifier = [aDecoder decodeObjectForKey:@"identifier"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _gkAchievement = [aDecoder decodeObjectForKey:@"gkAchievement"];
        _points = ((NSNumber*)[aDecoder decodeObjectForKey:@"points"]).intValue;
        _percentage = ((NSNumber*)[aDecoder decodeObjectForKey:@"percentage"]).floatValue;
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_identifier forKey:@"identifier"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_gkAchievement forKey:@"gkAchievement"];
    [aCoder encodeObject:[NSNumber numberWithInt:_points] forKey:@"points"];
    [aCoder encodeObject:[NSNumber numberWithFloat:_percentage] forKey:@"percentage"];
}
-(BOOL)isEqual:(id)object
{
    return [_identifier isEqual:((MDAchievement*)object).identifier];
}
-(NSUInteger)hash
{
    return [_identifier hash];
}
@end
