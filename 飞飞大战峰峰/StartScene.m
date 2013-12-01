//
//  MyScene.m
//  newmh
//
//  Created by meng on 13-11-3.
//  Copyright (c) 2013年 meng. All rights reserved.
//

#import "StartScene.h"
#import "GameScene.h"
@implementation StartScene
-(void) viewWillAppear:(BOOL) animated
{
    SKView *skView=(SKView*)self.view;
    
    // Create and configure the scene.
    SKScene * scene = [StartScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    //[UIApplication sharedApplication].statusBarHidden=YES;

    
}

-(void) didMoveToView:(SKView *)view
{
    if(!self.contentCreated){
        [self creatSceneContetns];
        self.contentCreated=YES;
    }
}
-(void)creatSceneContetns
{
    self.backgroundColor=[SKColor whiteColor];
    self.scaleMode=SKSceneScaleModeAspectFit;
    [self addChild:[self newHelloNode]];
    
}
-(SKLabelNode *)newHelloNode
{
    SKLabelNode *helloNode=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.text=@"飞飞大战峰峰";
    helloNode.fontColor=[SKColor brownColor];
    helloNode.fontSize = 42;
    helloNode.position=  CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    helloNode.name=@"helloNode";
    
    SKLabelNode *author=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    author.text=@"www.58mx.net";
    author.fontColor=[SKColor grayColor];
    author.fontSize=22;
    author.position=  CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-80);
    [self addChild:author];
    
    SKLabelNode *company=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    company.text=@"迈迅网络出品";
    company.fontColor=[SKColor grayColor];
    company.fontSize=22;
    company.position=  CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-40);
    [self addChild:company];

    
    SKSpriteNode *hull=[[SKSpriteNode alloc] initWithImageNamed:@"Spaceship"];
    hull.size=CGSizeMake(68, 68);
    hull.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+100);
    hull.name=@"startgame";
    [self addChild:hull];
    return helloNode;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    SKNode *helloNode = [self childNodeWithName:@"startgame"];
    if(helloNode != nil)
    {
        helloNode.name = nil;
        SKAction *moveUp = [SKAction moveByX:0 y:250.0 duration:0.5];
        SKAction *zoom = [SKAction scaleTo:2.0 duration:0.25];
        SKAction *pause = [SKAction waitForDuration:0.5];
        SKAction *fadeAway = [SKAction fadeInWithDuration:0.25];
        SKAction *remove = [SKAction removeFromParent];
        SKAction * moveSequence = [SKAction sequence:@[moveUp, zoom, pause, fadeAway,remove]];
        //[helloNode runAction:moveSequence];
        
        [helloNode runAction:moveSequence completion:^ {
            SKScene *spaceshipScene = [[GameScene alloc] initWithSize:self.size];
            
            SKTransition *doors= [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:spaceshipScene transition:doors];
        }];
    }
}


@end
