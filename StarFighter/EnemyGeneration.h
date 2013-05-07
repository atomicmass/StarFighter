//
//  EnemyGeneration.h
//  StarFighter
//
//  Created by Sean Coetzee on 2013/05/06.
//
//

#import <Foundation/Foundation.h>
#import "Enemy.h"

@interface EnemyGeneration : NSObject

@property float startTime;
@property float endTime;
@property int enemyType;
@property float frequency;
@property float lastGenerationTime;

-(EnemyGeneration *) initWithStartTime:(float) st EndTime:(float) et Frequency:(float) fr EnemyType:(int) en;

@end
