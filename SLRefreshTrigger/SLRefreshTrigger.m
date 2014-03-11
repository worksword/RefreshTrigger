//
//  SLRefreshTriggerManager.m
//  RefreshTrigger
//
//  Created by Luke on 3/10/14.
//  Copyright (c) 2014 work.sword. All rights reserved.
//

#import "SLRefreshTrigger.h"

@interface SLRefreshTrigger()<UIScrollViewDelegate>

@property (nonatomic,   weak)   id<SLRefreshTriggerDelegate>                          delegate;
@property (nonatomic,   weak)   UIScrollView                                          *scrollView;
@property (nonatomic, assign)   SLRefreshTriggerIndicatorViewStyle                    indicatorViewStyle;
@property (nonatomic, assign)   BOOL                                                  refreshing;
@property (nonatomic, strong)   UIView<SLRefreshTriggerIndicatorDelegate>             *indicatorView;

@end


@implementation SLRefreshTrigger

#pragma mark - init
- (id)initWithScrollView:(UIScrollView *)scrollView scrollParentView:(UIView *)parentView indicatorView:(UIView<SLRefreshTriggerIndicatorDelegate> *)indicatorView indicatorViewStyle:(SLRefreshTriggerIndicatorViewStyle)indicatorViewStyle andDelegate:(id<SLRefreshTriggerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.scrollView = scrollView;
        self.scrollView.delegate = self;
        self.indicatorView = indicatorView;
        self.indicatorViewStyle = indicatorViewStyle;
        
        if (self.indicatorViewStyle == SLRefreshTriggerIndicatorViewStyle_Scrollable) {
            CGRect frame = self.indicatorView.frame;
            frame.origin.y = self.scrollView.frame.origin.y - frame.size.height;
            self.indicatorView.frame = frame;
        }
        [parentView insertSubview:self.indicatorView belowSubview:scrollView];
    }
    return self;
}

- (id)initWithScrollView:(UIScrollView *)scrollView indicatorView:(UIView<SLRefreshTriggerIndicatorDelegate> *)indicatorView indicatorViewStyle:(SLRefreshTriggerIndicatorViewStyle)indicatorViewStyle andDelegate:(id<SLRefreshTriggerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.scrollView = scrollView;
        self.indicatorView = indicatorView;
        self.indicatorViewStyle = indicatorViewStyle;
        
        if (self.indicatorViewStyle == SLRefreshTriggerIndicatorViewStyle_Scrollable) {
            CGRect frame = self.indicatorView.frame;
            frame.origin.y = self.scrollView.frame.origin.y - frame.size.height;
            self.indicatorView.frame = frame;
        }
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self onScrollViewDidScroll];
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate performSelector:@selector(scrollViewDidScroll:) withObject:scrollView];
    }
}

#pragma mark - Public
- (void)onScrollViewDidScroll
{
    CGPoint point = self.scrollView.contentOffset;
    CGRect frame = self.indicatorView.frame;
    if (self.refreshing) {
        if (self.indicatorViewStyle == SLRefreshTriggerIndicatorViewStyle_Scrollable) {
            if (-point.y <= frame.size.height) {
                frame.origin.y = self.scrollView.frame.origin.y - (frame.size.height + point.y);
                self.indicatorView.frame = frame;
            } else if (frame.origin.y != self.scrollView.frame.origin.y) {
                frame.origin.y = self.scrollView.frame.origin.y;
                self.indicatorView.frame = frame;
            }
        }
    } else {
        if (self.indicatorViewStyle == SLRefreshTriggerIndicatorViewStyle_Scrollable) {
            frame.origin.y = self.scrollView.frame.origin.y - (frame.size.height + point.y);
            self.indicatorView.frame = frame;
        }
        
        if (-point.y > frame.size.height && !self.scrollView.isDragging) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            self.scrollView.contentInset = UIEdgeInsetsMake(frame.size.height, 0, 0, 0);
            self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
            [UIView commitAnimations];
            
            [self.indicatorView start];
            self.refreshing = YES;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(onRefreshTriggered)]) {
                [self.delegate onRefreshTriggered];
            }
        }
    }
}

- (void)finish
{
    if (self.refreshing) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        self.scrollView.contentInset = UIEdgeInsetsZero;
        self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
        [UIView commitAnimations];
        
        [self.indicatorView stop];
        
        if (self.indicatorViewStyle == SLRefreshTriggerIndicatorViewStyle_Scrollable) {
            CGRect frame = self.indicatorView.frame;
            frame.origin.y = self.scrollView.frame.origin.y - frame.size.height;
            self.indicatorView.frame = frame;
        }
        
        self.refreshing = NO;
    }
}

@end
