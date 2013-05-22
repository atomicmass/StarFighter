//
//  Sprite.m
//  StarFighter
//
//  Created by Sean Coetzee on 2013/05/09.
//
//

#import "Sprite.h"

@implementation Sprite

-(float) width {
    return self.contentSize.width * self.scaleX;
}

-(float) height {
    return self.contentSize.height * self.scaleY;
}

@end
