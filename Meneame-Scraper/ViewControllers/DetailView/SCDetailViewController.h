//
//  SCDetailViewController.h
//  Meneame-Scraper
//
//  Created by Jacobo Rodriguez on 22/02/18.
//  Copyright © 2018 Jacobo Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCNewsVO;

@interface SCDetailViewController : UITableViewController

- (instancetype)initWithNews:(SCNewsVO *)news;

@end
