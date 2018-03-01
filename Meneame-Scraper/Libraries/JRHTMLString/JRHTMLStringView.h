//
//  JRHTMLStringView.h
//  JRHTMLString
//
//  Created by Jacobo Rodriguez on 10/08/15.
//  Copyright © 2015 tBear Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JRHTMLString.h"

@interface JRHTMLStringView : UIView

@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, strong) JRHTMLString *htmlString;

@end

