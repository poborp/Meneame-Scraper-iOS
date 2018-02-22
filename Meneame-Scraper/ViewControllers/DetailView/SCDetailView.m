//
//  SCDetailView.m
//  Meneame-Scraper
//
//  Created by Jacobo Rodriguez on 22/02/18.
//  Copyright © 2018 Jacobo Rodriguez. All rights reserved.
//

#import "SCDetailView.h"

@interface SCDetailView ()

@end

@implementation SCDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addCustomConstraints];
    }
    
    return self;
}

- (void)addCustomConstraints {
    
//    NSDictionary *metrics = @{};
//    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(<#object#>);
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[<#object#>]|" options:0 metrics:metrics views:dictionaryView]];
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[<#object#>]|" options:0 metrics:metrics views:dictionaryView]];
}

@end
