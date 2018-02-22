//
//  SCScraperManager.m
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 20/2/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import "SCScraperManager.h"
#import "SCScraperWebManager.h"
#import "SCNewsVO.h"
#import "AFNetworking.h"

@interface SCScraperManager ()

@property (nonatomic, strong) SCScraperWebManager *webScraper;

@end

@implementation SCScraperManager

+ (instancetype)sharedManager {
    
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        //NSString *userAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36";
        //[[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent": userAgent}];
        _webScraper = [SCScraperWebManager new];
    }
    return self;
}

#pragma mark - User

- (void)loginWithUsername:(NSString *)userName password:(NSString *)password completion:(void(^)(NSDictionary *user, NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:@"https://www.meneame.net/login"];
    NSDictionary *params = @{@"username": userName,
                             @"password": password,
                             @"login": @"",
                             @"processlogin": @"1",
                             @"return": @"/",
                             @"persistent": @"on"};

    [self.webScraper post:url params:params completion:^(NSString *sourceCode, NSError *error) {
        
        NSString *userInfo = [sourceCode substringFromString:@"<ul id=\"userinfo\">" toString:@"</ul>"];
        
        NSDictionary *user;
        if (![userInfo containsString:@">login<"] && ![userInfo containsString:@">registrarse<"]) {
            user = @{@"name": [userInfo substringFromString:@"<a href=\"/user/" toString:@"\""],
                     @"image": [userInfo substringFromString:@"data-src=\"" toString:@"\""]
                     };
        }
        
        if (completion) {
            completion(user, error);
        }
    }];
}

- (void)logoutWithcompletion:(void(^)(BOOL result, NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:@"https://www.meneame.net/login"];
    NSDictionary *params = @{@"op": @"logout", @"return": @"/"};
    
    [self.webScraper post:url params:params completion:^(NSString *sourceCode, NSError *error) {
        
        //Delete all Cookies
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in cookieStorage.cookies) {
            [cookieStorage deleteCookie:cookie];
        }
        
        if (completion) {
            completion(YES, error);
        }
    }];
}

#pragma mark - News

- (void)newsFromPage:(NSInteger)page completion:(void(^)(NSDictionary *newsList, NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:@"https://www.meneame.net/"];
    NSDictionary *params = @{@"page": @(page)};
    
    [self.webScraper get:url params:params completion:^(NSString *sourceCode, NSError *error) {

        NSArray *news = [SCNewsVO newsFromSourceCode:sourceCode];

        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"page": @(page), @"elements": news}];
        [dictionary addEntriesFromDictionary:[self getWebInfoFromSourceCode:sourceCode]];
        
        if (completion) {
            completion(dictionary, error);
        }
    }];
}

- (void)userNewsWithUserId:(NSString *)userId completion:(void(^)(NSDictionary *newsList, NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.meneame.net/user/%@/favorites#menu", userId]];
    
    [self.webScraper get:url params:nil completion:^(NSString *sourceCode, NSError *error) {
        
        NSArray *news = [SCNewsVO newsFromSourceCode:sourceCode];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"section": @"user_favorites", @"elements": news}];
        [dictionary addEntriesFromDictionary:[self getWebInfoFromSourceCode:sourceCode]];
        
        if (completion) {
            completion(dictionary, error);
        }
    }];
}

#pragma mark - Notifications

- (void)notificationsWithCompletion:(void(^)(NSDictionary *notifications, NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:@"https://www.meneame.net/backend/notifications.json"];
    NSDictionary *params = @{@"check": @(1), @"has_focus": @"true"};
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [sessionManager GET:url.absoluteString parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (completion) {
            completion(responseObject, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (completion) {
            completion(nil, error);
        }
    }];
}

#pragma mark - Search

- (void)search:(NSString *)string completion:(void(^)(NSDictionary *data, NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:@"https://www.meneame.net/search"];
    NSDictionary *params = @{@"q": string,
                             @"w": @"links",
                             @"p": @"",
                             @"s": @"",
                             @"h": @"",
                             @"o": @"",
                             @"u": @""
                             };
    
    [self.webScraper get:url params:params completion:^(NSString *sourceCode, NSError *error) {
        
        NSArray *news = [SCNewsVO newsFromSourceCode:sourceCode];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"page": @(1), @"elements": news}];
        [dictionary addEntriesFromDictionary:[self getWebInfoFromSourceCode:sourceCode]];
        
        if (completion) {
            completion(dictionary, error);
        }
    }];
}

#pragma mark - Preferences

- (void)showOnlyMySubs:(BOOL)show userId:(NSString *)userId controlKey:(NSString *)controlKey completion:(void(^)(NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:@"https://www.meneame.net/backend/pref"];
    NSDictionary *params = @{@"id": userId,
                             @"value": show ? @"1" : @"0",
                             @"key": @"subs_default",
                             @"set": @"1",
                             @"control_key": controlKey
                             };
    
    [self.webScraper post:url params:params completion:^(NSString *sourceCode, NSError *error) {
        
        if (completion) {
            completion(error);
        }
    }];
}

#pragma mark - Utils

- (NSDictionary *)getWebInfoFromSourceCode:(NSString *)sourceCode {
    
    NSString *infoString = [sourceCode substringFromString:@"base_key" toString:@"}"];
    NSString *infoUser = [sourceCode substringFromString:@"<ul id=\"userinfo\">" toString:@"</ul>"];
    BOOL subsChecked = [sourceCode containsString:@"<input id=\"subs_default_header\" name=\"subs_default\" value=\"subs_default\" type=\"checkbox\" checked=\"\">"];
    
    NSDictionary *infoDict = @{@"base_key": [infoString substringFromString:@"\"" toString:@"\""],
                               @"link_id": [infoString substringFromString:@"link_id = " toString:@","],
                               @"base_url_sub": [infoString substringFromString:@"base_url_sub=\"" toString:@"\""],
                               @"user": @{@"user_login": [infoString substringFromString:@"user_login='" toString:@"'"],
                                          @"user_image": [infoUser substringFromString:@"<img id=\"avatar\" src=\"" toString:@"\""],
                                          @"user_id": [infoString substringFromString:@"user_id=" toString:@","]
                                          },
                               @"subs_default": subsChecked ? @(YES) : @(NO)
                               };
    
    return infoDict;
}

@end
