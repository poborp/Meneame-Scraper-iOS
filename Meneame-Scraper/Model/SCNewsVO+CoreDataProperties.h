//
//  SCNewsVO+CoreDataProperties.h
//  Meneame-Scraper
//
//  Created by Jacobo Rodriguez on 6/3/17.
//  Copyright © 2017 Jacobo Rodriguez. All rights reserved.
//

#import "SCNewsVO.h"
#import "SCCommentVO.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCNewsVO (CoreDataProperties)

+ (NSFetchRequest<SCNewsVO *> *)fetchRequest;

@property (nonatomic) int32_t commentsCount;
@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nonatomic) int32_t karma;
@property (nonatomic) int32_t meneos;
@property (nullable, nonatomic, copy) NSDate *publishedDate;
@property (nullable, nonatomic, copy) NSString *section;
@property (nullable, nonatomic, copy) NSDate *sendedDate;
@property (nullable, nonatomic, copy) NSString *soruceTitle;
@property (nullable, nonatomic, copy) NSString *sourceUrl;
@property (nullable, nonatomic, copy) NSString *title;
@property (nonatomic) int16_t type;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSString *userImageUrl;
@property (nullable, nonatomic, copy) NSString *userUrl;
@property (nonatomic) int32_t votesAnonymous;
@property (nonatomic) int32_t votesNegative;
@property (nonatomic) int32_t votesPositive;
@property (nullable, nonatomic, retain) NSSet<SCCommentVO *> *comments;

@end

@interface SCNewsVO (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(SCCommentVO *)value;
- (void)removeCommentsObject:(SCCommentVO *)value;
- (void)addComments:(NSSet<SCCommentVO *> *)values;
- (void)removeComments:(NSSet<SCCommentVO *> *)values;

@end

NS_ASSUME_NONNULL_END
