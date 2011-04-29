//
//  ColorMeterAppDelegate.m
//  ColorMeter
//
//  Created by blunderer on 15/12/09.
//  Copyright blunderer 2009. All rights reserved.
//

#import "ColorMeterAppDelegate.h"
#import "ColorMeterViewController.h"

@implementation ColorMeterAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	[window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
