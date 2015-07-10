//
//  GameLayer.h
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/7/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "JSTileMap.h"

@interface GameLayer : SKNode

@property (strong, nonatomic) JSTileMap *tileMap;

@end
