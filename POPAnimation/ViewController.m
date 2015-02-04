//
//  ViewController.m
//  POPAnimation
//
//  Created by Siba Prasad Hota  on 2/4/15.
//  Copyright (c) 2015 wemakeappz. All rights reserved.
//

#import "ViewController.h"
#import  "POP.h"
@interface ViewController ()
{
    BOOL _isToggled;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *demoField;
@property (weak, nonatomic) IBOutlet UILabel *demoLabel;

- (IBAction)tapView:(UITapGestureRecognizer *)recognizer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isToggled=NO;
    
    [self performSelector:@selector(textFieldAnimation) withObject:nil afterDelay:0.1];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)textFieldAnimation
{
    POPSpringAnimation *anim1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anim1.springBounciness = 20; //just parameters, nothing fancy
    anim1.velocity = @400;
    [anim1 setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
//        self.somebutton.userInteractionEnabled = YES;
    }];
    
    POPSpringAnimation *anim2 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anim2.springBounciness = 20; //just parameters, nothing fancy
    anim2.velocity = @400;
    
    [self.demoField.layer pop_addAnimation:anim1 forKey:@"positionAnimation"];
    [self.demoLabel.layer pop_addAnimation:anim2 forKey:@"positionAnimation"];
    
    [anim1 removedOnCompletion];
    [anim2 removedOnCompletion];
}

// Move the View where you tapped

- (IBAction)tapView:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    anim.toValue = [NSValue valueWithCGPoint:location];
    anim.springBounciness = 20;
    anim.springSpeed = 1;
    
    [self.imageView.layer pop_addAnimation:anim forKey:@"move"];
}


// Zoom In  & Zoom Out

- (IBAction)tap:(UITapGestureRecognizer *)recognizer {
    
    const CGFloat LargeSize = 256.0f;
    const CGFloat SmallSize = 64.0f;
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    
    if (self.imageView.frame.size.width >= LargeSize) {
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, SmallSize, SmallSize)];
    } else {
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, LargeSize, LargeSize)];
    }
    
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    [self.imageView.layer pop_addAnimation:anim forKey:@"scale"];
    
   }






- (IBAction)pan:(UIPanGestureRecognizer *)recognizer
{
    [self.imageView.layer pop_removeAnimationForKey:@"move"];
    [self.imageView.layer pop_removeAnimationForKey:@"slide"];
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.view];
            CGPoint center = self.imageView.center;
            center.x += translation.x;
            center.y += translation.y;
            self.imageView.center = center;
            [recognizer setTranslation:CGPointZero inView:self.view];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
            anim.deceleration = 0.998;
            anim.velocity = [NSValue valueWithCGPoint:[recognizer velocityInView:self.view]];
            [self.imageView.layer pop_addAnimation:anim forKey:@"slide"];
            break;
        }
            
        case UIGestureRecognizerStateCancelled:
            break;
            
        default:
            break;
    }
}


/*
 - (void)tap2:(UITapGestureRecognizer *)recognizer {
 _isToggled = !_isToggled;
 
 UIColor *targetColor;
 CGRect targetBounds;
 CGFloat targetRadius;
 
 if (_isToggled) {
 targetColor = [UIColor greenColor];
 targetBounds = CGRectMake(initialBounds.origin.x - 0.5 * initialBounds.size.width,
 initialBounds.origin.y + 0.25 * initialBounds.size.height,
 initialBounds.size.width * 2,
 initialBounds.size.height * .5);
 targetRadius = 10.0f;
 
 } else {
 targetColor = [UIColor blueColor];
 targetBounds = initialBounds;
 targetRadius = 36.0f;
 }
 
 // TODO animate
 POPSpringAnimation *colorAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
 colorAnim.toValue = (id)[targetColor CGColor];
 colorAnim.springSpeed = 6;
 [self.layer pop_addAnimation:colorAnim forKey:@"color"];
 
 POPSpringAnimation *boundsAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
 boundsAnim.toValue = [NSValue valueWithCGRect:targetBounds];
 boundsAnim.springSpeed = 6;
 [self.layer pop_addAnimation:boundsAnim forKey:@"bounds"];
 
 POPSpringAnimation *cornerAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
 cornerAnim.toValue = @(targetRadius);
 cornerAnim.springSpeed = 6;
 [self.layer pop_addAnimation:cornerAnim forKey:@"corner"];
 }
 

 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
