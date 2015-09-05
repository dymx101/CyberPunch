//
//  ActionSprite.m
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/7/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import "ActionSprite.h"
#import "Defines.h"
#import "SKTTextureCache.h"
#import "SKTUtils.h"

@implementation ActionSprite

- (void)idle
{
    if (self.actionState != kActionStateIdle) {
        
        [self removeAllActions];
        [self runAction:self.idleAction];
        self.velocity = CGPointZero;
        self.actionState = kActionStateIdle;
    }
}

- (NSMutableArray *)texturesWithPrefix:(NSString *)prefix
                         startFrameIdx:(NSInteger)startFrameIdx
                            frameCount:(NSInteger)frameCount
{
    
    NSInteger idxCount = frameCount + startFrameIdx;
    NSMutableArray *textures =
    [NSMutableArray arrayWithCapacity:frameCount];
    
    SKTexture *texture;
    
    for (NSInteger i = startFrameIdx; i < idxCount; i++) {
        
        NSString *name =
        [NSString stringWithFormat:@"%@_%02ld", prefix, (long)i];
        
        texture = [[SKTTextureCache sharedInstance]
                   textureNamed:name];
        
        [textures addObject:texture];
    }
    
    return textures;
}

- (void)walkWithDirection:(CGPoint)direction
{
    if (self.actionState == kActionStateIdle ||
        self. actionState == kActionStateRun) {
        
        [self removeAllActions];
        [self runAction:self.walkAction];
        self.actionState = kActionStateWalk;
        [self moveWithDirection:direction];
        
    } else if (self.actionState == kActionStateWalk) {
        [self moveWithDirection:direction];
    }
}

- (void)moveWithDirection:(CGPoint)direction
{
    if (self.actionState == kActionStateWalk) {
        
        self.velocity = CGPointMake(direction.x * self.walkSpeed,
                                    direction.y * self.walkSpeed);
        [self flipSpriteForVelocity:self.velocity];
        
    } else if (self.actionState == kActionStateRun) {
        
        self.velocity = CGPointMake(direction.x * self.runSpeed,
                                    direction.y * self.runSpeed);
        [self flipSpriteForVelocity:self.velocity];
        
    } else if (self.actionState == kActionStateIdle) {
        
        [self walkWithDirection:direction];
    }
}

- (void)flipSpriteForVelocity:(CGPoint)velocity
{
    if (velocity.x > 0) {
        self.directionX = 1.0;
    } else if (velocity.x < 0) {
        self.directionX = -1.0;
    }
    
    self.xScale = self.directionX * kPointFactor;
}

- (void)update:(NSTimeInterval)delta
{
    if (self.actionState == kActionStateWalk ||
        self.actionState == kActionStateRun) {
        CGPoint point = CGPointMultiplyScalar(self.velocity, delta);
        self.desiredPosition = CGPointAdd(self.groundPosition, point);
    } else if (self.actionState == kActionStateJumpRise) {
        CGPoint point = CGPointMultiplyScalar(self.velocity, delta);
        self.desiredPosition = CGPointAdd(self.groundPosition, point);
        self.jumpVelocity -= kGravity * delta;
        self.jumpHeight += self.jumpVelocity * delta;
        
        if (self.jumpVelocity <= kJumpForce/2) {
            [self jumpFall];
        }
    } else if (self.actionState == kActionStateJumpFall) {
        CGPoint point = CGPointMultiplyScalar(self.velocity, delta);
        self.desiredPosition = CGPointAdd(self.groundPosition, point);
        
        self.jumpVelocity -= kGravity * delta;
        self.jumpHeight += self.jumpVelocity * delta;
        
        if (self.jumpHeight <= 0) {
            [self jumpLand];
        }
    }
}

- (CGRect)feetCollisionRect
{
    CGRect feetRect =
    CGRectMake(self.desiredPosition.x - self.centerToSides,
               self.desiredPosition.y - self.centerToBottom,
               self.centerToSides * 2,
               5.0 * kPointFactor);
    
    return CGRectInset(feetRect, 15.0 * kPointFactor, 0);
}

- (void)runWithDirection:(CGPoint)direction
{
    if (self.actionState == kActionStateIdle ||
        self.actionState == kActionStateWalk) {
        
        [self removeAllActions];
        [self runAction:self.runAction];
        self.actionState = kActionStateRun;
        [self moveWithDirection:direction];
    }
}

- (void)attack {
    if (self.actionState == kActionStateIdle || self.actionState == kActionStateWalk || self.actionState == kActionStateAttack) {
        [self removeAllActions];
        [self runAction:self.attackAction];
        self.actionState = kActionStateAttack;
    }
}

- (void)setGroundPosition:(CGPoint)groundPosition
{
    _groundPosition = groundPosition;
    self.shadow.position =
        CGPointMake(groundPosition.x,
                    groundPosition.y - self.centerToBottom);
}

-(void)jumpRiseWithDirection:(CGPoint)direction
{
    if (self.actionState == kActionStateIdle) {
        [self jumpRise];
    }
    else if (self.actionState == kActionStateWalk || self.actionState == kActionStateJumpLand) {
        self.velocity = CGPointMake(direction.x * self.walkSpeed,
                                    direction.y * self.walkSpeed);
        [self flipSpriteForVelocity:self.velocity];
        [self jumpRise];
    }
    else if (self.actionState == kActionStateRun) {
        self.velocity = CGPointMake(direction.x * self.runSpeed,
                                    direction.y * self.walkSpeed);
        [self flipSpriteForVelocity:self.velocity];
        [self jumpRise];
    }
}

-(void)jumpRise
{
    if (self.actionState == kActionStateIdle ||
        self.actionState == kActionStateWalk ||
        self.actionState == kActionStateRun ||
        self.actionState == kActionStateJumpLand) {
        [self removeAllActions];
        [self runAction: self.jumpRiseAction];
        self.jumpVelocity = kJumpForce;
        self.actionState = kActionStateJumpRise;
    }
}

-(void)jumpCutoff
{
    if (self.actionState == kActionStateJumpRise) {
        if (self.jumpVelocity > kJumpCutoff) {
            self.jumpVelocity = kJumpCutoff;
        }
    }
}

-(void)jumpFall
{
    if (self.actionState == kActionStateJumpRise ||
        self.actionState == kActionStateJumpAttack) {
        self.actionState = kActionStateJumpFall;
        [self runAction: self.jumpFallAction];
    }
}

-(void)jumpLand
{
    if (self.actionState == kActionStateJumpFall ||
        self.actionState == kActionStateRecover) {
        self.jumpHeight = 0;
        self.jumpVelocity = 0;
        self.actionState = kActionStateJumpLand;
        [self runAction:self.jumpLandAction];
    }
}



@end
