//
//  GameLayer.m
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/7/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import "GameLayer.h"
#import "Defines.h"

@implementation GameLayer

- (instancetype)init {
    if (self = [super init]) {
        [self initTileMap:@"map_level1.tmx"];
        [self initHero];
    }
    return self; }

- (void)initTileMap:(NSString *)fileName {
    self.tileMap = [JSTileMap mapNamed:fileName];
    [self.tileMap setScale:kPointFactor];
    [self addChild:self.tileMap];
}

- (void)initHero {
    self.hero = [Hero node];
    [self.hero setScale:kPointFactor];
    self.hero.position = CGPointMake(100 * kPointFactor, 100 * kPointFactor);
    [self addChild:self.hero];
    [self.hero idle];
}

@end
