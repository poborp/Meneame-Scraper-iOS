//
//  SCScraperManager.h
//  Meneame
//
//  Created by Jacobo Rodriguez on 20/2/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCRAPER [SCScraperManager sharedManager]

@interface SCScraperManager : NSObject

+ (instancetype)sharedManager;

- (void)loginWithUsername:(NSString *)userName password:(NSString *)password completion:(void(^)(NSDictionary *user, NSError *error))completion;
- (void)logoutWithcompletion:(void(^)(BOOL result, NSError *error))completion;

- (void)newsFromPage:(NSInteger)page completion:(void(^)(NSDictionary *newsList, NSError *error))completion;
- (void)newsDetailsWithNewsId:(NSString *)newsId completion:(void(^)(NSArray *commentsList, NSError *error))completion;

- (void)notificationsWithCompletion:(void(^)(NSDictionary *notifications, NSError *error))completion;
- (void)search:(NSString *)string completion:(void(^)(NSDictionary *data, NSError *error))completion;

- (void)showOnlyMySubs:(BOOL)show userId:(NSString *)userId controlKey:(NSString *)controlKey completion:(void(^)(NSError *error))completion;

- (void)userNewsWithUserId:(NSString *)userId completion:(void(^)(NSDictionary *newsList, NSError *error))completion;

@end
