//
// UIButton+ODBlocks.m
//
// Copyright (c) 2015 Alexey Nazaroff, AJR
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

#import <Foundation/Foundation.h>
#import "UIButton+ODBlocks.h"
#import <ODX.Core/ODAssociatedProperty.h>

#if __BLOCKS__

@interface UIButtonProxyTarget : NSObject
@property (nonnull, nonatomic, copy) uibutton_block_t block;
@end

@implementation UIButtonProxyTarget

- (void)action:(nonnull UIButton *)sender {
    if (self.block) {
        self.block(sender);
    }
}

@end

@implementation UIButton (OD_Blocks)
@synthesizing_associatedRetainProperty(NSMutableSet *, od_targetsSet, setOd_targetsSet)

- (void)od_addBlock:(nonnull uibutton_block_t)block forControlEvents:(UIControlEvents)controlEvents {
    NSCAssert(block, @"Block can't be nil");
    
    if (!self.od_targetsSet) {
        self.od_targetsSet = [NSMutableSet setWithCapacity:1];
    }
    
    UIButtonProxyTarget *target = [UIButtonProxyTarget new];
    target.block = block;
    [self.od_targetsSet addObject:target];
    
    [self addTarget:target action:@selector(action:) forControlEvents:controlEvents];
}

@end

#endif