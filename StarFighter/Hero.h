//
//  Hero.h
//  StarFighter
//
//  Created by Sean Coetzee on 2013/03/22.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Hero : CCSprite {
    BOOL *isTurnedLeft, *isTurnedRight, *isForward, *isBackward;
    CGSize windowSize;
    int width, height;
    float timeToTraverseWholeScreenY, timeToTraverseWholeScreenX, animationDelay, correctionTime;
    int correctionDistance;
    int baseY;
}

@property int health;

-(CCAnimation *)getTurnLeft;
-(CCAnimation *)getCorrectLeft;
-(CCAnimation *)getTurnRight;
-(CCAnimation *)getCorrectRight;
-(void) waggle;
-(void) turnLeft;
-(void) turnRight;
-(void) correct;
-(void) frameTick;
-(float) getTimeToTraverseLeft;
-(float) getTimeToTraverseRight;
-(float) getTimeToTraverseForward;
-(float) getTimeToTraverseBackward;
-(void) forward;
-(void) backward;

@end
