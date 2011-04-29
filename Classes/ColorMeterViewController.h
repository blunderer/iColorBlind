//
//  ColorMeterViewController.h
//  ColorMeter
//
//  Created by blunderer on 15/12/09.
//  Copyright blunderer 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorMeterViewController : UIViewController <UIImagePickerControllerDelegate> {
	UIImagePickerController *camera;
	IBOutlet UIButton * proc;
	IBOutlet UILabel * lblcouleur;
	IBOutlet UILabel * lblrgb;
	IBOutlet UILabel * lblhtml;
	IBOutlet UILabel * lblhsl;
	IBOutlet UIControl * pop;
	IBOutlet UIImageView * img;
	IBOutlet UIActivityIndicatorView * wait;
}

@property (nonatomic, retain) UIButton * proc;
@property (nonatomic, retain) UILabel * lblcouleur;
@property (nonatomic, retain) UILabel * lblrgb;
@property (nonatomic, retain) UILabel * lblhtml;
@property (nonatomic, retain) UILabel * lblhsl;
@property (nonatomic, retain) UIView * pop;
@property (nonatomic, retain) UIImageView * img;
@property (nonatomic, retain) UIActivityIndicatorView * wait;

- (IBAction) again;
- (IBAction) Process;


@end

