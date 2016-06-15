//
//  NSTimer+Blocks.m
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

#import "NSTimer+ODBlocks.h"

#if __BLOCKS__

@implementation NSTimer (ODXBlocks)

+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(nstimer_block_t)block repeats:(BOOL)repeats {
    NSParameterAssert(block != nil);
    return [self scheduledTimerWithTimeInterval:interval
                                           target:self
                                         selector:@selector(od_executeBlock:)
                                         userInfo:block
                                          repeats:repeats];
}

+ (id)timerWithTimeInterval:(NSTimeInterval)interval block:(nstimer_block_t)block repeats:(BOOL)repeats {
    NSParameterAssert(block != nil);
    return [self timerWithTimeInterval:interval
                                target:self
                              selector:@selector(od_executeBlock:)
                              userInfo:block
                               repeats:repeats];
}

+ (void)od_executeBlock:(NSTimer *)timer {
    if (timer.userInfo) {
        nstimer_block_t block = (nstimer_block_t)timer.userInfo;
        block(timer);
    }
}

@end

#endif