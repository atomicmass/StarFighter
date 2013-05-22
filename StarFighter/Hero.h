//
//  Hero.h
//  StarFighter
//
//  Created by Sean Coetzee on 2013/03/22.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Sprite.h"

@interface Hero : Sprite

@property int health;

-(void) turn:(double) degree;
-(void) fireOne:(float) time;
-(id) initwithLayer:(CCLayer*) newGameLayer;

@end
