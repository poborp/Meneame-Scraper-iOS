//
//  JRHTMLStringView.h
//  JRHTMLString
//
//  Created by Jacobo Rodriguez on 10/08/15.
//  Copyright © 2015 tBear Software. All rights reserved.
//

#import "JRHTMLStringView.h"

@interface JRHTMLStringView () <UIWebViewDelegate>

@property (nonatomic, strong) NSLayoutConstraint *heightLayoutConstraint;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation JRHTMLStringView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _maxHeight = 0;
        
        _webView = [UIWebView new];
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
        _webView.backgroundColor = [UIColor clearColor];
        _webView.delegate = self;
        [self addSubview:_webView];
        
        [self addCustomConstraints];
    }
    
    return self;
}

- (void)addCustomConstraints {
    
    NSDictionary *metrics = @{};
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_webView);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_webView]|" options:0 metrics:metrics views:dictionaryView]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_webView]|" options:0 metrics:metrics views:dictionaryView]];
    
    _heightLayoutConstraint = [NSLayoutConstraint constraintWithItem:_webView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.0];
    [self addConstraint:_heightLayoutConstraint];
}

#pragma mark - Setter

- (void)setHtmlString:(JRHTMLString *)htmlString {
    
    _htmlString = htmlString;
    
    [self.webView loadHTMLString:htmlString.generatedHTML baseURL:nil];
}

#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        //[[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //NSString *offsetHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    NSString *clientHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight;"];
    NSInteger height = [clientHeight integerValue];
    
    if (height > self.maxHeight && self.maxHeight > 0) {
        _heightLayoutConstraint.constant = self.maxHeight;
        _webView.scrollView.scrollEnabled = YES;
        _webView.scrollView.bounces = YES;
    } else {
        _heightLayoutConstraint.constant = height;
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.bounces = NO;
    }
    
    [self layoutIfNeeded];
    [self.superview layoutIfNeeded];
}

@end
