//
//  EnemyFly.h
//  飞飞大战峰峰
//
//  Created by meng on 13-11-7.
//  Copyright (c) 2013年 meng. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
@interface EnemyFly : SKSpriteNode
@property int FlyLife;           //战机生命值
@property int Iseasy;            //积分增加系数
@property (nonatomic, strong) AVAudioPlayer *bz;
-(void)removescene;
@end
