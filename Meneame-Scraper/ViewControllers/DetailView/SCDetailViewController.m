//
//  SCDetailViewController.m
//  Meneame-Scraper
//
//  Created by Jacobo Rodriguez on 22/02/18.
//  Copyright © 2018 Jacobo Rodriguez. All rights reserved.
//

#import "SCDetailViewController.h"

#import "SCNewsVO.h"

@interface SCDetailViewController ()

@property (nonatomic, strong) SCNewsVO *news;

@end

@implementation SCDetailViewController

@dynamic view;

- (instancetype)initWithNews:(SCNewsVO *)news {
    
    self = [super init];
    if (self) {
        _news = news;
    }
    
    return self;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)loadView {
    
    self.view = [SCDetailView new];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Comentarios";
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
