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
#define FRUITS_5_ACHIEVEMENT_ID @"5fruits-achievement-id"
#define FRUITS_5_ACHIEVEMENT_TITLE @"5fruits-achievement-title"
#define FRUITS_6_ACHIEVEMENT_ID @"6fruits-achievement-id"
#define FRUITS_6_ACHIEVEMENT_TITLE @"6fruits-achievement-title"
#define FRUITS_7_ACHIEVEMENT_ID @"7fruits-achievement-id"
#define FRUITS_7_ACHIEVEMENT_TITLE @"7fruits-achievement-title"
#define COMBO_2X_ACHIEVEMENT_ID @"2xCombo-achievement-id"
#define COMBO_2X_ACHIEVEMENT_TITLE @"2xCombo-achievement-title"
#define COMBO_4X_ACHIEVEMENT_ID @"4xCombo-achievement-id"
#define COMBO_4X_ACHIEVEMENT_TITLE @"4xCombo-achievement-title"
#define COMBO_6X_ACHIEVEMENT_ID @"6xCombo-achievement-id"
#define COMBO_6X_ACHIEVEMENT_TITLE @"6xCombo-achievement-title"
#define COMBO_8X_ACHIEVEMENT_ID @"8xCombo-achievement-id"
#define COMBO_8X_ACHIEVEMENT_TITLE @"8xCombo-achievement-title"
#define COMBO_10X_ACHIEVEMENT_ID @"10xCombo-achievement-id"
#define COMBO_10X_ACHIEVEMENT_TITLE @"10xCombo-achievement-title"
#define LEVEL_2_REACHED_ACHIEVEMENT_ID @"level2Reached-achievement-id"
#define LEVEL_2_REACHED_ACHIEVEMENT_TITLE @"level2Reached-achievement-title"
#define LEVEL_3_REACHED_ACHIEVEMENT_ID @"level3Reached-achievement-id"
#define LEVEL_3_REACHED_ACHIEVEMENT_TITLE @"level3Reached-achievement-title"
#define LEVEL_4_REACHED_ACHIEVEMENT_ID @"level4Reached-achievement-id"
#define LEVEL_4_REACHED_ACHIEVEMENT_TITLE @"level4Reached-achievement-title"

#define YOUQUE_BEGINNER_ACHIEVEMENT_ID @"YouQueBeginner-achievement-id"
#define YOUQUE_BEGINNER_ACHIEVEMENT_TITLE @"YouQueBeginner-achievement-title"

#define YOUQUE_INTERMEDIATE_ACHIEVEMENT_ID @"YouQueIntermediate-achievement-id"
#define YOUQUE_INTERMEDIATE_ACHIEVEMENT_TITLE @"YouQueIntermediate-achievement-title"

#define YOUQUE_MASTER_ACHIEVEMENT_ID @"YouQueMaster-achievement-id"
#define YOUQUE_MASTER_ACHIEVEMENT_TITLE @"YouQueMaster-achievement-title"

#define YOUQUE_HARDCORE_ACHIEVEMENT_ID @"YouQueHardcore-achievement-id"
#define YOUQUE_HARDCORE_ACHIEVEMENT_TITLE @"YouQueHardcore-achievement-title"
@interface TemplateConfiguration : NSObject
{
    NSDictionary *configDictionary;
}
+(TemplateConfiguration*)sharedInstance;
-(NSString*)valueForKey:(NSString*)key;
@end
