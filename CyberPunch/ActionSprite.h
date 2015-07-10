//
//  ActionSprite.h
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/7/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Defines.h"


@interface ActionSprite : SKSpriteNode
//attachments
@property (strong, nonatomic) SKSpriteNode *shadow;

//actions
@property (strong, nonatomic) SKAction *idleAction;
@property (strong, nonatomic) SKAction *attackAction;
@property (strong, nonatomic) SKAction *walkAction;
@property (strong, nonatomic) SKAction *hurtAction;
@property (strong, nonatomic) SKAction *knockedOutAction;
@property (strong, nonatomic) SKAction *recoverAction;
@property (strong, nonatomic) SKAction *runAction;
@property (strong, nonatomic) SKAction *jumpRiseAction;
@property (strong, nonatomic) SKAction *jumpFallAction;
@property (strong, nonatomic) SKAction *jumpLandAction;
@property (strong, nonatomic) SKAction *jumpAttackAction;
@property (strong, nonatomic) SKAction *runAttackAction;
@property (strong, nonatomic) SKAction *dieAction;

//states
@property (assign, nonatomic) ActionState actionState;
@property (assign, nonatomic) CGFloat directionX;

//attributes
@property (assign, nonatomic) CGFloat walkSpeed;
@property (assign, nonatomic) CGFloat runSpeed;
@property (assign, nonatomic) CGFloat hitPoints;
@property (assign, nonatomic) CGFloat attackDamage;
@property (assign, nonatomic) CGFloat jumpAttackDamage;
@property (assign, nonatomic) CGFloat runAttackDamage;
@property (assign, nonatomic) CGFloat maxHitPoints;
@property (assign, nonatomic) CGFloat attackForce;

//movement
@property (assign, nonatomic) CGPoint velocity;
@property (assign, nonatomic) CGFloat jumpVelocity;
@property (assign, nonatomic) CGFloat jumpHeight;
@property (assign, nonatomic) CGPoint desiredPosition;
@property (assign, nonatomic) CGPoint groundPosition;

//measurements
@property (assign, nonatomic) CGFloat centerToSides;
@property (assign, nonatomic) CGFloat centerToBottom;

//collision
@property (strong, nonatomic) NSMutableArray *contactPoints;
@property (strong, nonatomic) NSMutableArray *attackPoints;
@property (assign, nonatomic) CGFloat detectionRadius;

- (CGRect)feetCollisionRect;


@end
