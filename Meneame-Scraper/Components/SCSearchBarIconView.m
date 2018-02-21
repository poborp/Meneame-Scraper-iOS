//
//  SCSearchBarIconView.m
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 2/3/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import "SCSearchBarIconView.h"

@interface SCSearchBarIconView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SCSearchBarIconView

- (instancetype)init {
    
    self = [super initWithFrame:CGRectMake(0, 0, 40, 30)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _imageView = [UIImageView new];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.userInteractionEnabled = NO;
        _imageView.image = [UIImage imageNamed:@"search-icon"];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        [self addCustomConstraints];
    }
    return self;
}

- (void)addCustomConstraints {
    
    NSDictionary *metrics = @{};
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_imageView);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView(26)]-5-|" options:0 metrics:metrics views:dictionaryView]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_imageView(26)]-2-|" options:0 metrics:metrics views:dictionaryView]];
}

#pragma mark - Getter

- (UIBarButtonItem *)barButtonItem {
    
    return [[UIBarButtonItem alloc] initWithCustomView:self];
}

@end
