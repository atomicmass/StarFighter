//
//  Level.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/05/06.
//
//

#import "Level.h"
#import "EnemyFactory.h"

@implementation Level

@synthesize enemyGenerator, backgroundImage1, backgroundImage2;

-(Level *)init {
    self = [super init];
    return self;
}

-(Enemy *)generateEnemyAtTime:(float)time {
    for (int i=0; i < enemyGenerator.count; i++) {
        EnemyGeneration *e = [enemyGenerator objectAtIndex:i];
        if(time < e.startTime || time > e.endTime) {
            continue;
        }
        
        float gapStart = e.startTime + e.frequency * e.enemiesGenerated;
        if(time < gapStart || (e.lastGenerationTime > gapStart && e.lastGenerationTime <= gapStart + e.frequency)) {
            continue;
        }
        
        e.lastGenerationTime = time;
        e.enemiesGenerated++;
        return [EnemyFactory createEnemy:e.enemyType];
    }
    
    return nil;
}

@end
