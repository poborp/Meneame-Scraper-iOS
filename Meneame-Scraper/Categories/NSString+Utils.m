//
//  NSString+Utils.m
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 21/2/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (NSString *)substringFromString:(NSString *)from toString:(NSString *)to {
    
    NSString *stringResult = @"";
    
    if (from == nil && to == nil) {
        stringResult = @"";
    } else if (from == nil) {
        NSRange range = [self rangeOfString:to options:NSLiteralSearch];
        if (range.length != 0) {
            stringResult = [self substringToIndex:range.location];
        }
    } else if (to == nil) {
        NSRange range = [self rangeOfString:from options:NSLiteralSearch];
        if (range.length != 0) {
            stringResult = [self substringFromIndex:range.location + range.length];
        }
    } else {
        NSRange range = [self rangeOfString:from options:NSLiteralSearch];
        if (range.length != 0) {
            stringResult = [self substringFromIndex:range.location + range.length];
            range = [stringResult rangeOfString:to options:NSLiteralSearch];
            if (range.length != 0) {
                stringResult = [stringResult substringToIndex:range.location];
            }
        }
    }
    
    return stringResult;
}

- (NSString *)substringFromString:(NSString *)from toString:(NSString *)to index:(NSInteger)index {
    
    NSString *returnString = @"";
    
    NSArray *ocurrences = [self componentsSeparatedByString:from];
    for (NSString *ocurrence in ocurrences) {
        if (ocurrence != ocurrences.firstObject && [ocurrences indexOfObject:ocurrence] == index+1) {
            returnString = [ocurrence substringFromString:nil toString:to];
        }
    }
    
    return returnString;
}

- (BOOL)containsSubstring:(NSString *)substring {
    
    NSRange range = [self rangeOfString:substring options:NSLiteralSearch];
    if (range.location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}

@end
