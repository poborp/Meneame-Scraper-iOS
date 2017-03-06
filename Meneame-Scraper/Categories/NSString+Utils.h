//
//  NSString+Utils.h
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 21/2/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (NSString *)substringFromString:(NSString *)from toString:(NSString *)to;
- (NSString *)substringFromString:(NSString *)from toString:(NSString *)to index:(NSInteger)index;
- (BOOL)containsSubstring:(NSString *)substring;

@end
