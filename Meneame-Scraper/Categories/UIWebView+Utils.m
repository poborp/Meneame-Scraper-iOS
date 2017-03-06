//
//  UIWebView+Utils.m
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 20/2/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import "UIWebView+Utils.h"

@implementation UIWebView (Utils)

#pragma mark - Getter

- (NSString *)sourceCode {
    
    return [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML;"];
}

#pragma mark - Public

- (NSString *)getElementById:(NSString *)elementId {
    
    return [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').innerHTML;", elementId]];
}

- (NSString *)getElementById:(NSString *)elementId attribute:(NSString *)attribute {
    
    return [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@').%@;", elementId, attribute]];
}

- (NSString *)getElementById:(NSString *)elementId attribute:(NSString *)attribute index:(NSInteger)index {
    
    return [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('%@')[%li].%@;", elementId, (long)index, attribute]];
}

- (NSString *)getElementByClassName:(NSString *)className index:(NSInteger)index {
    
    return [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByClassName('%@')[%li].innerHTML;", className, (long)index]];
}

- (NSString *)getElementByClassName:(NSString *)className index:(NSInteger)index attribute:(NSString *)attribute {
    
    return [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByClassName('%@')[%li].%@;", className, (long)index, attribute]];
}

- (NSArray *)getElementsByClassName:(NSString *)className {
    
    NSMutableArray *elements = [NSMutableArray new];
    
    NSInteger count = [[self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByClassName('%@').length;", className]] integerValue];
    for (int i=0; i<count; i++) {
        [elements addObject:[self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByClassName('%@')[%i].innerHTML;", className, i]]];
    }
    
    return elements;
}

- (NSArray *)getElementsByTagName:(NSString *)tagName {
    
    NSMutableArray *elements = [NSMutableArray new];
    
    NSInteger count = [[self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('%@').length;", tagName]] integerValue];
    for (int i=0; i<count; i++) {
        [elements addObject:[self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('%@')[%i].innerHTML;", tagName, i]]];
    }
    
    return elements;
}

- (NSArray *)getElementsByTagNames:(NSArray *)tagNames {
    
    NSArray *array = [self getElementsByTagNames:tagNames path:@"document"];
    
    return array;
}

- (NSArray *)getElementsByTagNames:(NSArray *)tagNames path:(NSString *)path {
    
    NSMutableArray *elements = [NSMutableArray new];
    
    path = [path stringByAppendingString:[NSString stringWithFormat:@".getElementsByTagName('%@')", tagNames.firstObject]];
    
    NSInteger numberOfTags = [[self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.length;", path]] integerValue];
    for (int i=0; i<numberOfTags; i++) {
        if (tagNames.count > 1) {
            NSArray *array = [tagNames subarrayWithRange:NSMakeRange(1, tagNames.count-1)];
            [elements addObjectsFromArray:[self getElementsByTagNames:array path:[NSString stringWithFormat:@"%@[%i]", path, i]]];
        } else {
            NSString *innerHTML = [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@[%i].innerHTML;", path, i]];
            innerHTML = [innerHTML stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [elements addObject:innerHTML];
        }
    }
    
    return elements;
}

@end
