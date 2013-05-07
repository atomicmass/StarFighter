//
//  Hero.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/03/22.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Hero.h"
#import "cocos2d.h"

@implementation Hero {
    CCLayer *gameLayer;
    CCArray *lasers;
    CGSize windowSize;
    int width, height;
    float timeToTraverseWholeScreenY, animationDelay, correctionTime, laserTime;
    int correctionDistance;
    int homeX, homeY;
    double gyroSensitivity;
    double maxGyro;
    int maxY, minY;
    BOOL isTurning, isTurnedUp, isTurnedDown;
    float fireOneCount;
    float fireOneCountLimit;
}


@synthesize health;

- (id)initwithLayer:(CCLayer *)newGameLayer
{
    self = [super init];
    if (self) {
        self.scale  = 0.75f;
        width = height = (64.0f * 0.75f);
        windowSize = [[CCDirector sharedDirector] winSize];
        
        timeToTraverseWholeScreenY = 1.0f;
        animationDelay = 1.0f/24.0f;
        correctionDistance = 10;
        correctionTime = 0.25f;
        laserTime = 0.5f;
        
        health = 100;
        gyroSensitivity = 0.15;
        maxGyro = 0.5;
        
        maxY = windowSize.height - height/2;
        minY = height/2;
        
        homeY = windowSize.height / 2;
        homeX = width/2 + 40;
        
        self.position = ccp(homeX, homeY);
        
        isTurning = isTurnedUp = isTurnedDown = NO;
        
        fireOneCount = 0;
        fireOneCountLimit = 0.1;
        
        gameLayer = newGameLayer;
        lasers = [[CCArray alloc] init];
        for (int i = 0; i <= 20; i++)
        {
            CCSprite *s = [[CCSprite node] initWithSpriteFrameName:@"laser.png"];
            [lasers addObject:s];
            s.position = ccp(windowSize.width + 20, -20);
            [gameLayer addChild:s];
        }
        
        [self waggle];
    }
    
    return self;
}

-(void) waggle
{
    id turnDown = [CCAnimate actionWithAnimation:[self getTurnDown]];
    id turnUp = [CCAnimate actionWithAnimation:[self getTurnUp]];
    id correctDown = [CCAnimate actionWithAnimation:[self getCorrectDown]];
    id correctUp = [CCAnimate actionWithAnimation:[self getCorrectUp]];
    [self runAction:[CCSequence actions:
                     turnUp,
                     correctUp,
                     turnDown,
                     correctDown,
                     nil]];
}

-(CCAnimation *)getTurnUp
{
    NSMutableArray *anim = [[NSMutableArray alloc] init];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter4.png"]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter3.png"]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter2.png"]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter1.png"]];
    CCAnimation *a = [CCAnimation animationWithFrames:anim delay:animationDelay];
    return a;
}

-(CCAnimation *)getCorrectUp
{
    NSMutableArray *anim = [[NSMutableArray alloc] init];
    
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter1.png"]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter2.png"]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter3.png"]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter4.png"]];
    
    CCAnimation *a = [CCAnimation animationWithFrames:anim delay:animationDelay];
    return a;
}

-(CCAnimation *)getTurnDown
{
    NSMutableArray *anim = [[NSMutableArray alloc] init];
    
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter4.png"]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter5.png"]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter6.png"]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter7.png"]];
    
    CCAnimation *a = [CCAnimation animationWithFrames:anim delay:animationDelay];
    return a;
}

-(CCAnimation *)getCorrectDown
{
    NSMutableArray *anim = [[NSMutableArray alloc] init];
    
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter7.png"]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter6.png"]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter5.png"]];
    [anim addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"fighter4.png"]];
    
    CCAnimation *a = [CCAnimation animationWithFrames:anim delay:1.0f/24.0f];
    return a;
}

-(void) beginTurn {
    isTurning = YES;
    isTurnedUp = isTurnedDown = NO;
}

-(void) endTurnUp {
    isTurning = NO;
    isTurnedUp = YES;
    isTurnedDown = NO;
}

-(void) endTurnDown {
    isTurning = NO;
    isTurnedUp = NO;
    isTurnedDown = YES;
}

-(void) endCorrect {
    isTurning = NO;
    isTurnedDown = NO;
    isTurnedUp = NO;
}

-(void) turnDown {
    if(isTurnedDown) {
        return;
    }
    
    id anim = [CCAnimate actionWithAnimation:[self getTurnDown]];
    id t1 = [CCCallFunc actionWithTarget:self selector:@selector(beginTurn)];
    id t2 = [CCCallFunc actionWithTarget:self selector:@selector(endTurnDown)];
    CCAction *a = [CCSequence actions: t1, anim, t2, nil];
    a.tag = 10;
    [self stopActionByTag:10];
    [self runAction:a];
    
    float time = ((self.position.y - minY) / windowSize.height) * timeToTraverseWholeScreenY;
    CCAction *m = [CCMoveTo actionWithDuration:time position:ccp(homeX, minY)];
    m.tag = 10;
    [self runAction:m];
}

-(void) turnUp {
    if(isTurnedUp) {
        return;
    }
    
    id anim = [CCAnimate actionWithAnimation:[self getTurnUp]];
    id t1 = [CCCallFunc actionWithTarget:self selector:@selector(beginTurn)];
    id t2 = [CCCallFunc actionWithTarget:self selector:@selector(endTurnUp)];
    CCAction *a = [CCSequence actions: t1, anim, t2, nil];
    a.tag = 10;
    [self stopActionByTag:10];
    [self runAction:a];
    
    float time = ((maxY - self.position.y) / windowSize.height) * timeToTraverseWholeScreenY;
    CCAction *m = [CCMoveTo actionWithDuration:time position:ccp(homeX, maxY)];
    m.tag = 10;
    [self runAction:m];
}

-(CCSprite *)getFreeLaser {
    for (CCSprite *s in lasers) {
        if(s.position.x == windowSize.width + 20) {
            return s;
        }
    }
    return nil;
}

-(void) fireOne:(float)time {
    fireOneCount = fireOneCount - time;
    if(fireOneCount > 0) {
        return;
    }
    
    fireOneCount = fireOneCountLimit;
    int endX = windowSize.width + 20 - self.position.x;
    
    CCSprite *l1 = [self getFreeLaser];
    if(l1 != nil) {
        l1.position = ccp(self.position.x, self.position.y + 10);
        [l1 runAction:[CCMoveBy actionWithDuration:laserTime position:ccp(endX, 0)]];
    }
    
    CCSprite *l2 = [self getFreeLaser];
    if(l2 != nil) {
        l2.position = ccp(self.position.x, self.position.y - 10);
        [l2 runAction:[CCMoveBy actionWithDuration:laserTime position:ccp(endX, 0)]];
    }
}

-(void) correct {
    id anim = nil;
    
    if(isTurnedDown) {
        anim = [CCAnimate actionWithAnimation:[self getCorrectDown]];
    }
    
    if(isTurnedUp) {
        anim = [CCAnimate actionWithAnimation:[self getCorrectUp]];
    }
    
    if(anim == nil) {
        return;
    }
    
    id t1 = [CCCallFunc actionWithTarget:self selector:@selector(beginTurn)];
    id t2 = [CCCallFunc actionWithTarget:self selector:@selector(endCorrect)];
    CCAction *a = [CCSequence actions: t1, anim, t2, nil];
    a.tag = 10;
    [self stopActionByTag:10];
    [self runAction:a];
}

-(void) turn:(double)degree {
    if(isTurning) {
        return;
    }
    
    if(degree >= 0 - gyroSensitivity && degree <= gyroSensitivity) {
        [self correct];
        return;
    }
    
    if(degree > 0) {
        [self turnDown];
        return;
    }
    
    if(degree < 0) {
        [self turnUp];
        return;
    }
}

@end
