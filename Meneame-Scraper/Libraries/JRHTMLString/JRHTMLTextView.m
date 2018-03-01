//
//  JRHTMLTextView.m
//  JRHTMLString
//
//  Created by Jacobo Rodriguez on 27/02/18.
//  Copyright © 2018 Jacobo Rodriguez. All rights reserved.
//

#import "JRHTMLTextView.h"

@interface JRHTMLTextView () <UITextViewDelegate>

@end

@implementation JRHTMLTextView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.editable = NO;
        self.selectable = YES;
        self.scrollEnabled = NO;
        self.delegate = self;
        self.textContainerInset = UIEdgeInsetsZero;
        self.textContainer.lineFragmentPadding = 0;
        self.dataDetectorTypes = UIDataDetectorTypeLink;
    }
    
    return self;
}

#pragma mark - Setter

- (void)setHtmlString:(JRHTMLString *)htmlString {
    
    _htmlString = htmlString;
    
    self.linkTextAttributes = @{NSForegroundColorAttributeName: htmlString.hiperlinkColor,
                                NSUnderlineStyleAttributeName: htmlString.hiperlinkLine ? @(NSUnderlineStyleSingle) : @(NSUnderlineStyleNone)
                                };
    
    self.textContainerInset = htmlString.padding;
    
    self.attributedText = htmlString.attributedString;

}

//- (void)layoutSubviews {
//
//    [super layoutSubviews];
//
//    NSLog(@"%@", self);
//
//    if (!CGSizeEqualToSize(self.bounds.size, self.intrinsicContentSize)) {
//        [self invalidateIntrinsicContentSize];
//    }
//}

#pragma mark - Overide

- (CGSize)intrinsicContentSize {

    CGSize size = [super intrinsicContentSize];

    if (size.height == UIViewNoIntrinsicMetric) {
        [self.layoutManager glyphRangeForTextContainer:self.textContainer];
        size.height = [self.layoutManager usedRectForTextContainer:self.textContainer].size.height; //+ textContainerInset.top + textContainerInset.bottom
    }

    if (self.maxHeight > 0.0 && size.height > self.maxHeight) {
        size.height = self.maxHeight;

        if (!self.scrollEnabled) {
            self.scrollEnabled = YES;
        }
    } else if (self.scrollEnabled) {
        self.scrollEnabled = NO;
    }

    return size;
}

- (BOOL)becomeFirstResponder {
    
    return NO;
}

- (BOOL)canBecomeFirstResponder {
    
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}

#pragma mark - UITextView Delegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(nonnull NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
//    if ([URL.scheme isEqualToString:@"http"] || [URL.scheme isEqualToString:@"https"]) {
//        return YES;
//    }
    
//    if ([URL.scheme isEqualToString:@"applewebdata"]) {
//        NSString *commentNum = [URL.absoluteString substringFromString:@"#c-" toString:nil];
//        NSLog(@"Comment Num %@", commentNum);
//        return NO;
//    }
//
//    return YES;
    
    if (self.linkDelegate && [self.linkDelegate respondsToSelector:@selector(htmlTextView:didPressLink:)]) {
        [self.linkDelegate htmlTextView:self didPressLink:URL];
        return NO;
    }
    
    return YES;
}

@end
