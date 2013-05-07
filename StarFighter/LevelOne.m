//
//  LevelOne.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/05/06.
//
//

#import "LevelOne.h"
#import "EnemyOne.h"

@implementation LevelOne

-(Level *)init {
    self = [super init];
    
    self.backgroundImage1 = @"bg1-1.png";
    self.backgroundImage2 = @"bg1-2.png";
    
    self.enemyGenerator = [[NSArray alloc] initWithObjects:
                           [[EnemyGeneration alloc] initWithStartTime:2 EndTime:10 Frequency:5 EnemyType:1],
                           nil];
    
    return self;
}

@end
