//
//  SWViewController.m
//  RefreshTrigger
//
//  Created by Luke on 3/10/14.
//  Copyright (c) 2014 work.sword. All rights reserved.
//

#import "SWViewController.h"
#import "SLRefreshTrigger.h"
#import "SLRefreshTriggerIndicatorView.h"

@interface SWViewController ()<SLRefreshTriggerDelegate>

@property (nonatomic, weak) IBOutlet UIView             *container;
@property (nonatomic, weak) IBOutlet UIScrollView       *scrollView;
@property (nonatomic, strong) SLRefreshTrigger          *trigger;

@end

@implementation SWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    SLRefreshTriggerIndicatorView *indicatorView = [SLRefreshTriggerIndicatorView createRefreshTriggerView];
    self.trigger = [[SLRefreshTrigger alloc] initWithScrollView:self.scrollView scrollParentView:self.container indicatorView:indicatorView indicatorViewStyle:SLRefreshTriggerIndicatorViewStyle_Scrollable andDelegate:self];
    self.scrollView.contentSize = CGSizeMake(320, 1000);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SLRefreshTriggerDelegate
- (void)onRefreshTriggered
{
    [self.trigger performSelector:@selector(finish) withObject:nil afterDelay:6];
}

@end
