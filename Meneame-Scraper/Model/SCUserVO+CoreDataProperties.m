//
//  SCUserVO+CoreDataProperties.m
//  Meneame-Scraper
//
//  Created by Jacobo Rodriguez on 6/3/17.
//  Copyright © 2017 Jacobo Rodriguez. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "SCUserVO+CoreDataProperties.h"

@implementation SCUserVO (CoreDataProperties)

+ (NSFetchRequest<SCUserVO *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SCUserVO"];
}

@dynamic bio;
@dynamic email;
@dynamic imageUrl;
@dynamic name;
@dynamic userName;
@dynamic webpage;
@dynamic comments;
@dynamic votes;

@end
