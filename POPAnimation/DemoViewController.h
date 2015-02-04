//
//  DemoViewController.h
//  POPAnimation
//
//  Created by Siba Prasad Hota  on 2/4/15.
//  Copyright (c) 2015 wemakeappz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *actionSegment;
@property (weak, nonatomic) IBOutlet UIView *displayView;

- (IBAction)resetBtnTapped:(id)sender;
- (IBAction)actionValueChanged:(id)sender;

@end
