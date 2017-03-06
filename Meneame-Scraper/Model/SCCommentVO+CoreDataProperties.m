//
//  SCCommentVO+CoreDataProperties.m
//  Meneame-Scraper
//
//  Created by Jacobo Rodriguez on 6/3/17.
//  Copyright © 2017 Jacobo Rodriguez. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "SCCommentVO+CoreDataProperties.h"

@implementation SCCommentVO (CoreDataProperties)

+ (NSFetchRequest<SCCommentVO *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SCCommentVO"];
}

@dynamic commentId;
@dynamic created;
@dynamic num;
@dynamic text;
@dynamic updated;
@dynamic news;
@dynamic reply;
@dynamic responses;
@dynamic user;
@dynamic votes;

@end
