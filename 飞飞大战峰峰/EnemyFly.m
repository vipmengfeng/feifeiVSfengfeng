//
//  EnemyFly.m
//  飞飞大战峰峰
//
//  Created by meng on 13-11-7.
//  Copyright (c) 2013年 meng. All rights reserved.
//

#import "EnemyFly.h"

@implementation EnemyFly



-(void)removescene
{
    [self removeFromParent];
    NSString *bgmPath = [[NSBundle mainBundle] pathForResource:@"BOMB3" ofType:@"WAV"];
    self.bz = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:bgmPath] error:NULL];
    self.bz.numberOfLoops =0;
    [self.bz play];
}
@end
