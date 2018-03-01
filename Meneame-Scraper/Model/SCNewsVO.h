//
//  SCNewsVO.h
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 1/3/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum : NSUInteger {
    SCNewsTypeNormal = 0,
    SCNewsTypeImage,
    SCNewsTypeVideo,
} SCNewsType;

@class SCCommentVO;

NS_ASSUME_NONNULL_BEGIN

@interface SCNewsVO : NSManagedObject

@property (nonatomic, strong, readonly) NSString *userName;
@property (nonatomic, strong, readonly) NSArray *commentsSortedByDate;

+ (instancetype)exampleObject;
+ (instancetype)objectFromSourceCode:(NSString *)sourceCode;
+ (NSArray *)allObjectsFromSourceCode:(NSString *)sourceCode;
+ (NSArray *)allObjectsFromArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END

#import "SCNewsVO+CoreDataProperties.h"
