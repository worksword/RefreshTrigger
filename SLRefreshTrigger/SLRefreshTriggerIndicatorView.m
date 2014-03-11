//
//  SLRefreshTrigger.m
//  RefreshTrigger
//
//  Created by Luke on 3/10/14.
//  Copyright (c) 2014 work.sword. All rights reserved.
//

#import "SLRefreshTriggerIndicatorView.h"

@implementation SLRefreshTriggerIndicatorView

+ (SLRefreshTriggerIndicatorView *)createRefreshTriggerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"SLRefreshTriggerIndicatorView" owner:nil options:nil][0];
}

#pragma mark - SLRefreshTriggerIndicatorDelegate
- (void)start
{
    [self.indicatorView startAnimating];
}

- (void)stop
{
    [self.indicatorView stopAnimating];
}

@end
