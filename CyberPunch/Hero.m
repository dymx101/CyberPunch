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

- (instancetype)init {
    SKTTextureCache *cache = [SKTTextureCache sharedInstance]; SKTexture *texture = [cache textureNamed:@"hero_idle_00"];
    self = [super initWithTexture:texture];
    if (self) {
        NSMutableArray *idleFrames = [NSMutableArray arrayWithCapacity:6];
        for (NSInteger i = 0; i < 6; ++i) {
            NSString *name = [NSString stringWithFormat:@"hero_idle_%02ld", (long)i];
            SKTexture *texture = [cache textureNamed:name]; [idleFrames addObject:texture];
        }
        SKAction *idleAnimation = [SKAction animateWithTextures:idleFrames timePerFrame:1.0/12.0];
        self.idleAction = [SKAction repeatActionForever:idleAnimation];
    }
    return self;
}
@end
