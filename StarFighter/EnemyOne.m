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
    
    self = [super initWithSpriteFrameName:@"enemy1-1.png"];
    if (self) {
        self.scale  = 1.0f;

        self.timeToTraverseWholeScreenY = 1.0f;
        self.timeToTraverseWholeScreenX = 4.0f;
        self.animationDelay = 5.0f/24.0f;
    
        NSMutableArray *anim = [[NSMutableArray alloc] init];
        [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"enemy1-1.png"]];
        [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"enemy1-2.png"]];
        self.animation = [CCAnimation animationWithSpriteFrames:anim delay:self.animationDelay];
    }
    
    return self;
}

+(Enemy *)create {
    return [[EnemyOne alloc] init];
}

@end
