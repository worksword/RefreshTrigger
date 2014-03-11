//
//  SLRefreshTrigger.h
//  RefreshTrigger
//
//  Created by Luke on 3/10/14.
//  Copyright (c) 2014 work.sword. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLRefreshTrigger.h"

@interface SLRefreshTriggerIndicatorView : UIView<SLRefreshTriggerIndicatorDelegate>

@property (nonatomic, weak)  IBOutlet  UIActivityIndicatorView         *indicatorView;

+ (SLRefreshTriggerIndicatorView *)createRefreshTriggerView;

@end
