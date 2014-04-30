//
//  YQViewController.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/26/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "YQViewController.h"
#import "YQMyScene.h"

@implementation YQViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    // self.screenName = @"Game View";
    
    if([self hasFourInchDisplay])
    {
        paymentObserver = [[MDPaymentTransactionObserver alloc] init];
        paymentObserver.delegate = self;
        [[SKPaymentQueue defaultQueue] addTransactionObserver:paymentObserver];
    }
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    // Create and configure the scene.
    FromRighttransition = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.3];
    FromLefttransition = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.3];
    
    
    MainMenuScene = [YQMainMenu sceneWithSize:skView.bounds.size];
    MainMenuScene.scaleMode = SKSceneScaleModeAspectFill;
    MainMenuScene.viewController = self;
    
    gameScene = [YQMyScene sceneWithSize:skView.bounds.size];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    gameScene.viewController = self;
    // Present the scene.
    
    currentScene curr = [self lastScene];
    if(curr == currentSceneGame)
    {
        GameEntity *ResumedGame = [PersistentStore getLastGame];
        if(!ResumedGame.graph)
        {
            [self presentMenuSceneAnimated:NO];
        }else
        {
            [self resumeGameAnimated:NO withGame:ResumedGame];
        }
        
        
    }else
    {
        [self presentMenuSceneAnimated:NO];
    }
    
    
    
    
    
    
    
    
    UIImage *buttonImage = [[UIImage imageNamed:@"greyButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"greyButtonHighlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    [howToBtn setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [howToBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    [newBtn setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [newBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    [highScoreBtn setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [highScoreBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    [ResumBtn setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [ResumBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    
    [removeAdsBtn setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [removeAdsBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    

    if(![self adRemovalPurchased])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAds) name:PURCHASE_SUCCEEDED_NOTIFICATION object:nil];
        
        [self loadNewAd];
    }
}
-(currentScene)lastScene
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"lastScene"];
}
-(void)setLastScene:(currentScene)lastScene
{
    [[NSUserDefaults standardUserDefaults] setInteger:lastScene forKey:@"lastScene"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    BOOL adRemovalPurchased = [self adRemovalPurchased];
    
    if(adRemovalPurchased)
    {
        removeAdsBtn.hidden = YES;
        removeAdsBtn.enabled = NO;
    }else
    {
        removeAdsBtn.hidden = NO;
        removeAdsBtn.enabled = YES;
    }
    
    if(![self hasFourInchDisplay])
    {
        removeAdsBtn.hidden = YES;
        removeAdsBtn.enabled = NO;
    }
    
    GameEntity *ResumedGame = [PersistentStore getLastGame];
    if(!ResumedGame)
    {
        ResumBtn.enabled = NO;
    }else
    {
        ResumBtn.enabled = YES;
    }
}
-(void)transactionFinished
{
    
}
-(void)transactionSucceeded
{
    [self stopAnimating];
    
    removeAdsBtn.hidden = YES;
    removeAdsBtn.enabled = NO;
}
-(void)transactionFailed
{
    [self stopAnimating];
}
-(BOOL)adRemovalPurchased
{
    return [ICloudManager IsAdsRemovalPurchased];
}
-(void)loadNewAd
{
    
    if(![self hasFourInchDisplay])
    {
        return;
    }
    /*if (bannerView_ == nil) {
        bannerView_ = [[STABannerView alloc] initWithSize:STA_AutoAdSize autoOrigin:STAAdOrigin_Bottom
                                                 withView:self.view withDelegate:nil];
        [self.view addSubview:bannerView_];
    }*/
    bannerView_ = [[RevMobAds session] bannerView];
    bannerView_.frame = CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 50);
    [self.view addSubview:bannerView_];
    
    bannerView_.delegate = self;
    [bannerView_ loadAd];
}
-(void)revmobAdDidReceive
{

}
-(void)revmobAdDidFailWithError:(NSError *)error
{
    [bannerView_ loadAd];
}
-(void)revmobUserClickedInTheAd
{
    
}
-(void)revmobUserClosedTheAd
{
    
}
-(void)installDidReceive
{
    
}
-(void)installDidFail
{
    
}
-(void)removeAds
{
    [bannerView_ removeFromSuperview];
}
- (BOOL)hasFourInchDisplay {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}
-(IBAction)newGame:(id)sender
{
    
    [self newGameAnimated:YES];
    
}
-(void)newGameAnimated:(BOOL)animated
{
    [self setLastScene:currentSceneGame];
    
    gameScene.IsResumedGame = NO;
    
    
    if(!animated)
    {
        [((SKView*) self.view) presentScene:gameScene];
         [gameScene ReloadNewGame];
        menuView.alpha = 0.0;
        return;
    }
    
    [((SKView*) self.view) presentScene:gameScene transition:FromRighttransition];
    
    [gameScene ReloadNewGame];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        menuView.alpha = 0.0;
        
    } completion:nil];
}
-(void)GameCenterAction:(id)sender
{
    if((floorf([[UIDevice currentDevice] systemVersion].floatValue))>=6)
    {
        GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
        if (gameCenterController != nil)
        {
            gameCenterController.gameCenterDelegate = self;
            [self presentViewController: gameCenterController animated: YES completion:nil];
        }
    }else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"gamecenter:"]];
        
    }
}
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)resumeGame:(id)sender
{
   
    GameEntity *ResumedGame = [PersistentStore getLastGame];
    if(!ResumedGame.graph)
    {
        return;
    }
    [self resumeGameAnimated:YES withGame:ResumedGame];
}
-(void)resumeGameAnimated:(BOOL)animated withGame:(GameEntity*)ResumedGame
{
    
     [self setLastScene:currentSceneGame];
    
    currentSceneType = currentSceneGame;
    
    if(!animated)
    {
        [((SKView*) self.view) presentScene:gameScene];
        [gameScene reloadGame:ResumedGame];
        menuView.alpha = 0.0;
        return;
    }
    
    [((SKView*) self.view) presentScene:gameScene transition:FromRighttransition];
    [gameScene reloadGame:ResumedGame];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        menuView.alpha = 0.0;
        
    } completion:nil];
    
}
-(void)quitGameScene
{
    [self presentMenuSceneAnimated:YES];
}
-(void)presentMenuSceneAnimated:(BOOL)animated
{
     [self setLastScene:currentSceneMenu];
    
    
    
    if(!animated)
    {
        [((SKView*) self.view) presentScene:MainMenuScene];
        menuView.alpha = 1.0;
        return;
    }
    [((SKView*) self.view) presentScene:MainMenuScene transition:FromLefttransition];
    
    [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
        
        menuView.alpha = 1.0;
        
    } completion:nil];
}
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
-(IBAction)RemoveAdsAction:(id)sender
{
    [self validateProductIdentifiers];
}


-(void)purchase
{
    if(self.appStoreProducts.count == 0 )
    {
        return;
    }
    SKProduct *product = [self.appStoreProducts objectAtIndex:0];
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
    payment.quantity = 1;
    
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

//************************************************************************************************************
//************************************************************************************************************



//******************************** Validate And retrieve Product Info From App Store*********************************
//************************************************************************************************************
- (void)validateProductIdentifiers
{
    [self startAnimating];
    NSArray *Ids = [NSArray arrayWithObject:PRODUCT_ID];
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
                                          initWithProductIdentifiers:[NSSet setWithArray:Ids]];
    productsRequest.delegate = self;
    [productsRequest start];
}
- (void)productsRequest:(SKProductsRequest *)request
     didReceiveResponse:(SKProductsResponse *)response
{
    self.appStoreProducts = response.products;
    
    BOOL productValid = YES;
    
    for (NSString *invalidIdentifier in response.invalidProductIdentifiers) {
        if([invalidIdentifier isEqualToString:PRODUCT_ID])
        {
            productValid = NO;
        }
    }
    
    if(productValid)
    {
        [self purchase];
    }
    
}
//************************************************************************************************************
//************************************************************************************************************





@end
