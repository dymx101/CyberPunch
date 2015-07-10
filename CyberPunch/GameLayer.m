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
        [self initTileMap:@"map_level1.tmx"]; }
    return self; }

- (void)initTileMap:(NSString *)fileName {
    self.tileMap = [JSTileMap mapNamed:fileName];
    [self.tileMap setScale:kPointFactor];
    [self addChild:self.tileMap];
}

@end
