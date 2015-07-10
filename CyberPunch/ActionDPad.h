//
//  ActionDPad.h
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/9/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Defines.h"

typedef NS_ENUM(NSInteger, ActionDPadDirection) {
    kActionDPadDirectionCenter = 0,
    kActionDPadDirectionUp,
    kActionDPadDirectionUpRight,
    kActionDPadDirectionRight,
    kActionDPadDirectionDownRight,
    kActionDPadDirectionDown,
    kActionDPadDirectionDownLeft,
    kActionDPadDirectionLeft,
    kActionDPadDirectionUpLeft
};

@class ActionDPad;

@protocol ActionDPadDelegate <NSObject>

- (void)actionDPad:(ActionDPad *)actionDPad
didChangeDirectionTo:(ActionDPadDirection)direction;

- (void)actionDPad:(ActionDPad *)actionDPad
isHoldingDirection:(ActionDPadDirection)direction;

- (void)actionDPadTouchEnded:(ActionDPad *)actionDPad;

@end

@interface ActionDPad : SKSpriteNode

@property (assign, nonatomic) ActionDPadDirection direction;
@property (weak, nonatomic) id <ActionDPadDelegate> delegate;
@property (assign, nonatomic) BOOL isHeld;

+ (instancetype)dPadWithPrefix:(NSString *)filePrefix
                        radius:(CGFloat)radius;
- (instancetype)initWithPrefix:(NSString *)filePrefix
                        radius:(CGFloat)radius;

- (void)update:(NSTimeInterval)delta;

@end
