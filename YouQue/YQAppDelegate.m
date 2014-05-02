//
//  YQAppDelegate.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/26/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "YQAppDelegate.h"
#import <RevMobAds/RevMobAds.h>
@implementation YQAppDelegate
- (BOOL)hasFourInchDisplay {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    if(![self adRemovalPurchased] && [self hasFourInchDisplay])
    {
        [RevMobAds startSessionWithAppID:@"53588cadd63ee9c01fe876de"];
        [RevMobAds session].testingMode = RevMobAdsTestingModeWithAds;
    }
    
    [[FaceBookManager sharedInstance] Initializefacebook];
    // [MMSDK initialize]; //Initialize a Millennial Media session
   // [STAStartAppAd initWithAppId:@"204223654" developerId:@"104470863"];
    // Override point for customization after application launch.
    
    [self authenticateLocalPlayer];
    
    return YES;
}
- (void) authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    __weak GKLocalPlayer *player = localPlayer;
    
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil)
        {
            
            
            [self.window.rootViewController presentViewController:viewController animated:YES completion:nil];
        }
        else if (player.isAuthenticated)
        {
            [self getPlayerHighScore];
        }
        else
        {
            
        }
    };
    
}
-(void)getPlayerHighScore
{
    
    
    NSString *playerID = [GKLocalPlayer localPlayer].playerID;
    GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] initWithPlayerIDs:[NSArray arrayWithObject:playerID]];
    
    if((floorf([[UIDevice currentDevice] systemVersion].floatValue))>=7.0)
    {
        leaderboardRequest.identifier = @"YouQueMainLeaderboard";
    }
    
    leaderboardRequest.timeScope = GKLeaderboardTimeScopeAllTime;
    
    if (leaderboardRequest != nil) {
        [leaderboardRequest loadScoresWithCompletionHandler:^(NSArray *scores, NSError *error){
            if (error != nil) {
                NSLog(@"error : %@",error.localizedDescription);
            }
            else{
                
                [ICloudManager saveLocalPlayerHighScore:leaderboardRequest.localPlayerScore.value];
                //NSLog(@"local player High %ld",[ICloudManager getLocalPlayerHighScore]);
                
            }
        }];
    }
}
-(BOOL)adRemovalPurchased
{
    return [ICloudManager IsAdsRemovalPurchased];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:APP_WILL_RESIGN_ACTIVE_NOT object:nil];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
