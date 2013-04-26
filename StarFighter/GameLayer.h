//
//  GameLayer.h
//  StarFighter
//
//  Created by Sean Coetzee on 2013/03/22.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "cocos2d.h"
#import "Hero.h"

@interface GameLayer : CCLayer {
    Hero *hero;
    CGSize windowSize;
    float timeTillStar, timeElapsedSinceLastStar;
    float timeTillEnemy, timeElapsedSinceEnemy;
    CCArray *stars;
    int backgroundTime;
    CMMotionManager *motionManager;
    NSOperationQueue *operationQueue;
    CMAttitude *referenceAttitude;
    CCLabelTTF *label;
    double gyroSensitivity;
}

+(CCScene *) scene;

@end
