//
//  Enemy.h
//  StarFighter
//
//  Created by Sean Coetzee on 2013/04/25.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Sprite.h"

@interface Enemy : Sprite
@property (strong) CCAnimation *animation;
@property float timeToTraverseWholeScreenY, timeToTraverseWholeScreenX, animationDelay;

-(void) spawn;
+(Enemy *) create;

@end
