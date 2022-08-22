//
//  Lokalise.h
//  Lokalise
//
//  Created by Fjodors Levkins on 20/05/15.
//  Copyright (c) 2015 Lokalise SIA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LokaliseErrors.h"
#import "LokaliseLocalizationType.h"

@protocol LokaliseDelegate;

extern NSString *__nonnull LokaliseFrameworkVersion;
extern NSString *__nonnull LokaliseDidUpdateLocalizationNotification;

@interface Lokalise : NSObject

@property (class, readonly, strong) Lokalise *__nonnull sharedObject NS_SWIFT_NAME(shared);

/**
 Lokalise SDK token.
 */
@property (strong, nonatomic, readonly, nullable) NSString *token;

/**
 Lokalise Project ID.
 */
@property (strong, nonatomic, readonly, nullable) NSString *projectID;

/**
 Set api token and project ID.
 
 @param projectID Project ID.
 @param token Lokalise SDK token.
 */
- (void)setProjectID:(NSString *__nonnull)projectID token:(NSString *__nonnull)token;

/**
 Set api token and project ID.

 @param apiToken Lokalise API Token.
 @param projectID Project ID.
 @deprecated Use [Lokalise.sharedObject setProjectId:projectId token:token]
 */
- (void)setAPIToken:(NSString *__nonnull)apiToken projectID:(NSString *__nonnull)projectID __deprecated_msg("Use [Lokalise.sharedObject setProjectId:projectId token:token]");

/**
 Currently selected localization locale.
 */
@property (strong, nonatomic, readonly, nonnull) NSLocale *localizationLocale;

/**
 @return NSArray of NSLocale objects. Always has at least one locale.
 */
- (NSArray <NSLocale *> *__nonnull)availableLocales;

/**
 Sets localization locale which will be available right away.
 Can be set only to one of available locales.

 @param localizationLocale Locale from availableLocales array.
 @param makeDefault Application will remember selected locale if set to true.
 @param completionBlock Completion block where error is nil if locale is set.
 */
- (void)setLocalizationLocale:(NSLocale *__nonnull)localizationLocale makeDefault:(BOOL)makeDefault completion:(void (^__nullable)(NSError *__nullable error))completionBlock;

/**
 Current bundle version. 0 if bundle is not loaded or downloaded.
 */
@property (nonatomic, readonly) NSInteger lokaliseBundleVersion;

/**
 Determines what source is used for localization.
 Set to `LokaliseLocalizationRelease` by default.
 */
@property (nonatomic) LokaliseLocalizationType localizationType;

/**
 
 This method returns the following when key is nil or not found in table:
 
 - If key is nil and value is nil, returns an empty string.

 - If key is nil and value is non-nil, returns value.

 - If key is not found and value is nil or an empty string, returns key.

 - If key is not found and value is non-nil and not empty, return value.

 @param key   The key for a string in the table identified by tableName.
 @param value The value to return if key is nil or if a localized string for key can’t be found in the table.
 @param tableName The receiver’s string table to search. If tableName is nil or is an empty string, the method attempts to use the table in Localizable.strings.

 @return A localized version of the string designated by key in table tableName.
 */
- (NSString *__nonnull)localizedStringForKey:(NSString *__nonnull)key value:(NSString *__nullable)value table:(NSString *__nullable)tableName NS_FORMAT_ARGUMENT(1);

/**
 Check if new localization version is available and downloads it.

 @param completionBlock Completion block where  parameter `updated` is set to true if new bundle was downloaded and `error` which provides details if something went wrong.
 */
- (void)checkForUpdatesWithCompletion:(void (^__nullable)(BOOL updated, NSError *__nullable error))completionBlock;

/**
Deletes all files downloaded by lokalise framework.
 */
- (void)deleteLokaliseData;

/**
 Forces [[NSBundle mainBundle] localizedStringForKey:key value:value table:tableName] to use [[Lokalise shareObject] localizedStringForKey:key value:value table:tableName].
 */
- (void)swizzleMainBundle;

/**
 Deswizzles [[NSBundle mainBundle] localizedStringForKey:key value:value table:tableName].
 */
- (void)deswizzleMainBundle;

@end
