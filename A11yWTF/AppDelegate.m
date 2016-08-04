//
//  AppDelegate.m
//  A11yWTF
//
//  Created by iain on 03/08/2016.
//  Copyright © 2016 iain. All rights reserved.
//

#import "AppDelegate.h"
#import "FauxElement.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate {
    FauxElement *_dockbar;
    FauxElement *_alignment;
    FauxElement *_box;
    FauxElement *_label;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    _dockbar = [[FauxElement alloc] init];
    _dockbar.accessibilityIdentifier = @"Dockbar";
    
    _alignment = [[FauxElement alloc] init];
    _alignment.accessibilityIdentifier = @"Alignment";
    
    _box = [[FauxElement alloc] init];
    _box.accessibilityIdentifier = @"Box";
    
    [_alignment accessibilityAddChildElement:_box];
    
    [_dockbar accessibilityAddChildElement:_alignment];
    
    _label = [[FauxElement alloc] init];
    _label.accessibilityIdentifier = @"Label";
    
    [_box accessibilityAddChildElement:_label];

    NSLog (@"Child: %@", _label);
    [self dumpParents:[_label accessibilityParent]];
}

// dumpParents: recurses through the accessibility heirarchy
// and then logs the elements and their -accessibilityWindow
// from the root to the leaf.
//
// It logs the root element correctly but when it unwinds to the next level
// to log the Alignment, the call to -accessibilityWindow climbs back up to
// the root element, and sets the parent of Dockbar to be Alignment
// which creates a loop
- (void)dumpParents:(id<NSAccessibility>)child
{
    if (child == nil) {
        return;
    }
    
    id parent = [child accessibilityParent];
    [self dumpParents:parent];
    
    if (parent == nil) {
        return;
    }
    
    NSLog (@"Parent %@", parent);
    NSLog (@"   L Window: %@", [parent accessibilityWindow]);
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
