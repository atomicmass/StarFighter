//
//  GameLayer.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/03/22.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@implementation GameLayer {
    Hero *hero;
    CGSize windowSize;
    float timeTillStar, timeElapsedSinceLastStar;
    float timeTillEnemy, timeElapsedSinceEnemy;
    float totalTime;
    CCArray *stars;
    int backgroundTime;
    CMMotionManager *motionManager;
    NSOperationQueue *operationQueue;
    float lastRoll;
    float referenceRoll;
    CCLabelTTF *label;
    int destinationX;
    BOOL *fingerDown;
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"fightersprite.plist"];
        windowSize = [[CCDirector sharedDirector] winSize];

        timeTillStar = 0.001;
        timeElapsedSinceLastStar = 0;
        backgroundTime = 70;
        totalTime = 0;
        
        timeTillEnemy = 0.05;
        timeElapsedSinceEnemy = 0;
        
        stars = [[CCArray alloc] init];
        for (int i = 0; i <= 50; i++)
        {
            CCSprite *s = [[CCSprite node] initWithSpriteFrameName:@"star.png"];
            [stars addObject:s];
            s.position = ccp(-20,-20);
            [self addChild:s];
        }
		        
        [self schedule:@selector(nextFrame:)];
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        CCSprite *bg1 = [CCSprite spriteWithFile:@"bg1-1.png"];
        CCSprite *bg2 = [CCSprite spriteWithFile:@"bg1-2.png"];
        [bg1 setAnchorPoint:ccp(0,0)];
        [bg2 setAnchorPoint:ccp(0,0)];
        [self addChild:bg1 z:-1];
        [self addChild:bg2 z:-1];
        
        bg2.position = ccp(568, 0);
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
        
        [bg1 runAction: [CCMoveTo actionWithDuration:backgroundTime position:ccp(-568, 0)]];
        [bg2 runAction: [CCMoveTo actionWithDuration:backgroundTime*2 position:ccp(-568, 0)]];
        
        hero = [[Hero alloc] initwithLayer:self];
        [self addChild:hero z:100];
        
        for (int i=0, j=0; i<=hero.health; i+=5, j++) {
            CCSprite *h = [[CCSprite node] initWithSpriteFrameName:@"health.png"];
            h.tag = 1000 + i;
            h.anchorPoint = ccp(0,0);
            h.position = ccp(j * 4 + 5, 2);
            [self addChild:h];
        }
        
        self.isTouchEnabled = YES;
        self.isAccelerometerEnabled = YES;
        
        label = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:24];
        label.anchorPoint = ccp(0,0);
        [self addChild: label];
        
        motionManager = [[CMMotionManager alloc] init];
        if ([motionManager isDeviceMotionAvailable]) {
            // to avoid using more CPU than necessary we use `CMAttitudeReferenceFrameXArbitraryZVertical`
            [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical];
        }
        
        referenceRoll = -100;
        lastRoll = -100;
	}
	return self;
}
-(void) readGyro {
    CMAttitude *attitude;
    CMDeviceMotion *motion = motionManager.deviceMotion;
    attitude = motion.attitude;
    
    if(attitude == nil) {
        return;
    }
    
    //CCLOG(@"attitude: %.2f", attitude.roll);
    if(lastRoll == -100) {
        lastRoll = attitude.roll;
    }
    
    static float q = 0.1;   // process noise
    static float r = 0.1;   // sensor noise
    static float p = 0.1;   // estimated error
    static float k = 0.5;   // kalman filter gain
    
    float x = lastRoll;
    p = p + q;
    k = p / (p + r);
    x = x + k*(attitude.roll - x);
    p = (1 - k)*p;
    lastRoll = x;
    
    //CCLOG(@"x: %.2f", x);
    
    if(referenceRoll == -100) {
        referenceRoll = x;
    }
    
    float roll = x - referenceRoll;
    
    //CCLOG(@"roll: %.2f", roll);
    [hero turn:roll];
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
   // CGPoint location = [self convertTouchToNodeSpace: touch];

    fingerDown = YES;
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    fingerDown = NO;
}

-(void) nextFrame:(ccTime)dt
{
    totalTime += dt;
    [self readGyro];
    if(fingerDown) {
        [hero fireOne:dt];
    }
    
    timeElapsedSinceEnemy += dt;
    if(timeElapsedSinceEnemy > timeTillEnemy) {
        
    }
    
    timeElapsedSinceLastStar += dt;
    if(timeElapsedSinceLastStar > timeTillStar)
    {
        CCSprite *s = nil;
        for (CCSprite *st in stars) {
            if(st.position.x == -20) {
                s = st;
                break;
            }
        }
        
        if(s != nil)
        {
            timeElapsedSinceLastStar = 0;
            timeTillStar = (arc4random() % 10) / 100.0;
            s.position = ccp(windowSize.width + 20, ((int)arc4random() % (int)(windowSize.height - 40)) + 20);
            float t = (arc4random() % 200)/100.0 + 0.5;
            s.scale = (arc4random() % 90)/90.0 + 0.1;
            [s runAction: [CCMoveBy actionWithDuration:t position:ccp(0 - windowSize.width - 40, 0)]];
        }
    }
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
