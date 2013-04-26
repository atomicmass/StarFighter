//
//  EnemyController.h
//  StarFighter
//
//  Created by Sean Coetzee on 2013/04/25.
//
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface EnemyController : NSObject {
    CCLayer *_gameLayer;
    NSMutableArray *_enemies;
    
    NSArray *_spawnIntervals;
    int _currentSpawnInterval;
    
    float _lastEnemySpawnTime;
    float _nextEnemySpawnTime;
    
    float _changeSpawnIntervalGap;
    float _lastChangeIntervalTime;

}

-(id) initWithLayer:(CCLayer *) gameLayer;
-(void) tickWithTime:(float) timeElapsed;

@end
