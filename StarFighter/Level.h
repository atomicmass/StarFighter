//
//  Level.h
//  StarFighter
//
//  Created by Sean Coetzee on 2013/05/06.
//
//

#import <Foundation/Foundation.h>
#import "EnemyGeneration.h"
#import "Enemy.h"

@interface Level : NSObject

@property (strong) NSString *backgroundImage1;
@property (strong) NSString *backgroundImage2;
@property (strong) NSArray *enemyGenerator;

-(Level *) init;
-(Enemy *) generateEnemyAtTime:(float) time;

@end
