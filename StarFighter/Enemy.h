//
//  Enemy.h
//  StarFighter
//
//  Created by Sean Coetzee on 2013/04/25.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Enemy : CCSprite {
    CCAnimation *animation;
    float timeToTraverseWholeScreenY, timeToTraverseWholeScreenX, animationDelay;

}

-(void) spawn;

@end
