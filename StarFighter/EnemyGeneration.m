//
//  EnemyGeneration.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/05/06.
//
//

#import "EnemyGeneration.h"

@implementation EnemyGeneration

@synthesize startTime, endTime, enemyType, frequency, lastGenerationTime, enemiesGenerated;

-(EnemyGeneration *)initWithStartTime:(float)st EndTime:(float)et Frequency:(float)fr EnemyType:(int)en {
    self = [super init];
    
    self.startTime = st;
    self.endTime = et;
    self.frequency = fr;
    self.enemyType = en;
    
    self.enemiesGenerated = 0;
    self.lastGenerationTime = -1;
    
    return self;
}

@end
