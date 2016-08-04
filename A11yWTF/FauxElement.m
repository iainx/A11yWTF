//
//  FauxElement.m
//  A11yWTF
//
//  Created by iain on 03/08/2016.
//  Copyright © 2016 iain. All rights reserved.
//

#import "FauxElement.h"

@implementation FauxElement

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", [super description], [self accessibilityIdentifier]];
}

- (id)accessibilityWindow
{
    NSLog (@"Getting window of %@", self);
    return [super accessibilityWindow];
}

- (void)setAccessibilityParent:(id)accessibilityParent
{
    NSLog(@"Setting parent of %@ to %@", self, accessibilityParent);
    [super setAccessibilityParent:accessibilityParent];
}

- (id)accessibilityParent
{
    NSLog (@"Getting accessibility parent of %@ == %@", self, [super accessibilityParent]);
    return [super accessibilityParent];
}
@end
