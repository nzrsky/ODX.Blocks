//
// UIAlertView+ODBlocks.m
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

#import "UIAlertView+ODBlocks.h"
#import <ODXCore/ODAssociatedProperty.h>

#if __BLOCKS__

@interface UIAlertView () <UIAlertViewDelegate>
@end

@implementation UIAlertView (OD_Blocks)
@synthesizing_associatedCopyProperty(uialertview_block_t, od_completionBlock, setOd_completionBlock)

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                           completion:(nullable uialertview_block_t)completion
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                    otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
    if (self) {
        self.od_completionBlock = completion;
        
        va_list arguments;
        va_start(arguments, otherButtonTitles);
        
        for (NSString *arg = otherButtonTitles; arg != nil; arg = (__bridge NSString *)va_arg(arguments, void *)) {
            [self addButtonWithTitle:arg];
        }
        
        va_end(arguments);
    }
    
    return self;
}

+ (nonnull instancetype)alertWithTitle:(nullable NSString *)title
                               message:(nullable NSString *)message
                            completion:(nullable uialertview_block_t)completion {
    return [[self alloc] initWithTitle:title message:message completion:completion
                     cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (self.od_completionBlock) {
        self.od_completionBlock(buttonIndex == self.cancelButtonIndex, buttonIndex);
    }
}

@end

#endif