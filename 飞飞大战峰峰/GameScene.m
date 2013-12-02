//
//  GameScene.m
//  飞飞大战峰峰
//
//  Created by meng on 13-11-7.
//  Copyright (c) 2013年 meng. All rights reserved.
//test 78 io

#import "GameScene.h"
#import "EnemyFly.h"
@implementation GameScene
static const uint32_t projectileCategory     =  0x1<< 0;
static const uint32_t myplaneCategory     =  0x1<< 1;
static const uint32_t giftCategory     =  0x1<< 2;
static const uint32_t monsterCategory        =  0x1<< 3;
-(id)initWithSize:(CGSize)size
{
    self=[super initWithSize:size];
    {
        self.physicsWorld.contactDelegate=self;

    }
    return self;
}
-(void)didMoveToView:(SKView *)view
{
    if(!self.contentCreatedb)
    {
        [self createSceneContentss];
        self.contentCreatedb=YES;
    }
}

-(void)createSceneContentss
{
    
    self.strong_ship=NO;
    self.check_strong=NO;
    
    self.backgroundColor=[SKColor yellowColor];
    self.scaleMode= SKSceneScaleModeAspectFit;
    self.myship=[self newSpaceship];
    self.physicsWorld.gravity=CGVectorMake(0, -0.5);//配置重力系统
    self.physicsWorld.speed=1;
    self.myfen=[self gameresult];
    [self addChild:self.myship];
    [self add_enemy];
    self.myship.physicsBody.categoryBitMask = myplaneCategory;
    self.myship.physicsBody.contactTestBitMask = monsterCategory;
    self.myship.physicsBody.collisionBitMask = 0;
    self.myship.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:[self myfen]];
    
    NSString *bgmPath = [[NSBundle mainBundle] pathForResource:@"She-is-My-Sin" ofType:@"mp3"];
    self.bgmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:bgmPath] error:NULL];
    self.bgmPlayer.numberOfLoops = -1;
    [self.bgmPlayer play];
    
}
//创建礼物
-(void) add_gift:(NSString*) pic
{
    
        SKSpriteNode *gift=[[SKSpriteNode alloc] initWithImageNamed:pic];
        gift.size=CGSizeMake(30, 30);
        gift.position = CGPointMake(skRand(0, self.size.width), self.size.height+20);
        gift.name = @"gift";
        gift.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:gift.size];
        gift.physicsBody.usesPreciseCollisionDetection = YES;
        gift.physicsBody.categoryBitMask = giftCategory; // 3
        gift.physicsBody.contactTestBitMask = myplaneCategory; // 4
        gift.physicsBody.collisionBitMask = 0; // 5
    
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeOutWithDuration:0.25],
                                           [SKAction fadeInWithDuration:0.25]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    [gift runAction: blinkForever];
    
        [self addChild:gift];
    
}

-(void)addgift
{
    [self add_gift:@"git"];
}

//子弹发射
-(void)fly_shout
{
    SKAction *movefly=[ SKAction sequence:@[
                                            [SKAction performSelector:@selector(addflys) onTarget:self],
                                            [SKAction waitForDuration:0.20 withRange:0.03]
                                            
                                            ]];
    [self runAction:[SKAction repeatActionForever:movefly]];

}

-(void)addflys
{
    SKTexture *rocketTexture = [SKTexture textureWithImageNamed:@"Spaceship"];
    
    SKSpriteNode *rocket = [SKSpriteNode spriteNodeWithTexture:rocketTexture];
   
    rocket.size=CGSizeMake(8, 8);
    rocket.name = @"rock";
    rocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rocket.size];
    rocket.physicsBody.dynamic = YES;
    rocket.physicsBody.usesPreciseCollisionDetection = YES;
    rocket.physicsBody.affectedByGravity=NO;
    SKSpriteNode *rocket2 = [SKSpriteNode spriteNodeWithTexture:rocketTexture];
   
    
    rocket2.size=CGSizeMake(8, 8);
    rocket2.name = @"rock";
    rocket2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rocket.size];
    rocket2.physicsBody.dynamic = YES;
    rocket2.physicsBody.usesPreciseCollisionDetection = YES;
    rocket2.physicsBody.affectedByGravity=NO;
    
    
    SKAction *flymove=[ SKAction sequence:@[
                                            [SKAction playSoundFileNamed:@"sj.WAV" waitForCompletion:NO],
                                            [SKAction moveByX:0 y:280 duration:0.6],
                                            [SKAction waitForDuration:0.03 withRange:0],
                                            [SKAction removeFromParent]
                                            ]];
    if(self.strong_ship==NO)
    {
        rocket2.position=CGPointMake(0, 0);
        [self.myship addChild:rocket2];
        [rocket2 runAction:flymove];
    }
    else
    {
        
        [self check_fly_strong];
        
        rocket.position=CGPointMake(10, 0);
        rocket2.position=CGPointMake(-10, 0);
        [self.myship addChild:rocket];
        [self.myship addChild:rocket2];
        [rocket runAction:flymove];
        [rocket2 runAction:flymove];
        
        
    }
    
    rocket.physicsBody.categoryBitMask = projectileCategory;
    rocket.physicsBody.contactTestBitMask = monsterCategory;
    rocket.physicsBody.collisionBitMask = 0;
    rocket.physicsBody.usesPreciseCollisionDetection = YES;
    
    rocket2.physicsBody.categoryBitMask = projectileCategory;
    rocket2.physicsBody.contactTestBitMask = monsterCategory;
    rocket2.physicsBody.collisionBitMask = 0;
    rocket2.physicsBody.usesPreciseCollisionDetection = YES;

}
-(void)check_fly_strong
{
    if(self.check_strong==YES)
    {
        self.check_strong=NO;
        
        SKAction *strong_time = [SKAction sequence: @[
                                                      [SKAction waitForDuration:15 withRange:0],
                                            [SKAction performSelector:@selector(remove_strong) onTarget:self]
                                            
                                            ]];

        
        
        [self runAction:strong_time];
    }
}

-(void)remove_strong
{
    self.strong_ship=NO;
}

//创建飞船
- (SKSpriteNode *)newSpaceship
{
    SKSpriteNode *hull=[[SKSpriteNode alloc] initWithImageNamed:@"Spaceship"];
    hull.size=CGSizeMake(48, 48);
    hull.position=CGPointMake(100, 100);
    hull.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hull.size];
    hull.physicsBody.dynamic = NO; //该物体是否有重力
    // hull.physicsBody.affectedByGravity=NO; //是否受重力影响
    [self fly_shout];
    return hull;
}


                                                                               
-(void)showenemyfly
{
    [self add_enemyfly:20 Iseasy:1 ico:@"enemy"];
}
-(void)showenemyfly_80
{
    [self add_enemyfly:80 Iseasy:8 ico:@"enemy"];
}
-(void)showenemyfly_200
{
    [self add_enemyfly:200 Iseasy:20 ico:@"enemy_2"];
}
//触摸跟随
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint shipposition=self.myship.position;
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    CGPoint previousPosition = [touch previousLocationInNode:self];
    CGPoint newCenter = CGPointMake(shipposition.x+positionInScene.x-previousPosition.x,shipposition.y+positionInScene.y-previousPosition.y);
    if(newCenter.x<0)
    {
        newCenter.x=0;
    }
    if(newCenter.x>self.size.width)
    {
        newCenter.x=self.size.width;
    }
    if(newCenter.y<0)
    {
        newCenter.y=0;
    }
    if(newCenter.y>self.size.height)
    {
        newCenter.y=self.size.height;
    }
    
    self.myship.position = newCenter;
    
}
- (SKSpriteNode *)newLight
{
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(8,8)];
    
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeOutWithDuration:0.25],
                                           [SKAction fadeInWithDuration:0.25]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    [light runAction: blinkForever];
    
    return light;
}

static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}



//随机出现敌机
-(void)add_enemy
{
    self.makeRocks = [SKAction sequence: @[
                                           [SKAction performSelector:@selector(showenemyfly)onTarget:self],
                                           [SKAction waitForDuration:0.30 withRange:0.05]
                                           ]];
    [self runAction: [SKAction repeatActionForever:self.makeRocks]];
    
    
    
    SKAction *addgift=[SKAction sequence: @[
                                            [SKAction waitForDuration:40.0 withRange:0],
                                            [SKAction performSelector:@selector(addgift) onTarget:self]
                                            
                                            ]];
    
    
    [self runAction:[SKAction repeatActionForever:addgift]];
    
    SKAction *enemy80=[SKAction sequence: @[
                                            [SKAction waitForDuration:5.30 withRange:0.02],
                                            [SKAction performSelector:@selector(showenemyfly_80) onTarget:self]
                                            
                                            ]];
    
    
    [self runAction:[SKAction repeatActionForever:enemy80]];
    
    SKAction *enemy200=[SKAction sequence: @[
                                             [SKAction waitForDuration:10.30 withRange:0.02],
                                             [SKAction performSelector:@selector(showenemyfly_200) onTarget:self]
                                             
                                             ]];
    
    
    [self runAction:[SKAction repeatActionForever:enemy200]];
}

- (void)add_enemyfly:(int) life Iseasy:(int)i ico:(NSString *)pic{
    EnemyFly *enemyfly=[[EnemyFly alloc] initWithImageNamed:pic];
        
    //SKSpriteNode *rock = [[SKSpriteNode alloc] initWithImageNamed:@"hitfly"];
    enemyfly.FlyLife=life;
    enemyfly.Iseasy=i;
    enemyfly.size=CGSizeMake((10+i)*3, (10+i)*2);
    enemyfly.position = CGPointMake(skRand(0, self.size.width), self.size.height+20);
    enemyfly.name = @"enemyflys";
    enemyfly.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:enemyfly.size];
    enemyfly.physicsBody.usesPreciseCollisionDetection = YES;
    enemyfly.physicsBody.categoryBitMask = monsterCategory; // 3
    enemyfly.physicsBody.contactTestBitMask = projectileCategory | myplaneCategory; // 4
    enemyfly.physicsBody.collisionBitMask = 0; // 5
    
    [self addChild:enemyfly];
}

//子弹和敌机以及敌机与飞船碰撞监测
- (void)projectile:(SKSpriteNode *)rocket didCollideWithMonster:(EnemyFly *)rock {
    rock.FlyLife-=20;//敌机生命削减
    if(rock.FlyLife==0)
    {
        [self playbomb];
        
        self.aNumber+=rock.Iseasy;
        self.myfen.text=[NSString stringWithFormat:@"%d", self.aNumber];
        [rock removeFromParent];
        
    }
    [rocket removeFromParent];
}


-(void)playbomb
{
    SKAction *playbomb=[SKAction playSoundFileNamed:@"BOMB3.WAV" waitForCompletion:NO];
    [self runAction:playbomb];

}

//游戏结束清除各种sprite以及动作
- (void)GameOver:(SKSpriteNode *)rocket didCollideWithMonster:(EnemyFly *)rock {
    [self playbomb];
    
    [rocket removeFromParent];
    [rock removeFromParent];
    [self removeAllActions];
    [self.bgmPlayer stop];
    [self ShowGamerOver];
}
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask< contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // 2
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & monsterCategory) != 0)
    {
        [self projectile:(SKSpriteNode *) firstBody.node didCollideWithMonster:(EnemyFly *) secondBody.node];
    }
    if ((firstBody.categoryBitMask & myplaneCategory) != 0 &&
        (secondBody.categoryBitMask & monsterCategory) != 0)
    {
        [self GameOver:(SKSpriteNode *) firstBody.node didCollideWithMonster:(EnemyFly *) secondBody.node];
    }
    if ((firstBody.categoryBitMask & myplaneCategory) != 0 &&
        (secondBody.categoryBitMask & giftCategory) != 0)
    {
        [self add_friend:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
    }
    
}

-(void)add_friend:(SKSpriteNode *)rocket didCollideWithMonster:(SKSpriteNode *)gift
{
    self.strong_ship=YES;
    self.check_strong=YES;
    [gift removeFromParent];
    
}

//显示GameOver
-(void)ShowGamerOver
{
    SKLabelNode *helloNode=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.text=@"Game Over!";
    helloNode.fontColor=[SKColor brownColor];
    helloNode.fontSize = 32;
    helloNode.position=  CGPointMake(self.size.width/2, self.size.height/2);
    helloNode.name=@"gameover";
    [self addChild:helloNode];
    
    self.replaybutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.replaybutton.frame=CGRectMake(self.size.width/2-30,  self.size.height/2+60, 60, 40);
    [self.replaybutton setTitle:@"Replay" forState:UIControlStateNormal];
    
    [self.replaybutton addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.replaybutton];
    
}
//重新开始按钮事件
-(IBAction)butClick:(id)sender
{
    [self removeAllChildren];
    [self.replaybutton removeFromSuperview];
    [self createSceneContentss];
}
//玩家分数统计
-(SKLabelNode *)gameresult
{
    self.aNumber=0;
    SKLabelNode *gameresult=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    gameresult.text=@"0";
    gameresult.fontColor=[SKColor brownColor];
    gameresult.fontSize = 22;
    gameresult.position=  CGPointMake(self.size.width-100, self.size.height-50);
    gameresult.name=@"gameresult";
    
    
    SKLabelNode *result=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    result.text=@"Result:";
    result.fontColor=[SKColor brownColor];
    result.fontSize = 18;
    result.position=  CGPointMake(self.size.width-170, self.size.height-50);
    [self addChild:result];
    return gameresult;
}

//自动销毁边界以外的敌机
-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"enemyflys" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y <0)
            [node removeFromParent];
        
    }];
    
}

@end
