//
//  MainMenu.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/03/22.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "GameLayer.h"


@implementation MainMenu

-(id) init
{
    CCMenuItemImage *menuItem1 = [CCMenuItemImage
                                  itemWithNormalImage:@"myfirstbutton.png"
                                  selectedImage: @"myfirstbutton_selected.png"
                                  target:self
                                  selector:@selector(doSomething:)];
    
    CCMenuItemImage *menuItem2 = [CCMenuItemImage
                                  itemWithNormalImage:@"mysecondbutton.png"
                                  selectedImage: @"mysecondbutton_selected.png"
                                  target:self
                                  selector:@selector(doSomething:)];
    
    CCMenu *menu = [CCMenu menuWithItems:menuItem1, menuItem2, nil];
    [menu alignItemsVerticallyWithPadding:20];
    [self addChild:menu];
    
    return self;
}

-(void) doSomething:(CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.25f scene:[GameLayer scene]]];
}

@end
