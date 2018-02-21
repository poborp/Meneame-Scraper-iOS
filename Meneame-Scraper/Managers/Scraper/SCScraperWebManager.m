//
//  SCScraperWebManager.m
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 1/3/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import "SCScraperWebManager.h"

#import "UIWebView+Utils.h"

#import "AFNetworking.h"

@interface SCScraperWebManager () <UIWebViewDelegate>

@property (nonatomic, strong) SourceCodeHandler sourceCodeHandler;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

@end

@implementation SCScraperWebManager

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _cachePolicy = NSURLRequestUseProtocolCachePolicy;
        
        _webView = [UIWebView new];
        _webView.frame = [UIScreen mainScreen].bounds;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.delegate = self;
        _webView.alpha = 0.0;
        _webView.userInteractionEnabled = NO;
        [[UIApplication sharedApplication].keyWindow addSubview:_webView];
    }
    return self;
}

#pragma mark - Public

- (void)get:(NSURL *)url params:(NSDictionary *)params completion:(SourceCodeHandler)completion {
    
    _sourceCodeHandler = completion;
    
    NSString *postParamsString = @"";
    for (NSString *key in params.allKeys) {
        postParamsString = [postParamsString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", key, params[key]]];
    }
    
    NSURL *urlWithParams = [url URLByAppendingPathComponent:[NSString stringWithFormat:@"?%@", postParamsString]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlWithParams cachePolicy:self.cachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request addValue:@"1" forHTTPHeaderField:@"Upgrade-Insecure-Requests"];
    
    [self.webView loadRequest:request];
}

- (void)post:(NSURL *)url params:(NSDictionary *)params completion:(SourceCodeHandler)completion {
    
    _sourceCodeHandler = completion;
    
    NSString *postParamsString = @"";
    for (NSString *key in params.allKeys) {
        postParamsString = [postParamsString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", key, params[key]]];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:self.cachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postParamsString dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request addValue:@"1" forHTTPHeaderField:@"Upgrade-Insecure-Requests"];
    
    [self.webView loadRequest:request];
}

- (void)sourceCodeFromUrl:(NSURL *)url completion:(SourceCodeHandler)completion {
    
    _sourceCodeHandler = completion;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //NSLog(@"[WebScraper] Should start load with request \"%@\" (navType %li)", request.URL.absoluteString, navigationType);
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    //NSLog(@"[WebScraper] Did start load \"%@\"", webView.request.URL.absoluteString);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //NSLog(@"[WebScraper] Did finish load \"%@\"", webView.request.URL.absoluteString);
    
    if (!webView.loading) {
        if (self.sourceCodeHandler) {
            self.sourceCodeHandler(self.webView.sourceCode, nil);
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    //NSLog(@"[WebScraper] Error: %@", error.description);
    
    if (!webView.loading) {
        if (self.sourceCodeHandler) {
            self.sourceCodeHandler(self.webView.sourceCode, error);
        }
    }
}

@end
