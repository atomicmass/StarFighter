//
//  EnemyFactory.h
//  StarFighter
//
//  Created by Sean Coetzee on 2013/05/07.
//
//

#import <Foundation/Foundation.h>
#import "Enemy.h"

@interface EnemyFactory : NSObject

+(Enemy *) createEnemy:(int) type;

@end
