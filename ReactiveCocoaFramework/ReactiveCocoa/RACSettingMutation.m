//
//  RACSettingMutation.m
//  ReactiveCocoa
//
//  Created by Justin Spahr-Summers on 2013-12-26.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import "RACSettingMutation.h"

#import "NSArray+RACSupport.h"
#import "RACSignal+Operations.h"

@implementation RACSettingMutation

#pragma mark Properties

- (NSIndexSet *)indexes {
	return [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.addedObjects.count)];
}

#pragma mark Lifecycle

- (instancetype)initWithObjects:(NSArray *)objects {
	NSCParameterAssert(objects != nil);

	self = [super init];
	if (self == nil) return nil;

	_addedObjects = [objects copy];

	return self;
}

#pragma mark RACCollectionMutation

- (instancetype)map:(id (^)(id object))block {
	NSArray *newObjects = [[self.addedObjects.rac_signal map:block] array];
	return [(RACSettingMutation *)[self.class alloc] initWithObjects:newObjects];
}

- (void)mutateCollection:(id<RACCollection>)collection {
	[collection rac_replaceAllObjects:self.addedObjects];
}

#pragma mark RACOrderedCollectionMutation

- (void)mutateOrderedCollection:(id<RACCollection>)collection {
	[self mutateCollection:collection];
}

@end
