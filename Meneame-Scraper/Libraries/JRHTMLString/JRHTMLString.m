//
//  JRHTMLString.h
//  JRHTMLString
//
//  Created by Jacobo Rodriguez on 10/08/15.
//  Copyright © 2015 tBear Software. All rights reserved.
//

#import "JRHTMLString.h"

static NSString *const kHtmlFormat = @"<html><head><title>%@</title><style> body {padding-left:%fpx; padding-right:%fpx; padding-top:%fpx; padding-bottom:%fpx; margin: 0px; font-family:'%@'; font-size:%fpx; color:%@; word-break: %@; -webkit-user-select: %@; text-align:%@;} a {color:%@; text-decoration:%@;}</style></head><body>%@</body></html>";

@implementation JRHTMLString

+ (instancetype)htmlWithContentString:(NSString *)contentString {
    
    return [[JRHTMLString alloc] initWithContentString:contentString];
}

- (instancetype)initWithContentString:(NSString *)contentString {
    
    self = [self init];
    if (self) {
        _contentString = contentString;
    }
    
    return self;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _title = @"";
        _padding = UIEdgeInsetsMake(0, 0, 0, 0);
        _font = [UIFont systemFontOfSize:16];
        _textColor = [UIColor blackColor];
        _hiperlinkColor = [self colorWithHexString:@"0419bb" alpha:1.0];
        _hiperlinkColor = [UIColor redColor];
        _hiperlinkLine = YES;
        _allowTextSelection = NO;
        _breakWord = YES;
        _textAlignment = NSTextAlignmentLeft;
    }
    
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"<%@: %p; text = '%@'; html = '%@'>", NSStringFromClass([self class]), self, self.attributedString.string, self.generatedHTML];
}

#pragma mark - Getter

- (NSString *)generatedHTML {
    
    NSString *generatedHTML = [NSString stringWithFormat:kHtmlFormat, self.title ?: @"", self.padding.left, self.padding.right, self.padding.top, self.padding.bottom, self.font.fontName, self.font.pointSize, [self hexStringFromColor:self.textColor], self.breakWord ? @"break-word" : @"normal", self.allowTextSelection ? @"all" : @"none", [self buildTextAlignment], [self hexStringFromColor:self.hiperlinkColor], self.hiperlinkLine ? @"underline" : @"none", self.contentString];
    
    return generatedHTML ?: @"";
}

- (NSAttributedString *)attributedString {
    
    NSError *error = nil;
    NSDictionary *optionsDict = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding),
                                  NSFontAttributeName: self.font,
                                  NSForegroundColorAttributeName: self.textColor
                                  };
    NSData *data =  [self.generatedHTML dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:data options:optionsDict documentAttributes:nil error:&error];
    return attributedString;
}

#pragma mark - Private

- (NSString *)buildTextAlignment {
    
    if (self.textAlignment == NSTextAlignmentLeft) {
        return @"left";
    } else if (self.textAlignment == NSTextAlignmentCenter) {
        return @"center";
    } else if (self.textAlignment == NSTextAlignmentRight) {
        return @"right";
    } else if (self.textAlignment == NSTextAlignmentNatural) {
        return [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionLeftToRight ? @"left" : @"right";
    } else if (self.textAlignment == NSTextAlignmentJustified) {
        return @"justify";
    }
    
    return @"left";
}

#pragma mark - Utils

- (NSString *)hexStringFromColor:(UIColor *)color {
    
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[30] green:components[141] blue:components[13] alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(color.CGColor))[0]*255.0), (int)((CGColorGetComponents(color.CGColor))[1]*255.0), (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

- (UIColor *)colorWithHexString:(NSString *)hexString alpha:(float)alpha {
    
    uint hexValue;
    if ([[NSScanner scannerWithString:[hexString stringByReplacingOccurrencesOfString:@"#" withString:@"0x"]] scanHexInt:&hexValue]) {
        return [self colorWithHexValue:hexValue alpha:alpha];
    } else {
        return [UIColor blackColor];
    }
}

- (UIColor *)colorWithHexValue:(uint)hexValue alpha:(float)alpha {
    
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alpha];
}

@end
