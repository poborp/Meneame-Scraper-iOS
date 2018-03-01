//
//  JRHTMLString.h
//  JRHTMLString
//
//  Created by Jacobo Rodriguez on 10/08/15.
//  Copyright © 2015 tBear Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRHTMLString : NSObject

+ (instancetype)htmlWithContentString:(NSString *)contentString;
- (instancetype)initWithContentString:(NSString *)contentString;

@property (nonatomic, strong) NSString *contentString;

//Config
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) UIEdgeInsets padding;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) BOOL allowTextSelection;
@property (nonatomic, strong) UIColor *hiperlinkColor;
@property (nonatomic, assign) BOOL hiperlinkLine;
@property (nonatomic, assign) BOOL breakWord;
@property (nonatomic, assign) NSTextAlignment textAlignment;

//Result
@property (nonatomic, strong, readonly) NSString *generatedHTML;
@property (nonatomic, strong, readonly) NSAttributedString *attributedString;

@end
