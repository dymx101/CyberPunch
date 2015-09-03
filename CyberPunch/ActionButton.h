//
//  ActionButton.h
//  CyberPunch
//
//  Created by Pedro Ruíz on 7/11/15.
//  Copyright (c) 2015 Pedro Ruíz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Defines.h"
#import "SKTUtils.h"

@class ActionButton;

@protocol ActionButtonDelegate <NSObject>

- (void)actionButtonWasPressed:(ActionButton *)actionButton;
- (void)actionButtonIsHeld:(ActionButton *)actionButton;
- (void)actionButtonWasReleased:(ActionButton *)actionButton;

@end

@interface ActionButton : SKSpriteNode

@property (weak, nonatomic) id <ActionButtonDelegate> delegate;
@property (assign, nonatomic) BOOL isHeld;

+ (instancetype)buttonWithPrefix:(NSString *)filePrefix
                          radius:(CGFloat)radius;

- (instancetype)initWithPrefix:(NSString *)filePrefix
                        radius:(CGFloat)radius;

- (void)update:(NSTimeInterval)delta;

@end
