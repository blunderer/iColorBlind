//
//  ColorMeterViewController.m
//  ColorMeter
//
//  Created by blunderer on 15/12/09.
//  Copyright blunderer 2009. All rights reserved.
//

#import "ColorMeterViewController.h"

@implementation ColorMeterViewController

@synthesize proc;
@synthesize img;
@synthesize lblcouleur;
@synthesize lblhsl;
@synthesize lblhtml;
@synthesize lblrgb;
@synthesize pop;
@synthesize wait;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
 
	camera = [[UIImagePickerController alloc] init];	
	[camera setDelegate:self];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	CGImageRef ref = [image CGImage];
	size_t bpp = CGImageGetBitsPerPixel(ref);
	size_t depth = CGImageGetBitsPerComponent(ref);
    size_t w = CGImageGetWidth(ref);
    size_t h = CGImageGetHeight(ref);
	CGDataProviderRef refProvider = CGImageGetDataProvider(ref);
	CFDataRef refdata = CGDataProviderCopyData(refProvider);
	const UInt8 * data = CFDataGetBytePtr(refdata);

	int posX = 800-5;
	int posY = 600-5;
	float accR = 0;
	float accG = 0;
	float accB = 0;
	float accA = 0;
	float hue;
	float sat;
	float lum;
	
	int startpos = (posX + posY * w) * (bpp/depth);
	for(int i = 0; i < 10; i++) {
		for(int j = 0; j < 10; j++) {
			int pos = startpos + i*w*(bpp/depth) + j*(bpp/depth);
			accA += data[pos+3];
			accR += data[pos+2];
			accG += data[pos+1];
			accB += data[pos+0];
		}
	}
	accR /= 25500;
	accG /= 25500;
	accB /= 25500;
	accA /= 25500;
	
	float max = 0;
	float min = 2;
	
	if(accR >= max) max = accR;
	if(accG >= max) max = accG;
	if(accB >= max) max = accB;
	if(accR <= min) min = accR;
	if(accG <= min) min = accG;
	if(accB <= min) min = accB;
	
	lum = 0.5 * (min+max);
	
	if(lum > 0.5) {
		sat = (max-min) / (2-2*lum);
	} else {
		sat = (max-min) / (2*lum);
	}
	
	if((accR == accG)&&(accR == accB)&&(accG == accB)) {
		hue = 0;
		sat = 0;
	} else if((accR >= accG)&&(accR >= accB)) {
		hue = 60 * ((accG-accB) / (max-min)) + 360;
		printf("R max-min = %f diff=%f\n",max-min,accG-accB);
	} else if((accG >= accR)&&(accG >= accB)) {
		hue = 60 * ((accB-accR) / (max-min)) + 120;
		printf("G max-min = %f diff=%f\n",max-min,accG-accR);
	} else if((accB >= accR)&&(accB >= accG)) {
		hue = 60 * ((accR-accG) / (max-min)) + 240;
		printf("B max-min = %f diff=%f\n",max-min,accR-accG);
	}	
	while(hue > 360) hue = hue - 360;
	while(hue < 0) hue = hue + 360;
	
	printf("w=%d h=%d d=%d\n", w, h, bpp/depth);
	printf("R=%f G=%f B=%f A=%f -> Hue=%f, Sat=%f, Lum=%f\n", accR, accG, accB, accA, hue, sat, lum);
	
	[lblrgb setText:[NSString stringWithFormat:@"RGB: %.2f  %.2f  %.2f", accR, accG, accB]];
	[lblhsl setText:[NSString stringWithFormat:@"HSL: %.2f  %.2f  %.2f", hue, sat, lum]];
	[lblhtml setText:[NSString stringWithFormat:@"HTML: #FF%02X%02X%02X", (UInt8)round(accR*255), (UInt8)round(accG*255), (UInt8)round(accB*255)]];
	
	if(sat < 0.2) {
		if(lum > 0.55) {
			printf("BLANC\n");
			[lblcouleur setText:@"BLANC"];
		} else if(lum < 0.45) {
			printf("NOIR\n");
			[lblcouleur setText:@"NOIR"];
		} else {
			printf("GRIS\n");
			[lblcouleur setText:@"GRIS"];
		}
	} else {
		if(hue > 320) {
			printf("ROUGE\n");		
			[lblcouleur setText:@"ROUGE"];
		} else if(hue > 290) {
			printf("ROSE\n");		
			[lblcouleur setText:@"ROSE"];
		} else if(hue > 270) {
			printf("VIOLET\n");		
			[lblcouleur setText:@"VIOLET"];
		} else if(hue > 190) {
			printf("BLEU\n");		
			[lblcouleur setText:@"BLEU"];
		} else if(hue > 170) {
			printf("CYAN\n");		
			[lblcouleur setText:@"CYAN"];
		} else if(hue > 70) {
			printf("VERT\n");		
			[lblcouleur setText:@"VERT"];
		} else if(hue > 50) {
			printf("JAUNE\n");		
			[lblcouleur setText:@"JAUNE"];
		} else if(hue > 30) {
			printf("ORANGE\n");		
			[lblcouleur setText:@"ORANGE"];
		} else {
			printf("ROUGE\n");		
			[lblcouleur setText:@"ROUGE"];
		}
	}
	[wait setHidden:YES];
	[wait stopAnimating];
	
	[UIView beginAnimations:@"" context:NULL];
	[UIView setAnimationDuration:0.8];
	[pop setAlpha:1.0];
	[UIView commitAnimations];
}

- (IBAction) again
{
	[img setHidden:NO];
	[proc setEnabled:YES];

	[UIView beginAnimations:@"" context:NULL];
	[UIView setAnimationDuration:0.5];
	[pop setAlpha:0.0];
	[UIView commitAnimations];
}

- (IBAction) Process
{
	[img setHidden:YES];
	[wait setHidden:NO];
	[wait startAnimating];
	[proc setEnabled:NO];
	[camera takePicture];
}

- (void)viewDidAppear:(BOOL)animated
{
	[camera setSourceType:UIImagePickerControllerSourceTypeCamera];
    [camera setShowsCameraControls:NO];
	[camera setNavigationBarHidden:YES];
	[camera setToolbarHidden:YES];
	[camera setAllowsEditing:NO];
	[camera setWantsFullScreenLayout:YES];	
	[camera setCameraOverlayView:[self view]];
	[self presentModalViewController:camera animated:TRUE];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
