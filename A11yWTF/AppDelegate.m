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
    _dockbar.accessibilityWindow = _window;
    
    _alignment = [[FauxElement alloc] init];
    _alignment.accessibilityIdentifier = @"Alignment";
    
    _box = [[FauxElement alloc] init];
    _box.accessibilityIdentifier = @"Box";
    
    [_alignment accessibilityAddChildElement:_box];
    
    [_dockbar accessibilityAddChildElement:_alignment];
    
    _label = [[FauxElement alloc] init];
    _label.accessibilityIdentifier = @"Label";
    
    [_box accessibilityAddChildElement:_label];

    // Calling -accessibillityWindow on any of the child elements
    // (here for example we use _box) causes Cocoa to climb to the
    // root of the accessibility tree (Dockbar) and then assign
    // Alignment as the parent of Dockbar, causing a loop in the tree
    // (Alignment is the parent Dockbar which is the parent of Alignment)
    // and an infinite loop.
    //
    // This seems to happen whether _dockbar.accessibilityWindow is set or not
    NSLog (@"%@", [_box accessibilityWindow]);
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
