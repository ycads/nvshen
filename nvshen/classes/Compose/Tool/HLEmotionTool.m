//
//  HLEmotionTool.m
//
//  Created by apple on 14-10-23.
//  Copyright (c) 2014年 HOOLANG. All rights reserved.
//

// 最近表情的存储路径
#define HLRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

#import "HLEmotionTool.h"
#import "HLEmotion.h"

@implementation HLEmotionTool

static NSMutableArray *_recentEmotions;

+ (void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:HLRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

+ (void)addRecentEmotion:(HLEmotion *)emotion
{
    // 删除重复的表情
    [_recentEmotions removeObject:emotion];
    
    // 将表情放到数组的最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:HLRecentEmotionsPath];
}

/**
 *  返回装着HWEmotion模型的数组
 */
+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}
// 加载沙盒中的表情数据
//    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
//    if (emotions == nil) {
//        emotions = [NSMutableArray array];
//    }

//    [emotions removeObject:emotion];
//    for (int i = 0; i<emotions.count; i++) {
//        HWEmotion *e = emotions[i];
//
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
//            [emotions removeObject:e];
//            break;
//        }
//    }

//    for (HWEmotion *e in emotions) {
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
//            [emotions removeObject:e];
//            break;
//        }
//    }
@end
