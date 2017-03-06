//
//  UIWebView+Utils.h
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 20/2/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Utils)

@property (nonatomic, strong, readonly) NSString *sourceCode;

- (NSString *)getElementById:(NSString *)elementId;
- (NSString *)getElementById:(NSString *)elementId attribute:(NSString *)attribute;
- (NSString *)getElementById:(NSString *)elementId attribute:(NSString *)attribute index:(NSInteger)index;
- (NSString *)getElementByClassName:(NSString *)className index:(NSInteger)index;
- (NSString *)getElementByClassName:(NSString *)className index:(NSInteger)index attribute:(NSString *)attribute;
- (NSArray *)getElementsByClassName:(NSString *)className;
- (NSArray *)getElementsByTagName:(NSString *)tagName;
- (NSArray *)getElementsByTagNames:(NSArray *)tagNames;

@end
