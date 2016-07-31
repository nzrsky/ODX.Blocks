//
// UIActionSheet+ODBlocks.m
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

#import "UIActionSheet+ODBlocks.h"
#import <ODAssociatedProperty.h>

#if __BLOCKS__

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && !defined(__WATCH_OS_VERSION_MIN_REQUIRED)

@interface UIActionSheet () <UIActionSheetDelegate>
@end

@implementation UIActionSheet (ODXBlocks)
@synthesizing_associatedCopyProperty(uiactionsheet_block_t, od_completionBlock, setOd_completionBlock)

- (nonnull instancetype)initWithTitle:(nullable NSString *)title
                           completion:(nullable uiactionsheet_block_t)completion
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
               destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                    otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    self = [self initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle
                       destructiveButtonTitle:nil otherButtonTitles:nil];
    
    if (self) {
        self.od_completionBlock = completion;
        
        va_list arguments;
        va_start(arguments, otherButtonTitles);
        
        for (NSString *arg = otherButtonTitles; arg != nil; arg = (__bridge NSString *)va_arg(arguments, void *)) {
            [self addButtonWithTitle:arg];
        }
   
        self.destructiveButtonIndex = (destructiveButtonTitle) ? [self addButtonWithTitle:destructiveButtonTitle] : -1;
        
        va_end(arguments);
    }
    
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (self.od_completionBlock) {
        self.od_completionBlock(buttonIndex == self.cancelButtonIndex, buttonIndex);
    }
}

- (void)od_addCompletionBlock:(nullable uiactionsheet_block_t)completion {
    self.od_completionBlock = completion;
    self.delegate = self;
}

@end

#endif

#endif
