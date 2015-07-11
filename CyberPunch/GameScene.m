//
//  GameScene.m
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/5/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import "GameScene.h"
#import "Defines.h"
#import "GameLayer.h"
#import "HudLayer.h"
#import "SKTTextureCache.h"


@interface GameScene()

@property (strong, nonatomic) GameLayer *gameLayer;
@property (strong, nonatomic) HudLayer *hudLayer;
@property (assign, nonatomic) NSTimeInterval lastUpdateTime;

@end

@implementation GameScene

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        SKTextureAtlas *atlas =
        [SKTextureAtlas atlasNamed:@"sprites"];
        
        [[SKTTextureCache sharedInstance]
         addTexturesFromAtlas:atlas
         filteringMode:SKTextureFilteringNearest];
        
        [[SKTTextureCache sharedInstance]
         setEnableFallbackSuffixes:YES];
        
        atlas = [SKTextureAtlas atlasNamed:@"joypad"];
        
        [[SKTTextureCache sharedInstance]
         addTexturesFromAtlas:atlas
         filteringMode:SKTextureFilteringLinear];
        
        _gameLayer = [GameLayer node];
//        [self addChild:_gameLayer];
        
        _hudLayer = [HudLayer node];
        [self addChild:_hudLayer];
        
        _hudLayer.dPad.delegate = _gameLayer;
        _gameLayer.hud = _hudLayer;
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
    if (self.lastUpdateTime <= 0) {
        self.lastUpdateTime = currentTime;
    }
    
    NSTimeInterval delta = currentTime - self.lastUpdateTime;
    self.lastUpdateTime = currentTime;
    
    [self.gameLayer update:delta];
    [self.hudLayer update:delta];
}


@end