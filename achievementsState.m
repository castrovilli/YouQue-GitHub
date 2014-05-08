//
//  achievementsState.m
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/24/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "achievementsState.h"
@interface achievementsState()

@property(nonatomic,assign)NSUInteger numberOfConsecutiveRowCollection;
@property(nonatomic,assign)NSUInteger numberOfClearedOutCells;

@end
@implementation achievementsState
-(id)init
{
    self = [super init];
    if(self)
    {
        self.numberOfClearedOutCells = 0;
        self.numberOfConsecutiveRowCollection = 0;
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.numberOfClearedOutCells = ((NSNumber*)[aDecoder decodeObjectForKey:@"numberOfClearedOutCells"]).integerValue;
        self.numberOfConsecutiveRowCollection = ((NSNumber*)[aDecoder decodeObjectForKey:@"numberOfConsecutiveRowCollection"]).integerValue;
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithInteger:self.numberOfClearedOutCells] forKey:@"numberOfClearedOutCells"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.numberOfConsecutiveRowCollection] forKey:@"numberOfConsecutiveRowCollection"];
}
-(id)copyWithZone:(NSZone *)zone
{
    achievementsState *copy = [[achievementsState alloc] init];
    if(copy)
    {
        [copy setNumberOfClearedOutCells:self.numberOfClearedOutCells];
        [copy setNumberOfConsecutiveRowCollection:self.numberOfConsecutiveRowCollection];
        
    }
    return copy;
}
-(void)reportAchievementWithNumberOfClearedOutCells:(NSUInteger)NoOfClearedOutCells Newlevel:(int)Newlevel OldLevel:(int)oldLevel
{
    
    if(NoOfClearedOutCells == 0)
    {
        _numberOfConsecutiveRowCollection = 0;
    }else
    {
        _numberOfConsecutiveRowCollection++;
    }
    
    self.numberOfClearedOutCells += NoOfClearedOutCells;
    
    NSMutableArray *achievements = [NSMutableArray array];
    if(NoOfClearedOutCells == 5)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:FRUITS_5_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:FRUITS_5_ACHIEVEMENT_TITLE] points:10];
        acheievement.percentage = 100;
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
    }
    if(NoOfClearedOutCells == 6)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:FRUITS_6_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:FRUITS_6_ACHIEVEMENT_TITLE] points:10];
        acheievement.percentage = 100;
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
    }
    
    if(NoOfClearedOutCells == 7)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:FRUITS_7_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:FRUITS_7_ACHIEVEMENT_TITLE] points:10];
        acheievement.percentage = 100;
        [achievements addObject:acheievement];
        
        
        
        NSLog(@"%@",acheievement.identifier);
        ShareEntity *entity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 7 fruits",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
        [self shareEntity:entity];
    }
    
    if(_numberOfConsecutiveRowCollection == 2)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_2X_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_2X_ACHIEVEMENT_TITLE] points:10];

        acheievement.percentage = 100;
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
    }
    
    if(_numberOfConsecutiveRowCollection == 4)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_4X_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_4X_ACHIEVEMENT_TITLE] points:40];
        acheievement.percentage = 100;
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
    }
    
    if(_numberOfConsecutiveRowCollection == 6)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_6X_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_6X_ACHIEVEMENT_TITLE] points:60];
        acheievement.percentage = 100;
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
        ShareEntity *entity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 6x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
        [self shareEntity:entity];
    }
    
    if(_numberOfConsecutiveRowCollection == 8)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_8X_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_8X_ACHIEVEMENT_TITLE] points:80];
        acheievement.percentage = 100;
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
        
        ShareEntity *entity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 8x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
        [self shareEntity:entity];
    }
    
    if(_numberOfConsecutiveRowCollection == 10)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_10X_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_10X_ACHIEVEMENT_TITLE] points:100];
    
        acheievement.percentage = 100;
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
        
        ShareEntity *entity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 10x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
        [self shareEntity:entity];
    }
    
    
   
    
    
    
    MDAchievement *newLevelAch = [self newLevelAchievement:Newlevel oldLevel:oldLevel];
    
    if(newLevelAch)
    {
        [achievements addObject:newLevelAch];
        NSLog(@"%@",newLevelAch.identifier);
    }
    
    if(achievements.count > 0)
    {
        [self reportAchievements:achievements];
        [[NSNotificationCenter defaultCenter] postNotificationName:FRUITS5_ACHIEVEMENT object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:achievements,ACHIEVEMENTS_INFO_KEY, nil]];
    }
    
    [self reportYouQueAchievementsWithNumberOfClearedOutCells:_numberOfClearedOutCells];
   
}
-(void)reportYouQueAchievementsWithNumberOfClearedOutCells:(int)number
{
    NSMutableArray *achievements = [NSMutableArray array];
    
    if(_numberOfClearedOutCells <= 1000)
    {
        GKAchievement *acheievement = [[GKAchievement alloc] initWithIdentifier:YOUQUE_BEGINNER_ACHIEVEMENT_ID];
        
        acheievement.percentComplete = _numberOfClearedOutCells / 1000;
        acheievement.percentComplete *= 100;
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
        
        
    }else if (_numberOfClearedOutCells <= 10000)
    {
        GKAchievement *acheievement = [[GKAchievement alloc] initWithIdentifier:YOUQUE_INTERMEDIATE_ACHIEVEMENT_ID];
        
        acheievement.percentComplete = _numberOfClearedOutCells / 10000;
        acheievement.percentComplete *= 100;
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
        
    }else if (_numberOfClearedOutCells <= 100000)
    {
        GKAchievement *acheievement = [[GKAchievement alloc] initWithIdentifier:YOUQUE_MASTER_ACHIEVEMENT_ID];
        
        acheievement.percentComplete = _numberOfClearedOutCells / 100000;
        acheievement.percentComplete *= 100;
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
    }else
    {
        GKAchievement *acheievement = [[GKAchievement alloc] initWithIdentifier:YOUQUE_HARDCORE_ACHIEVEMENT_ID];
        
        acheievement.percentComplete = _numberOfClearedOutCells / 1000000;
        acheievement.percentComplete *= 100;
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
    }
    
    [self reportAChievementsToGameCenter:achievements];
    

}
-(void)shareEntity:(ShareEntity*)entity
{
    
}
-(void)notifyDelegateWithNewPoints:(int)points
{
    if([_delegate respondsToSelector:@selector(addAchievementsPoints:)])
    {
        [_delegate addAchievementsPoints:points];
    }
}
-(MDAchievement*)newLevelAchievement:(int)Newlevel oldLevel:(int)oldLevel
{
    if(oldLevel == Newlevel)
    {
        return nil;
        
    }
    
    if(Newlevel == 2)
    {
        return [self achievementWitjIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:LEVEL_2_REACHED_ACHIEVEMENT_ID] withPercentage:100.0 withTitle:[[TemplateConfiguration sharedInstance] valueForKey:LEVEL_2_REACHED_ACHIEVEMENT_TITLE]];
    }else if(Newlevel == 3)
    {
        return [self achievementWitjIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:LEVEL_3_REACHED_ACHIEVEMENT_ID] withPercentage:100.0 withTitle:[[TemplateConfiguration sharedInstance] valueForKey:LEVEL_3_REACHED_ACHIEVEMENT_TITLE]];
    }else if(Newlevel == 4)
    {
        return [self achievementWitjIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:LEVEL_4_REACHED_ACHIEVEMENT_ID] withPercentage:100.0 withTitle:[[TemplateConfiguration sharedInstance] valueForKey:LEVEL_4_REACHED_ACHIEVEMENT_TITLE]];
    }else
    {
        return nil;
    }
}

-(MDAchievement*)achievementWitjIdentifier:(NSString*)ID withPercentage:(double)percent withTitle:(NSString*)title
{
    MDAchievement *achievement = [[MDAchievement alloc] initWithIdentifier:ID title:title points:percent];
    
    return achievement;
}
- (void) reportAchievements:(NSArray*)achievements
{
    NSMutableArray *GKAchievements = [NSMutableArray array];
    
    for(MDAchievement *ach in achievements)
    {
        GKAchievement *GkAch = [[GKAchievement alloc] initWithIdentifier:ach.identifier];
        GkAch.percentComplete = ach.percentage;
        [GKAchievements addObject:GkAch];
    }
    [self reportAChievementsToGameCenter:GKAchievements];
}
-(void)reportAChievementsToGameCenter:(NSArray*)GKAchievements
{
    [GKAchievement reportAchievements: GKAchievements withCompletionHandler:^(NSError *error)
     {
         if (error != nil)
         {
             NSLog(@"Error in reporting achievements: %@", error);
         }
     }];
}
-(void)shareAchievements:(NSArray*)achievements
{
    for(GKAchievement *ach in achievements)
    {
        ShareEntity *entity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved %@",[[FaceBookManager sharedInstance] FullName],ach.identifier] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
        [[FaceBookManager sharedInstance] share:entity];
    }
    
}
@end
