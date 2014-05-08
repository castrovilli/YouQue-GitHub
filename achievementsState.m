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
        [self initializeAchievementsAndShareEntities];
        
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
        
        
        
       [self initializeAchievementsAndShareEntities];
        
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

-(void)initializeAchievementsAndShareEntities
{
    fruits5Achievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:FRUITS_5_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:FRUITS_5_ACHIEVEMENT_TITLE] points:10];
    fruits5Achievement.percentage = 100;
    
    fruits6Achievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:FRUITS_6_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:FRUITS_6_ACHIEVEMENT_TITLE] points:10];
    fruits6Achievement.percentage = 100;
    
    fruits7Achievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:FRUITS_7_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:FRUITS_7_ACHIEVEMENT_TITLE] points:10];
    fruits7Achievement.percentage = 100;
    
    Combo2xAchievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_2X_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_2X_ACHIEVEMENT_TITLE] points:10];
    Combo2xAchievement.percentage = 100;
    
    Combo4xAchievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_4X_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_4X_ACHIEVEMENT_TITLE] points:40];
    Combo4xAchievement.percentage = 100;
    
    Combo6xAchievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_6X_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_6X_ACHIEVEMENT_TITLE] points:60];
    Combo6xAchievement.percentage = 100;
    
    Combo8xAchievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_8X_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_8X_ACHIEVEMENT_TITLE] points:80];
    Combo8xAchievement.percentage = 100;
    
    Combo10xAchievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_10X_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:COMBO_10X_ACHIEVEMENT_TITLE] points:100];
    Combo10xAchievement.percentage = 100;
    
    level2Achievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:LEVEL_2_REACHED_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:LEVEL_2_REACHED_ACHIEVEMENT_TITLE] points:100];
    level2Achievement.percentage = 100;
    
    level3Achievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:LEVEL_3_REACHED_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:LEVEL_3_REACHED_ACHIEVEMENT_TITLE] points:100];
    level3Achievement.percentage = 100;
    
    level4Achievement = [[MDAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:LEVEL_4_REACHED_ACHIEVEMENT_ID] title:[[TemplateConfiguration sharedInstance] valueForKey:LEVEL_4_REACHED_ACHIEVEMENT_TITLE] points:100];
    level4Achievement.percentage = 100;
    
    
    
    combo4xShareEntity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 4x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
    
    combo6xShareEntity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 6x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
    
    combo8xShareEntity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 8x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
    
    combo10xShareEntity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 10x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
}

-(void)resetCounter
{
    _numberOfClearedOutCells = 0;
    _numberOfConsecutiveRowCollection = 0;
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
        [achievements addObject:fruits5Achievement];
        
        NSLog(@"%@",fruits5Achievement.identifier);
    }
    if(NoOfClearedOutCells == 6)
    {
        [achievements addObject:fruits6Achievement];
        
        NSLog(@"%@",fruits6Achievement.identifier);
    }
    
    if(NoOfClearedOutCells == 7)
    {
        [achievements addObject:fruits7Achievement];
        
        
        
        NSLog(@"%@",fruits7Achievement.identifier);
        ShareEntity *entity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 7 fruits",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
        [self shareEntity:entity];
    }
    
    if(_numberOfConsecutiveRowCollection == 2)
    {
        [achievements addObject:Combo2xAchievement];
        
        NSLog(@"%@",Combo2xAchievement.identifier);
    }
    
    if(_numberOfConsecutiveRowCollection == 4)
    {
        [achievements addObject:Combo4xAchievement];
        
        NSLog(@"%@",Combo4xAchievement.identifier);
        
        [self shareEntity:combo4xShareEntity];
    }
    
    if(_numberOfConsecutiveRowCollection == 6)
    {
        [achievements addObject:Combo6xAchievement];
        
        NSLog(@"%@",Combo6xAchievement.identifier);

        [self shareEntity:combo6xShareEntity];
    }
    
    if(_numberOfConsecutiveRowCollection == 8)
    {
        [achievements addObject:Combo8xAchievement];
        
        NSLog(@"%@",Combo8xAchievement.identifier);
        
        [self shareEntity:combo8xShareEntity];
    }
    
    if(_numberOfConsecutiveRowCollection == 10)
    {
        [achievements addObject:Combo10xAchievement];
        
        NSLog(@"%@",Combo10xAchievement.identifier);
        
        [self shareEntity:combo10xShareEntity];
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
    
    
   
}
-(void)reportYouQueAchievements
{
   /* NSMutableArray *achievements = [NSMutableArray array];
    
    
    GKAchievement *acheievement = [[GKAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:YOUQUE_BEGINNER_ACHIEVEMENT_ID]];
    
    acheievement.percentComplete = (_numberOfClearedOutCells * 100) / 1000;
    [achievements addObject:acheievement];
    
    NSLog(@"%@ %d",acheievement.identifier,(_numberOfClearedOutCells * 100) / 1000);
    
    

    if (_numberOfClearedOutCells > 1000)
    {
        GKAchievement *acheievement = [[GKAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:YOUQUE_INTERMEDIATE_ACHIEVEMENT_ID]];
        
        acheievement.percentComplete = (_numberOfClearedOutCells * 100) / 10000;
        [achievements addObject:acheievement];
        
        NSLog(@"%@ %d",acheievement.identifier,(_numberOfClearedOutCells * 100) / 10000);
        
    }
    
    if (_numberOfClearedOutCells > 10000)
    {
        GKAchievement *acheievement = [[GKAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:YOUQUE_MASTER_ACHIEVEMENT_ID]];
        
        acheievement.percentComplete = (_numberOfClearedOutCells * 100) / 100000;
        [achievements addObject:acheievement];
        
        NSLog(@"%@ %d",acheievement.identifier,(_numberOfClearedOutCells * 100) / 100000);
    }
    
    if (_numberOfClearedOutCells > 100000)
    {
        GKAchievement *acheievement = [[GKAchievement alloc] initWithIdentifier:[[TemplateConfiguration sharedInstance] valueForKey:YOUQUE_HARDCORE_ACHIEVEMENT_ID]];
        
        acheievement.percentComplete = (_numberOfClearedOutCells * 100) / 1000000;
        [achievements addObject:acheievement];
        
        NSLog(@"%@ %d",acheievement.identifier,(_numberOfClearedOutCells * 100) / 1000000);
    }
    
    [self reportAChievementsToGameCenter:achievements];*/
    

}
-(void)shareEntity:(ShareEntity*)entity
{
    [[FaceBookManager sharedInstance] share:entity];
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
        return level2Achievement;
    }else if(Newlevel == 3)
    {
        return level3Achievement;
    }else if(Newlevel == 4)
    {
        return level4Achievement;
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
        [GKAchievements addObject:ach.gkAchievement];
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
