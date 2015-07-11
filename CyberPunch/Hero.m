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
        
        self.centerToBottom = 39.0 * kPointFactor;
        self.centerToSides = 29.0 * kPointFactor;
        
    }
    
    return self;
}


@end
