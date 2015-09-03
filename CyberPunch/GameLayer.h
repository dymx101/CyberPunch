//
//  GameLayer.h
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/7/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "JSTileMap.h"
#import "Hero.h"
#import "HudLayer.h"


@interface GameLayer : SKNode <ActionDPadDelegate, ActionButtonDelegate>

@property (strong, nonatomic) JSTileMap *tileMap;
@property (strong, nonatomic) Hero *hero;
@property (weak, nonatomic) HudLayer *hud;

- (void)update:(NSTimeInterval)delta;

@end
