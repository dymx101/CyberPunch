//
//  HudLayer.h
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/7/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ActionDPad.h"
#import "ActionButton.h"

@interface HudLayer : SKNode

@property (strong, nonatomic) ActionDPad *dPad;
@property (strong, nonatomic) ActionButton *buttonA;
@property (strong, nonatomic) ActionButton *buttonB;

- (void)update:(NSTimeInterval)delta;

@end

