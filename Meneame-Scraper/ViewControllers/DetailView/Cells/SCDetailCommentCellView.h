//
//  SCDetailCommentCellView.h
//  Meneame
//
//  Created by Jacobo Rodriguez on 26/02/18.
//  Copyright © 2018 Jacobo Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JRHTMLTextView.h"

@interface SCDetailCommentCellView : UITableViewCell

@property (nonatomic, strong) UILabel *numCommentLabel;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) JRHTMLTextView *textView;

@end
