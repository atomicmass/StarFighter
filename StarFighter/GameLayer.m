//
//  GameLayer.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/03/22.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"

@implementation GameLayer {
    
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
        
        gyroSensitivity = 0.50;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"fightersprite.plist"];
        windowSize = [[CCDirector sharedDirector] winSize];

        timeTillStar = 0.001;
        timeElapsedSinceLastStar = 0;
        backgroundTime = 70;
        
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
        
        bg2.position = ccp(0, 568);
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
        
        [bg1 runAction: [CCMoveTo actionWithDuration:backgroundTime position:ccp(0, -568)]];
        [bg2 runAction: [CCMoveTo actionWithDuration:backgroundTime*2 position:ccp(0, -568)]];
        
        hero = [Hero node];
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
        [motionManager startDeviceMotionUpdates];
        CMDeviceMotion *deviceMotion = motionManager.deviceMotion;
        CMAttitude *attitude = deviceMotion.attitude;
        referenceAttitude = [attitude retain];
	}
	return self;
}
-(void) readGyro {
    CMAttitude *attitude;
    CMDeviceMotion *motion = motionManager.deviceMotion;
    attitude = motion.attitude;
    
    double effectiveYaw = attitude.yaw - referenceAttitude.yaw;
    double effectivePitch = attitude.pitch - referenceAttitude.pitch;
    //[label setString:[NSString stringWithFormat:@"%.2f  %.2f", attitude.yaw, effectiveYaw]];
    
    if(effectiveYaw > gyroSensitivity) {
        [hero turnLeft];
    }
    else if(effectiveYaw < 0 - gyroSensitivity) {
        [hero turnRight];
    }
    else {
        [hero correct];
    }
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
   // CGPoint location = [self convertTouchToNodeSpace: touch];

    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
}

-(void) nextFrame:(ccTime)dt
{
    [self readGyro];
    
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
            s.position = ccp(((int)arc4random() % (int)(windowSize.width - 40)) + 20, windowSize.height + 20);
            float t = (arc4random() % 200)/100.0 + 0.5;
            s.scale = (arc4random() % 90)/90.0 + 0.1;
            [s runAction: [CCMoveBy actionWithDuration:t position:ccp(0, 0 - windowSize.height - 40)]];
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
