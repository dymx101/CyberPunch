//
//  HudLayer.m
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/7/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import "HudLayer.h"
#import "Defines.h"
#import "SKTUtils.h"
#import "SKAction+SKTExtras.h"


@implementation HudLayer

- (instancetype)init
{
    if (self = [super init])
    {
        //directional pad
        CGFloat radius = 64.0 * kPointFactor;
        _dPad = [ActionDPad dPadWithPrefix:@"dpad" radius:radius];
        _dPad.position = CGPointMake(radius, radius);
        _dPad.alpha = 0.5;
        [self addChild:_dPad];
        
        CGFloat buttonRadius = radius / 2.0;
        CGFloat padding = 8.0 * kPointFactor;
        
        _buttonB = [ActionButton buttonWithPrefix:@"button_b"
                                           radius:buttonRadius];
        
        _buttonB.position =
        CGPointMake(SCREEN.width - buttonRadius - padding,
                    buttonRadius * 2 + padding);
        
        _buttonB.alpha = 0.5;
        _buttonB.name = @"ButtonB";
        [self addChild:_buttonB];
        
        _buttonA =
        [ActionButton buttonWithPrefix:@"button_a"
                                radius:buttonRadius];
        
        _buttonA.position =
        CGPointMake(_buttonB.position.x - radius - padding,
                    buttonRadius + padding);
        
        _buttonA.alpha = 0.5;
        _buttonA.name = @"ButtonA";
        [self addChild:_buttonA];
        
    }
    
    return self;
}

- (void)update:(NSTimeInterval)delta
{
    [self.dPad update:delta];
}

@end
