// ODAssociatedProperty.h
//
// Copyright (c) 2009-2015 Alexey Nazaroff, AJR
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

#import "ODStringify.h"
#import <objc/runtime.h>

/** Associated properties */
#define ODAssociatedGetter(cls, getter)                                         \
- (cls)getter {                                                                 \
    return objc_getAssociatedObject(self, @selector(getter));                   \
}

#define ODAssociatedSetter(cls, getter, setter, policy)                         \
- (void)setter:(cls)value {                                                     \
    objc_setAssociatedObject(self, @selector(getter), value, policy);           \
}

/** Synthesize associated property with getter, setter and policy flag */
#define ODAssociatedProperty(cls, getter, setter, policy)                       \
        ODAssociatedGetter(cls, getter)                                         \
        ODAssociatedSetter(cls, getter, setter, policy)


/** Synthesize associated property with assign modifier  */
#define synthesizing_associatedAssignProperty(cls, getter, setter)              \
        class ODConcat(__Unused_, __LINE__);                                    \
        ODAssociatedProperty(cls, getter, setter, OBJC_ASSOCIATION_ASSIGN)

/** Synthesize associated property with copy modifier  */
#define synthesizing_associatedCopyProperty(cls, getter, setter)                \
        class ODConcat(__Unused_, __LINE__);                                    \
        ODAssociatedProperty(cls, getter, setter, OBJC_ASSOCIATION_COPY_NONATOMIC)

/** Synthesize associated property with retain modifier  */
#define synthesizing_associatedRetainProperty(cls, getter, setter)              \
        class ODConcat(__Unused_, __LINE__);                                    \
        ODAssociatedProperty(cls, getter, setter, OBJC_ASSOCIATION_RETAIN_NONATOMIC)




