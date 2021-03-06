//
//  ESDebugConsole.h
//
//  Copyright Doug Russell 2011. All rights reserved.
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

#import <Foundation/Foundation.h>

extern NSString *const kESDebugConsoleAllLogsKey;

@interface ESDebugConsole : NSObject

/**
 * Shared instance of debug console overlay
 */
+ (id)sharedDebugConsole;

/**
 * Dictionary containing arrays of ESConsoleEntry objects
 * Keyed by application identifier.
 * Key kESDebugConsoleAllLogsKey returns an array of console entries for all apps.
 */
+ (NSDictionary *)getConsole;

/**
 * Gesture recognizer will by default be a rotation gesture recognizer attached to the window
 * If you set your own it's target must be [ESDebugConsole sharedDebugConsole] with action gestureRecognized:
 */
@property (nonatomic, retain) UIGestureRecognizer *gestureRecognizer;
/**
 * Used by view controllers when displayed in UIPopoverController
 */
@property (nonatomic, assign) CGSize consoleSizeInPopover;


@end

@interface ESConsoleEntry : NSObject
@property (nonatomic, retain) NSString *applicationIdentifier;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSDate *date;
@end
