//
//  GameScene.h
//  飞飞大战峰峰
//
//  Created by meng on 13-11-7.
//  Copyright (c) 2013年 meng. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
@interface GameScene : SKScene<SKPhysicsContactDelegate>
@property BOOL contentCreatedb;
@property (nonatomic) SKSpriteNode *myship;
@property (nonatomic) SKLabelNode *myfen;
@property int aNumber;
@property NSString *aString;
@property SKAction *makeRocks;
@property UIButton *replaybutton;
@property int hittwo;
@property (nonatomic, strong) AVAudioPlayer *bgmPlayer;
@property BOOL strong_ship;   //是否开启增强射击模式
@property BOOL check_strong;

@end
