//
//  YQViewController.h
//  YouQue
//

//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "YQMainMenu.h"
#import "YQMyScene.h"
#import "MDPaymentTransactionObserver.h"
#import "UIViewController+Loader.h"
#import <RevMobAds/RevMobAds.h>
#define PRODUCT_ID @"YouQueRemoveAds"
#import "GAITrackedViewController.h"
#import "EAIntroView.h"
#import "ALAlertBanner.h"
#define APP_LOADED_BEFORE_KEY @"app first load"
typedef enum
{
    currentSceneGame = 1,
    currentSceneMenu = 2
}currentScene;
@interface YQViewController : GAITrackedViewController<GKGameCenterControllerDelegate,SKProductsRequestDelegate,MDPaymentTransactionObserverDelegate,RevMobAdsDelegate>
{
    RevMobBannerView* bannerView_;
    
    YQMainMenu * MainMenuScene;
    YQMyScene *gameScene;
    
    
    
    
    SKTransition *FromRighttransition;
    SKTransition *FromLefttransition;
    
     UIView *menuView;
    
     UIButton *ResumBtn;
     UIButton *howToBtn;
     UIButton *newBtn;
     UIButton *highScoreBtn;
     UIButton *removeAdsBtn;
   IBOutlet  UIButton *inviteFriendsBtn;
    
    MDPaymentTransactionObserver *paymentObserver;
    
}
@property(nonatomic)currentScene currentSceneType;
@property(nonatomic,retain)NSArray *appStoreProducts;
-(IBAction)newGame:(id)sender;
-(IBAction)GameCenterAction:(id)sender;
-(IBAction)resumeGame:(id)sender;
-(void)quitGameScene;
-(IBAction)RemoveAdsAction:(id)sender;
-(IBAction)howToAction:(id)sender;
-(IBAction)inviteFriendsAction:(id)sender;
- (void) showBannerWithMessage:(NSString*)msg withTitle:(NSString*)title;
- (void) showNormalBannerWithMessage:(NSString*)msg withTitle:(NSString*)title;
@end
