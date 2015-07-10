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

@implementation GameScene

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"sprites"];
        [[SKTTextureCache sharedInstance] addTexturesFromAtlas:atlas filteringMode:SKTextureFilteringNearest];
        
        GameLayer *gameLayer = [GameLayer node];
        [self addChild:gameLayer];
        
        HudLayer *hudLayer = [HudLayer node];
        [self addChild:hudLayer];
        
        [[SKTTextureCache sharedInstance] setEnableFallbackSuffixes:YES];
        atlas = [SKTextureAtlas atlasNamed:@"joypad"];
        
        [[SKTTextureCache sharedInstance]
         
         addTexturesFromAtlas:atlas filteringMode:SKTextureFilteringLinear];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
