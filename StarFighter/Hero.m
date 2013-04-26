//
//  Hero.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/03/22.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Hero.h"


@implementation Hero

@synthesize health;

- (id)init
{
    self = [super init];
    if (self) {
        self.scale  = 0.75f;
        width = height = (64.0f * 0.75f);
        windowSize = [[CCDirector sharedDirector] winSize];
        
        timeToTraverseWholeScreenY = 1.5f;
        timeToTraverseWholeScreenX = 1.0f;
        animationDelay = 1.0f/24.0f;
        correctionDistance = 10;
        correctionTime = 0.25f;
        baseY = height/2 + 30;
        health = 100;
        
        self.position = ccp(windowSize.width / 2, baseY);
//        delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  //      AppDelegate *delegate;
        [self waggle];
    }
    
    return self;
}

-(CCAnimation *)getTurnLeft
{
    NSMutableArray *anim = [[NSMutableArray alloc] init];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 4]]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 3]]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 2]]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 1]]];
    CCAnimation *a = [CCAnimation animationWithFrames:anim delay:animationDelay];
    return a;
}

-(CCAnimation *)getCorrectLeft
{
    NSMutableArray *anim = [[NSMutableArray alloc] init];
    
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 1]]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 2]]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 3]]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 4]]];
    
    CCAnimation *a = [CCAnimation animationWithFrames:anim delay:animationDelay];
    return a;
}

-(CCAnimation *)getTurnRight
{
    NSMutableArray *anim = [[NSMutableArray alloc] init];
    
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 4]]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 5]]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 6]]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 7]]];
    
    CCAnimation *a = [CCAnimation animationWithFrames:anim delay:animationDelay];
    return a;
}

-(CCAnimation *)getCorrectRight
{
    NSMutableArray *anim = [[NSMutableArray alloc] init];
    
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 7]]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 6]]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 5]]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"fighter%i.png", 4]]];
    
    CCAnimation *a = [CCAnimation animationWithFrames:anim delay:1.0f/24.0f];
    return a;
}

-(void) waggle
{
    [self runAction:[CCSequence actions:
                     [CCAnimate actionWithAnimation:[self getTurnLeft]],
                     [CCAnimate actionWithAnimation:[self getCorrectLeft]],
                     [CCAnimate actionWithAnimation:[self getTurnRight]],
                     [CCAnimate actionWithAnimation:[self getCorrectRight]],
                     nil]];
    
    isTurnedLeft = isTurnedRight = isForward = isBackward = NO;
}

-(void) turnRight
{
    if(isTurnedRight) {
        return;
    }

    [self stopActionByTag:3];
    [self stopActionByTag:1];
    CCAction *a = [CCMoveBy actionWithDuration:[self getTimeToTraverseRight] position:ccp(windowSize.width - self.position.x - width/2, 0)];
    a.tag = 1;
    [self runAction: a];
    
    if(isTurnedRight)
        return;
    
    if(isTurnedLeft)
    {
        [self runAction:[CCSequence actions:
                         [CCAnimate actionWithAnimation:[self getCorrectLeft]],
                         [CCAnimate actionWithAnimation:[self getTurnRight]],
                         nil]];
    }
    else
    {
        [self runAction: [CCAnimate actionWithAnimation:[self getTurnRight]]];
    }
    
    isTurnedRight = !(isTurnedLeft = NO);
}

-(void) turnLeft
{
    if(isTurnedLeft) {
        return;
    }

    [self stopActionByTag:3];
    [self stopActionByTag:1];
    CCAction *a = [CCMoveBy actionWithDuration:[self getTimeToTraverseLeft] position:ccp(0 - (self.position.x - width/2), 0)];
    a.tag = 1;
    [self runAction: a];
    
    if(isTurnedLeft)
        return;
 
    if(isTurnedRight)
    {
        [self runAction:[CCSequence actions:
                         [CCAnimate actionWithAnimation:[self getCorrectRight]],
                         [CCAnimate actionWithAnimation:[self getTurnLeft]],
                         nil]];
    }
    else
    {
        [self runAction: [CCAnimate actionWithAnimation:[self getTurnLeft]]];
    }
    
    isTurnedLeft = !(isTurnedRight = NO);
}

-(void) correct
{
    [self stopActionByTag:1];
    [self stopActionByTag:2];
    //[self stopActionByTag:3];
    if(isTurnedLeft)
    {
        int x = (self.position.x - correctionDistance - width/2 < 0) ? 0 : 0 - correctionDistance;
        CCAction *a = [CCMoveBy actionWithDuration:correctionTime position:ccp(x, 0)];
        a.tag = 3;
        [self runAction: a];
        [self runAction: [CCAnimate actionWithAnimation:[self getCorrectLeft]]];
    }
    if(isTurnedRight)
    {
        int x = (self.position.x + correctionDistance + width/2 > windowSize.width) ? 0 : correctionDistance;
        CCAction *a = [CCMoveBy actionWithDuration:correctionTime position:ccp(x, 0)];
        a.tag = 3;
        [self runAction: a];
        [self runAction: [CCAnimate actionWithAnimation:[self getCorrectRight]]];
    }
    
    if(isBackward)
    {
        int y = (self.position.y - correctionDistance <= baseY) ? 0 - (self.position.y - baseY) : 0 - correctionDistance;
        CCAction *a = [CCMoveBy actionWithDuration:correctionTime position:ccp(0, y)];
        a.tag = 3;
        [self runAction: a];
    }
    if(isForward)
    {
        int y = (self.position.y + correctionDistance > windowSize.height - height*2) ? windowSize.height - height*2 - self.position.y : correctionDistance;
        CCAction *a = [CCMoveBy actionWithDuration:correctionTime position:ccp(0, y)];
        a.tag = 3;
        [self runAction: a];
    }
 
    isTurnedRight = isTurnedLeft = isForward = isBackward = NO;
}

-(void) forward
{
    [self stopActionByTag:3];
    [self stopActionByTag:2];
    CCAction *a = [CCMoveBy actionWithDuration:[self getTimeToTraverseForward] position:ccp(0, windowSize.height - height*2 - self.position.y)];
    a.tag = 2;
    [self runAction: a];
    isForward = !(isBackward = NO);
}

-(void) backward
{
    [self stopActionByTag:3];
    [self stopActionByTag:2];
    CCAction *a = [CCMoveBy actionWithDuration:[self getTimeToTraverseBackward] position:ccp(0, 0 - (self.position.y - baseY))];
    a.tag = 2;
    [self runAction: a];
    isBackward = !(isForward = NO);
}

-(void) frameTick
{
}

-(float) getTimeToTraverseRight
{
    int distance = windowSize.width - self.position.x;
    return timeToTraverseWholeScreenX * (distance/windowSize.width);
}

-(float) getTimeToTraverseLeft
{
    int distance = self.position.x;
    return timeToTraverseWholeScreenX * (distance/windowSize.width);
}

-(float) getTimeToTraverseForward
{
    int distance = windowSize.height - height*2 - self.position.y;
    return timeToTraverseWholeScreenX * (distance/windowSize.height);
}

-(float) getTimeToTraverseBackward
{
    int distance = self.position.y - baseY;
    return timeToTraverseWholeScreenY * (distance/windowSize.height);
}

@end
