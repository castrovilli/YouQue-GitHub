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
#import "STABannerView.h"
#import "MDPaymentTransactionObserver.h"
#import "UIViewController+Loader.h"
#define PRODUCT_ID @"YouQueRemoveAds"
typedef enum
{
    currentSceneGame = 1,
    currentSceneMenu = 2
}currentScene;
@interface YQViewController : UIViewController<GKGameCenterControllerDelegate,SKProductsRequestDelegate,MDPaymentTransactionObserverDelegate>
{
    STABannerView* bannerView_;
    
    YQMainMenu * MainMenuScene;
    YQMyScene *gameScene;
    
    currentScene currentSceneType;
    
    
    SKTransition *FromRighttransition;
    SKTransition *FromLefttransition;
    
    IBOutlet UIView *menuView;
    
    IBOutlet UIButton *ResumBtn;
    IBOutlet UIButton *howToBtn;
    IBOutlet UIButton *newBtn;
    IBOutlet UIButton *highScoreBtn;
    IBOutlet UIButton *removeAdsBtn;
    
    MDPaymentTransactionObserver *paymentObserver;
}
@property(nonatomic,retain)NSArray *appStoreProducts;
-(IBAction)newGame:(id)sender;
-(IBAction)GameCenterAction:(id)sender;
-(IBAction)resumeGame:(id)sender;
-(void)quitGameScene;
-(IBAction)RemoveAdsAction:(id)sender;
@end
