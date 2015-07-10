//
//  TitleScene.m
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/5/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import "TitleScene.h"
#import "Defines.h"
#import "GameScene.h"
#import "SKAction+SKTExtras.h"

@implementation TitleScene

- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self setupTitle];
    }
    return self;
}

- (void)setupTitle {
    SKSpriteNode *titleBG = [SKSpriteNode spriteNodeWithImageNamed:@"bg_title"];
    titleBG.position = CENTER;
    [self addChild:titleBG];
    
    SKSpriteNode *title = [SKSpriteNode spriteNodeWithImageNamed:@"txt_title"];
    title.position = CGPointMake(CENTER.x, CENTER.y + 66 * kPointFactor);
    [self addChild:title];
    
    SKSpriteNode *start =[SKSpriteNode spriteNodeWithImageNamed:@"txt_touchtostart"];
    start.position =CGPointMake(CENTER.x, CENTER.y - 37.5 * kPointFactor);
    [self addChild:start];
    
    [titleBG setScale:kPointFactor];
    [title setScale:kPointFactor];
    [start setScale:kPointFactor];
    
    titleBG.texture.filteringMode = SKTextureFilteringNearest;
    title.texture.filteringMode = SKTextureFilteringNearest;
    start.texture.filteringMode = SKTextureFilteringNearest;
    
    start.name = @"StartText";
    SKAction *blinkAction = [SKAction blinkWithDuration:5.0 blinks:10];
    SKAction *repeatAction = [SKAction repeatActionForever:blinkAction];
    [start runAction:repeatAction];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKSpriteNode *start = (SKSpriteNode *)[self childNodeWithName:@"StartText"];
    [start removeAllActions];
    start.hidden = YES;
    GameScene *gameScene = [GameScene sceneWithSize:self.size];
    SKTransition *fade = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:gameScene transition:fade];
}

@end
