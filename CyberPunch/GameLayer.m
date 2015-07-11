//
//  GameLayer.m
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/7/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import "GameLayer.h"
#import "Defines.h"
#import "SKTUtils.h"


@implementation GameLayer

- (instancetype)init
{
    if (self = [super init])
    {
        [self initTileMap:@"map_level1.tmx"];
        [self initHero];
    }
    return self;
}

- (void)initHero
{
    self.hero = [Hero node];
    
    [self.hero setScale:kPointFactor];
    self.hero.position = CGPointMake(100 * kPointFactor,
                                     100 * kPointFactor);
    
    [self addChild:self.hero];
    [self.hero idle];
}

- (void)initTileMap:(NSString *)fileName
{
    self.tileMap = [JSTileMap mapNamed:fileName];
    [self.tileMap setScale:kPointFactor];
    [self addChild:self.tileMap];
}

- (void)actionDPad:(ActionDPad *)actionDPad
didChangeDirectionTo:(ActionDPadDirection)direction
{
    CGPoint directionVector = [self vectorForDirection:direction];
    [self.hero walkWithDirection:directionVector];
}

- (void)actionDPad:(ActionDPad *)actionDPad
isHoldingDirection:(ActionDPadDirection)direction
{
    CGPoint directionVector = [self vectorForDirection:direction];
    [self.hero moveWithDirection:directionVector];
}

- (void)actionDPadTouchEnded:(ActionDPad *)actionDPad
{
    if (self.hero.actionState == kActionStateWalk ||
        self.hero.actionState == kActionStateRun) {
        [self.hero idle];
    }
}

- (CGPoint)vectorForDirection:(ActionDPadDirection)direction
{
    CGFloat maxX = 1.0;
    CGFloat maxY = 0.75;
    
    switch (direction) {
        case kActionDPadDirectionCenter:
            return CGPointZero;
            break;
        case kActionDPadDirectionUp:
            return CGPointMake(0.0, maxY);
            break;
        case kActionDPadDirectionUpRight:
            return CGPointMake(maxX, maxY);
            break;
        case kActionDPadDirectionRight:
            return CGPointMake(maxX, 0.0);
            break;
        case kActionDPadDirectionDownRight:
            return CGPointMake(maxX, -maxY);
            break;
        case kActionDPadDirectionDown:
            return CGPointMake(0.0, -maxY);
            break;
        case kActionDPadDirectionDownLeft:
            return CGPointMake(-maxX, -maxY);
            break;
        case kActionDPadDirectionLeft:
            return CGPointMake(-maxX, 0.0);
            break;
        case kActionDPadDirectionUpLeft:
            return CGPointMake(-maxX, maxY);
            break;
        default:
            return CGPointZero;
            break;
    }
}

- (void)update:(NSTimeInterval)delta
{
    [_hero update:delta];
    [self updatePositions];
    [self setViewpointCenter:self.hero.position];
}

- (void)updatePositions
{
    CGFloat mapWidth =
    self.tileMap.mapSize.width *
    self.tileMap.tileSize.width *
    kPointFactor;
    
    CGFloat floorHeight =
    3 * self.tileMap.tileSize.height * kPointFactor;
    
    CGFloat posX = MIN(mapWidth - self.hero.feetCollisionRect.size.width/2, MAX(self.hero.feetCollisionRect.size.width/2, self.hero.desiredPosition.x));
    
    CGFloat posY = MIN(floorHeight + (self.hero.centerToBottom - self.hero.feetCollisionRect.size.height), MAX(self.hero.centerToBottom, self.hero.desiredPosition.y));
    
    self.hero.position = CGPointMake(posX, posY);
}
- (void)setViewpointCenter:(CGPoint)position {
    
    NSInteger x = MAX(position.x, CENTER.x);
    NSInteger y = MAX(position.y, CENTER.y);
    
    x = MIN(x, (self.tileMap.mapSize.width *    self.tileMap.tileSize.width * kPointFactor)
            - CENTER.x);
    
    y = MIN(y, (self.tileMap.mapSize.height * self.tileMap.tileSize.height * kPointFactor)
            - CENTER.y);
    
    CGPoint actualPosition = CGPointMake(x, y);
    CGPoint viewPoint = CGPointSubtract(CENTER, actualPosition);
    
    self.position = viewPoint;
}

@end


