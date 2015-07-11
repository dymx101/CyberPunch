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
    if (self.actionState == kActionStateWalk) {
        CGPoint point = CGPointMultiplyScalar(self.velocity, delta);
        self.desiredPosition = CGPointAdd(self.position, point);
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


@end
