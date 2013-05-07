//
//  EnemyController.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/04/25.
//
//

#import "EnemyController.h"

@implementation EnemyController

-(id)initWithLayer:(CCLayer *)gameLayer {
    if( (self=[super init]) ) {
        _gameLayer = gameLayer;
        
       // _spawnIntervals = [[NSArray alloc] initWithObjects:
         //                  10, , nil];
        
        
        NSMutableArray *_enemies;
        
        NSArray *_spawnIntervals;
        int _currentSpawnInterval;
        
        float _lastEnemySpawnTime;
        float _nextEnemySpawnTime;
        
        float _changeSpawnIntervalGap;
        float _lastChangeIntervalTime;

    }
    
    return self;
}

-(void)tickWithTime:(float)timeElapsed {
}

@end
