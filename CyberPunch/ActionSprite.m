//
//  ActionSprite.m
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/7/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import "ActionSprite.h"
#import "Defines.h"


@implementation ActionSprite
- (void)idle {
    if (self.actionState != kActionStateIdle) {
        [self removeAllActions];
        [self runAction:self.idleAction]; self.velocity = CGPointZero; self.actionState = kActionStateIdle;
    }
}


@end
