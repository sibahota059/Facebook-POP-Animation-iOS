//
//  DemoViewController.m
//  POPAnimation
//
//  Created by Siba Prasad Hota  on 2/4/15.
//  Copyright (c) 2015 wemakeappz. All rights reserved.
//

#import "DemoViewController.h"
#import "POP.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetBtnTapped:(id)sender {
    self.resetBtn.enabled = FALSE;
    self.actionSegment.enabled = TRUE;
    self.actionSegment.selectedSegmentIndex = UISegmentedControlNoSegment;
    
    self.displayView.layer.frame = CGRectMake(0, 224, 120, 120);
    // [self.view bringSubviewToFront:self.displayView];
}

- (IBAction)actionValueChanged:(id)sender
{
    if (self.actionSegment.selectedSegmentIndex == 0)
    {
        POPSpringAnimation *animScale = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
        animScale.springBounciness = 18;
        animScale.springSpeed = 18;
        animScale.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 250, 250)];
        [self.displayView.layer pop_addAnimation:animScale forKey:@"size"];
    }
    else if (self.actionSegment.selectedSegmentIndex == 1)
    {
        POPDecayAnimation *animSlide = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        animSlide.velocity = @(400.);
        [self.displayView.layer pop_addAnimation:animSlide forKey:@"slide"];
    }
    else
    {
        POPDecayAnimation *animSlide = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        animSlide.velocity = @(400.);
        POPDecayAnimation *animRotate = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerRotationX];
        animRotate.velocity = @(800.);
        [self.displayView.layer pop_addAnimation:animSlide forKey:@"slide"];
        [self.displayView.layer pop_addAnimation:animRotate forKey:@"rotate"];
    }
    
    self.resetBtn.enabled = TRUE;
    self.actionSegment.enabled = FALSE;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
