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
    }
    
    return self;
}

- (void)update:(NSTimeInterval)delta
{
    [self.dPad update:delta];
}

@end
