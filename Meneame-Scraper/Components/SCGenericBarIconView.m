//
//  SCGenericBarIconView.m
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 2/3/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import "SCGenericBarIconView.h"

@interface SCGenericBarIconView ()

@property (nonatomic, assign) BOOL highlight;

@end

@implementation SCGenericBarIconView

+ (UIBarButtonItem *)barIconViewWithImage:(UIImage *)image size:(CGSize)size {
    
    SCGenericBarIconView *barIconView = [SCGenericBarIconView new];
    barIconView.frame = CGRectMake(0, 0, size.width, size.height);
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = barIconView.bounds;
    imageView.image = image;
    imageView.backgroundColor = [UIColor clearColor];
    [barIconView addSubview:imageView];
    
    return [[UIBarButtonItem alloc] initWithCustomView:barIconView];
}

#pragma mark - Setter

- (void)setHighlight:(BOOL)highlight {
    
    _highlight = highlight;
    
    self.alpha = highlight ? 0.6 : 1.0;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.highlight = YES;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGPoint touchLocation = [event.allTouches.anyObject locationInView:self];
    if (!CGRectContainsPoint(self.bounds, touchLocation)) {
        self.highlight = NO;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.highlight = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.highlight = NO;
}

@end
