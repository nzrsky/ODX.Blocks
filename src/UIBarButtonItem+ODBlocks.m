//
//  UIBarButtonItem+ODBlocks.m
//
// Copyright (c) 2010-2015 Alexey Nazaroff, AJR
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIBarButtonItem+ODBlocks.h"
#import <ODX.Core/ODAssociatedProperty.h>

#if __BLOCKS__
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && !defined(__WATCH_OS_VERSION_MIN_REQUIRED)

@implementation UIBarButtonItem (OD_Blocks)
@synthesizing_associatedRetainProperty(uibarbuttonitem_block_t, od_action, setOd_action)

+ (instancetype)itemWithImage:(UIImage *)img action:(uibarbuttonitem_block_t)action {
    UIBarButtonItem *item = [[self alloc] initWithImage:img style:UIBarButtonItemStylePlain target:nil action:@selector(od_performAction:)];
    [item od_setupAction:action];
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title action:(uibarbuttonitem_block_t)action {
    UIBarButtonItem *item = [[self alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:@selector(od_performAction:)];
    [item od_setupAction:action];
    return item;
}

+ (instancetype)itemWithSystemType:(UIBarButtonSystemItem)systemItem action:(uibarbuttonitem_block_t)action {
    UIBarButtonItem *item = [[self alloc] initWithBarButtonSystemItem:systemItem target:nil action:@selector(od_performAction:)];
    [item od_setupAction:action];
    return item;
}

+ (instancetype)itemWithCustomView:(UIView *)customView action:(uibarbuttonitem_block_t)action {
    UIBarButtonItem *item = [[self alloc] initWithCustomView:customView];
    [item od_setupAction:action];
    item.action = @selector(od_performAction:);
    return item;
}

- (void)od_setupAction:(uibarbuttonitem_block_t)action {
    self.od_action = [action copy];
    self.target = self;
}

- (void)od_performAction:(id)sender {
    if (self.od_action) {
        self.od_action(self);
    }
}

@end

#endif
#endif