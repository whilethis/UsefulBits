//
//  ESArrayPropertyMap.m
//	
//  Created by Doug Russell
//  Copyright (c) 2011 Doug Russell. All rights reserved.
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//  http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  

#import "ESArrayPropertyMap.h"

@implementation ESArrayPropertyMap
@synthesize memberClass=_memberClass;

+ (id)newPropertyMapWithInputKey:(NSString *)inputKey outputKey:(NSString *)outputKey memberClass:(Class)memberClass
{
	return [[[self class] alloc] initWithInputKey:inputKey outputKey:outputKey memberClass:memberClass];
}

- (id)initWithInputKey:(NSString *)inputKey outputKey:(NSString *)outputKey memberClass:(Class)memberClass
{
	self = [super initWithInputKey:inputKey outputKey:outputKey transformBlock:nil];
	if (self)
	{
		self.memberClass = memberClass;
		self.transformBlock = ^id(id inputValue) {
			NSMutableArray *outArray = [NSMutableArray new];
			for (NSDictionary *dictionary in (NSArray *)inputValue)
			{
				@autoreleasepool {
					id member = [[memberClass alloc] initWithDictionary:dictionary];
					if (member)
						[outArray addObject:member];
				}
			}
			return outArray;
		};
	}
	return self;
}

- (ESTransformBlock)inverseTransformBlock
{
	if (_inverseTransformBlock == nil)
	{
		_inverseTransformBlock = [^id(id inputValue) {
			NSMutableArray *dictionaryArray = [NSMutableArray new];
			for (id member in (NSArray *)inputValue)
			{
				NSDictionary *dictionary = [member dictionaryRepresentation];
				if (dictionary)
					[dictionaryArray addObject:dictionary];
			}
			return dictionaryArray;
		} copy];
	}
	return _inverseTransformBlock;
}

@end