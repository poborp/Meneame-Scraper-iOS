//
//  SCNewsVO+CoreDataProperties.m
//  Meneame-Scraper
//
//  Created by Jacobo Rodriguez on 6/3/17.
//  Copyright © 2017 Jacobo Rodriguez. All rights reserved.
//

#import "SCNewsVO+CoreDataProperties.h"

@implementation SCNewsVO (CoreDataProperties)

+ (NSFetchRequest<SCNewsVO *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SCNewsVO"];
}

@dynamic commentsCount;
@dynamic content;
@dynamic imageUrl;
@dynamic karma;
@dynamic meneos;
@dynamic publishedDate;
@dynamic section;
@dynamic sendedDate;
@dynamic soruceTitle;
@dynamic sourceUrl;
@dynamic title;
@dynamic type;
@dynamic url;
@dynamic userImageUrl;
@dynamic userUrl;
@dynamic votesAnonymous;
@dynamic votesNegative;
@dynamic votesPositive;
@dynamic comments;

@end
