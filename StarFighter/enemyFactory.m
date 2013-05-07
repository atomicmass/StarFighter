//
//  EnemyFactory.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/05/07.
//
//

#import "EnemyFactory.h"
#import "EnemyOne.h"

@implementation EnemyFactory

+(Enemy *)createEnemy:(int)type {
    switch (type) {
        case 1:
            return [[EnemyOne alloc] init];
            
        default:
            break;
    }
    
    return nil;
}

@end
