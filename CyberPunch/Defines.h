//
//  Defines.h
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/5/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#ifndef __CyberPunch__Defines__
#define __CyberPunch__Defines__

#include <stdio.h>
#define BOUNDS [[UIScreen mainScreen] bounds].size
#define SCREEN CGSizeMake(BOUNDS.width, BOUNDS.height)
#define CENTER CGPointMake(SCREEN.width * 0.5, SCREEN.height * 0.5) 
#define OFFSCREEN CGPointMake(-SCREEN.width, -SCREEN.height)
#define IS_RETINA() ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
#define IS_IPHONE5() ([UIScreen mainScreen].bounds.size.height == 568) 
#define IS_IPAD() ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define CURTIME CACurrentMediaTime()
#define kPointFactor (IS_IPAD() ? 2.0 : 1.0)

typedef NS_ENUM(NSInteger, ActionState) { kActionStateNone = 0, kActionStateIdle,
    kActionStateAttack, kActionStateAttackTwo, kActionStateAttackThree, kActionStateWalk,
    kActionStateRun, kActionStateRunAttack, kActionStateJumpRise, kActionStateJumpFall, kActionStateJumpLand, kActionStateJumpAttack, kActionStateHurt, kActionStateKnockedOut, kActionStateRecover, kActionStateDead, kActionStateAutomated,
};
typedef struct _ContactPoint {
    CGPoint position; CGPoint offset; CGFloat radius;
} ContactPoint;
#endif /* defined(__CyberPunch__Defines__) */
