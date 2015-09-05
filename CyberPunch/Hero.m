//
//  Hero.m
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/9/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import "Hero.h"
#import "Defines.h"
#import "SKTTextureCache.h"

@implementation Hero

- (instancetype)init
{
    SKTTextureCache *cache = [SKTTextureCache sharedInstance];
    SKTexture *texture = [cache textureNamed:@"hero_idle_00"];
    
    self = [super initWithTexture:texture];
    
    if (self)
    {
        NSMutableArray *textures =
        [self texturesWithPrefix:@"hero_idle"
                   startFrameIdx:0 frameCount:6];
        
        SKAction *idleAnimation =
        [SKAction animateWithTextures:textures
                         timePerFrame:1.0/12.0];
        
        self.idleAction =
        [SKAction repeatActionForever:idleAnimation];
        
        textures =
        [self texturesWithPrefix:@"hero_walk"
                   startFrameIdx:0 frameCount:8];
        
        SKAction *walkAnimation =
        [SKAction animateWithTextures:textures
                         timePerFrame:1.0/12.0];
        
        self.walkAction =
        [SKAction repeatActionForever:walkAnimation];
        
        self.walkSpeed = 80 * kPointFactor;
        self.directionX = 1.0;
        
        //run animation
        textures = [self texturesWithPrefix:@"hero_run"
                              startFrameIdx:0 frameCount:8];
        SKAction *runAnimation = [SKAction animateWithTextures:textures timePerFrame:1.0/12.0];
        self.runAction = [SKAction repeatActionForever:runAnimation];
        self.runSpeed = 160 * kPointFactor;
        
        textures = [self texturesWithPrefix:@"hero_attack_00" startFrameIdx:0
                                 frameCount:3];
        SKAction *attackAnimation = [SKAction animateWithTextures:textures timePerFrame:1.0/15.0];
        self.attackAction = [SKAction sequence:@[attackAnimation, [SKAction
                                               performSelector:@selector(idle) onTarget:self]]];
        
        self.centerToBottom = 39.0 * kPointFactor;
        self.centerToSides = 29.0 * kPointFactor;
        
        self.shadow = [SKSpriteNode spriteNodeWithTexture:[[SKTTextureCache sharedInstance]textureNamed:@"shadow_character"]];
        self.shadow.alpha = 0.75;
        
        //jump animation
        NSArray *jumpRiseFrames = @[[[SKTTextureCache sharedInstance] textureNamed:@"hero_jump_05"],
                                    [[SKTTextureCache sharedInstance] textureNamed:@"hero_jump_00"]];
        self.jumpRiseAction = [SKAction animateWithTextures:jumpRiseFrames timePerFrame:1.0/12.0];
        
        //fall animation
        self.jumpFallAction = [SKAction animateWithTextures:[self texturesWithPrefix:@"hero_jump" startFrameIdx:1 frameCount:4] timePerFrame:1.0/12.0];
        
        //land animation
        self.jumpLandAction = [SKAction sequence:@[[SKAction setTexture:[[SKTTextureCache sharedInstance] textureNamed:@"hero_jump_05"]], [SKAction waitForDuration:1.0/12.0], [SKAction performSelector:@selector(idle) onTarget:self]]];
        
    }
    
    return self;
}


@end
