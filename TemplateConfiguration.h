//
//  TemplateConfiguration.h
//  YouQue
//
//  Created by Mohammed Eldehairy on 5/6/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#define STRAWBERRY_IMAGE_KEY @"strawbery-image"
#define ORANGE_IMAGE_KEY @"orange-image"
#define APPLE_IMAGE_KEY @"apple-image"
#define WATERMELON_IMAGE_KEY @"watermelon-image"
#define BLUEBERRY_IMAGE_KEY @"blueberry-image"
#define EMPTY_CELL_IMAGE_KEY @"empty-cell-image"
#define BACKGROUND_IMAGE_KEY @"background-image"
#define TARGET_IMAGE_KEY @"target-image"
#define PROGRESS_PIE_FILL_IMAGE_KEY @"progressPie-fill-image"
#define PROGRESS_PIE_BACKGROUND_IMAGE_KEY @"progressPie-back-image"
#define UNDO_IMAGE_KEY @"undo-image"
#define PAUSE_IMAGE_KEY @"pause-image"
#define MAIN_MENU_BUTTON_NORMAL_IMAGE_KEY @"main-menu-button-image-noraml"
#define MAIN_MENU_BUTTON_HIGHLIGHTED_IMAGE_KEY @"main-menu-button-image-highlighted"
#define GOOGLE_ANALYTICS_TRACKER_ID_KEY @"googleAnalytics-tracker-id"
#define REVMOB_APP_ID_KEY @"RevMob-App-id"
@interface TemplateConfiguration : NSObject
{
    NSDictionary *configDictionary;
}
+(TemplateConfiguration*)sharedInstance;
-(NSString*)valueForKey:(NSString*)key;
@end
