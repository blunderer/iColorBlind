//
//  ColorMeterAppDelegate.h
//  ColorMeter
//
//  Created by blunderer on 15/12/09.
//  Copyright blunderer 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorMeterViewController;

@interface ColorMeterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ColorMeterViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ColorMeterViewController *viewController;

@end

