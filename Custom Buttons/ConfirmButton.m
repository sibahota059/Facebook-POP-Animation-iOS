//
//  ConfirmButton.m
//  POPAnimation
//
//  Created by Siba Prasad Hota  on 2/4/15.
//  Copyright (c) 2015 wemakeappz. All rights reserved.
//

#import "ConfirmButton.h"
#import "Pop.h"

@interface ConfirmButton ()
{
    BOOL _isToggled;
    CGRect initialBounds;
}
@end

@implementation ConfirmButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.layer.backgroundColor = [[UIColor blueColor] CGColor];
    self.layer.cornerRadius = 36;
    initialBounds = self.bounds;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
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
    colorAnim.springBounciness = 20;
    [self.layer pop_addAnimation:colorAnim forKey:@"color"];
    POPSpringAnimation *boundsAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    boundsAnim.toValue = [NSValue valueWithCGRect:targetBounds];
    boundsAnim.springSpeed = 6;
    boundsAnim.springBounciness = 20;
    [self.layer pop_addAnimation:boundsAnim forKey:@"bounds"];
    POPSpringAnimation *cornerAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
    cornerAnim.toValue = @(targetRadius);
    cornerAnim.springSpeed = 6;
    cornerAnim.springBounciness = 20;
    [self.layer pop_addAnimation:cornerAnim forKey:@"corner"];
}

@end;
