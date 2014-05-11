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
        
        entitiesToBeShared = [NSMutableSet set];
        
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
        entitiesToBeShared = [aDecoder decodeObjectForKey:@"entitiesToBeShared"];
        
        
       [self initializeAchievementsAndShareEntities];
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithInteger:self.numberOfClearedOutCells] forKey:@"numberOfClearedOutCells"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.numberOfConsecutiveRowCollection] forKey:@"numberOfConsecutiveRowCollection"];
    [aCoder encodeObject:entitiesToBeShared forKey:@"entitiesToBeShared"];
    
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
    
    
    
    /*combo4xShareEntity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 4x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
    
    combo6xShareEntity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 6x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
    
    combo8xShareEntity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 8x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
    
    combo10xShareEntity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 10x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
    
    
    fruits7ShareEntity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 7 fruits",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];*/
}
-(void)postAchievements
{
    NSMutableString *message = [NSMutableString stringWithFormat:@"%@ accomplished %d acheivements \n",[[FaceBookManager sharedInstance] FullName],entitiesToBeShared.count];
    
    for(MDAchievement *ach in entitiesToBeShared)
    {
        [message appendFormat:@"\u00b7 %@ \n",ach.title];
        
    }
    
    ShareEntity *sharedEntityForAchievements = [[ShareEntity alloc] initWithMessage:message link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"new achievements"];
    if(entitiesToBeShared.count > 0)
    {
        [self shareAchievementPost:sharedEntityForAchievements];
        
        [self reportAchievements:entitiesToBeShared.allObjects];
    }
}
-(BOOL)isLastAchievementShareMoreThanDayAgo
{
    NSNumber *timeInterval = [[NSUserDefaults standardUserDefaults] objectForKey:ACHIEVEMENTS_LAST_SHARE_DATE_KEY];
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    
    if((now - timeInterval.integerValue) < 86400)
    {
        return NO;
    }else
    {
        return YES;
    }
}
-(void)shareAchievementPost:(ShareEntity*)sharedEntityForAchievements
{
    if(![self isLastAchievementShareMoreThanDayAgo])
    {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970]] forKey:ACHIEVEMENTS_LAST_SHARE_DATE_KEY];
    
    [[FaceBookManager sharedInstance] share:sharedEntityForAchievements];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:APP_WILL_RESIGN_ACTIVE_NOT object:nil];
}
-(void)resetCounter
{
    _numberOfClearedOutCells = 0;
    _numberOfConsecutiveRowCollection = 0;
    entitiesToBeShared = [NSMutableSet set];
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
        
        if(![entitiesToBeShared containsObject:fruits5Achievement])
        {
            [entitiesToBeShared addObject:fruits5Achievement];
        }
        
    }
    if(NoOfClearedOutCells == 6)
    {
        [achievements addObject:fruits6Achievement];
        
        NSLog(@"%@",fruits6Achievement.identifier);
        
        if(![entitiesToBeShared containsObject:fruits6Achievement])
        {
            [entitiesToBeShared addObject:fruits6Achievement];
        }
    }
    
    if(NoOfClearedOutCells >= 7)
    {
        [achievements addObject:fruits7Achievement];
        
        
        
        NSLog(@"%@",fruits7Achievement.identifier);
        
        if(![entitiesToBeShared containsObject:fruits7Achievement])
        {
            [entitiesToBeShared addObject:fruits7Achievement];
        }
    }
    
    if(_numberOfConsecutiveRowCollection == 2)
    {
        [achievements addObject:Combo2xAchievement];
        
        NSLog(@"%@",Combo2xAchievement.identifier);
        if(![entitiesToBeShared containsObject:Combo2xAchievement])
        {
            [entitiesToBeShared addObject:Combo2xAchievement];
        }
    }
    
    if(_numberOfConsecutiveRowCollection == 4)
    {
        [achievements addObject:Combo4xAchievement];
        
        NSLog(@"%@",Combo4xAchievement.identifier);
        
        if(![entitiesToBeShared containsObject:Combo4xAchievement])
        {
            [entitiesToBeShared addObject:Combo4xAchievement];
        }
        
    }
    
    if(_numberOfConsecutiveRowCollection == 6)
    {
        [achievements addObject:Combo6xAchievement];
        
        NSLog(@"%@",Combo6xAchievement.identifier);

        if(![entitiesToBeShared containsObject:Combo6xAchievement])
        {
            [entitiesToBeShared addObject:Combo6xAchievement];
        }
        
    }
    
    if(_numberOfConsecutiveRowCollection == 8)
    {
        [achievements addObject:Combo8xAchievement];
        
        NSLog(@"%@",Combo8xAchievement.identifier);
        
        if(![entitiesToBeShared containsObject:Combo8xAchievement])
        {
            [entitiesToBeShared addObject:Combo8xAchievement];
        }
        
    }
    
    if(_numberOfConsecutiveRowCollection == 10)
    {
        [achievements addObject:Combo10xAchievement];
        
        NSLog(@"%@",Combo10xAchievement.identifier);
        
        if(![entitiesToBeShared containsObject:Combo10xAchievement])
        {
            [entitiesToBeShared addObject:Combo10xAchievement];
        }
        
    }
    
    
   
    
    
    
    MDAchievement *newLevelAch = [self newLevelAchievement:Newlevel oldLevel:oldLevel];
    
    if(newLevelAch && ![entitiesToBeShared containsObject:newLevelAch])
    {
        [entitiesToBeShared addObject:newLevelAch];
        
        [achievements addObject:newLevelAch];
        NSLog(@"%@",newLevelAch.identifier);
    }
    
    if(achievements.count > 0)
    {
        
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
    if(![GKLocalPlayer localPlayer].isAuthenticated)
    {
        return;
    }
    
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
