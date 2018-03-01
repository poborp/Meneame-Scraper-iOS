//
//  JRHTMLTextView.h
//  JRHTMLString
//
//  Created by Jacobo Rodriguez on 27/02/18.
//  Copyright © 2018 Jacobo Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRHTMLString.h"

@class JRHTMLTextView;

@protocol JRHTMLTextViewDelegate <NSObject>
- (void)htmlTextView:(JRHTMLTextView *)htmlTextView didPressLink:(NSURL *)link;
@end

@interface JRHTMLTextView : UITextView

@property (nonatomic, weak) id<JRHTMLTextViewDelegate> linkDelegate;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, strong) JRHTMLString *htmlString;

@end
