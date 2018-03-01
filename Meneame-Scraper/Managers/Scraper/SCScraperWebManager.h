//
//  SCScraperWebManager.h
//  Meneame
//
//  Created by Jacobo Rodriguez on 1/3/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SourceCodeHandler)(UIWebView *webView, NSError *error);

@interface SCScraperWebManager : NSObject

- (void)get:(NSURL *)url params:(NSDictionary *)params completion:(SourceCodeHandler)completion;
- (void)post:(NSURL *)url params:(NSDictionary *)params completion:(SourceCodeHandler)completion;

- (void)sourceCodeFromUrl:(NSURL *)url completion:(SourceCodeHandler)completion;
    
@end
