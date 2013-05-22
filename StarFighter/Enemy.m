//
//  Enemy.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/04/25.
//
//

#import "Enemy.h"

@implementation Enemy

@synthesize animation, timeToTraverseWholeScreenX, timeToTraverseWholeScreenY, animationDelay;

-(void)spawn {
    
}

+(Enemy *)create {
    return [[Enemy alloc] init];
}

@end
