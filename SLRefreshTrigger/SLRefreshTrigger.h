//
//  SLRefreshTriggerManager.h
//  RefreshTrigger
//
//  Created by Luke on 3/10/14.
//  Copyright (c) 2014 work.sword. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - SLRefreshTriggerIndicatorDelegate
@protocol SLRefreshTriggerIndicatorDelegate <NSObject>

- (void)start;
- (void)stop;

@end


#pragma mark - SLRefreshTriggerDelegate
@protocol SLRefreshTriggerDelegate <NSObject>

- (void)onRefreshTriggered;

@end


#pragma mark - SLRefreshTrigger

typedef enum {
    SLRefreshTriggerIndicatorViewStyle_Fixed,
    SLRefreshTriggerIndicatorViewStyle_Scrollable
} SLRefreshTriggerIndicatorViewStyle;


@interface SLRefreshTrigger : NSObject

- (id)initWithScrollView:(UIScrollView *)scrollView scrollParentView:(UIView *)parentView indicatorView:(UIView<SLRefreshTriggerIndicatorDelegate> *)indicatorView indicatorViewStyle:(SLRefreshTriggerIndicatorViewStyle)indicatorViewStyle andDelegate:(id<SLRefreshTriggerDelegate>)delegate;

- (void)finish;

@end
