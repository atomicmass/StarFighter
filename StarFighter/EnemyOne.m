//
//  EnemyOne.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/04/25.
//
//

#import "EnemyOne.h"

@implementation EnemyOne

-(id)init {
    
    self = [super init];
    if (self) {
        self.scale  = 0.75f;

        timeToTraverseWholeScreenY = 1.0f;
        timeToTraverseWholeScreenX = 1.5f;
        animationDelay = 1.0f/24.0f;
    
        NSMutableArray *anim = [[NSMutableArray alloc] init];
        [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"enemy1-1.png"]];
        [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"enemy1-2.png"]];
        animation = [CCAnimation animationWithFrames:anim delay:animationDelay];
    }
}

@end
