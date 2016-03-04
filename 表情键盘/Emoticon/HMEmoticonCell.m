//
//  HMEmoticonCell.m
//  表情键盘
//
//  Created by 刘凡 on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMEmoticonCell.h"
#import "HMEmoticon.h"
#import "UIImage+HMEmoticon.h"

@implementation HMEmoticonCell

#pragma mark - 设置数据
- (void)setEmoticons:(NSArray<HMEmoticon *> *)emoticons {
    _emoticons = emoticons;
    
    for (UIView *v in self.contentView.subviews) {
        v.hidden = YES;
    }
    self.contentView.subviews.lastObject.hidden = NO;
    
    NSInteger index = 0;
    for (HMEmoticon *e in _emoticons) {
        UIButton *btn = self.contentView.subviews[index++];
        
        [btn setImage:[UIImage hm_imageNamed:e.imagePath] forState:UIControlStateNormal];
        [btn setTitle:e.emoji forState:UIControlStateNormal];
        
        btn.hidden = NO;
    }
}

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
        
        // 添加手势监听
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(longPressed:)];

        longPressGesture.minimumPressDuration = 0.1;
        
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}

#pragma mark - 监听方法
- (void)longPressed:(UILongPressGestureRecognizer *)recognizer {
    
    CGPoint location = [recognizer locationInView:self];
    
    // 查找选中按钮
    UIButton *button = nil;
    for (UIButton *btn in self.contentView.subviews) {
        if (CGRectContainsPoint(btn.frame, location)) {
            button = btn;
            break;
        }
    }
    if (button == nil) {
        return;
    }
    NSLog(@"%zd", button.tag);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
            
            break;
        case UIGestureRecognizerStateEnded:
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            break;
            
        default:
            break;
    }
}

- (void)clickEmoticonButton:(UIButton *)button {
    if (button == self.contentView.subviews.lastObject) {
        NSLog(@"删除");
    } else {
        NSLog(@"表情按钮 %zd", button.tag);
    }
}

#pragma mark - 设置界面
- (void)prepareUI {
    NSInteger rowCount = 3;
    NSInteger colCount = 7;
    
    CGFloat leftMargin = 8;
    CGFloat bottomMargin = 16;
    
    CGFloat w = ceil((self.bounds.size.width - 2 * leftMargin) / colCount);
    CGFloat h = ceil((self.bounds.size.height - bottomMargin) / rowCount);
    
    for (NSInteger i = 0; i < 21; i++) {
        NSInteger col = i % colCount;
        NSInteger row = i / colCount;
        
        CGRect rect = CGRectMake(col * w + leftMargin, row * h, w, h);
        UIButton *button = [[UIButton alloc] initWithFrame:rect];
        
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:32];
        
        [self.contentView addSubview:button];
        
        [button addTarget:self
                   action:@selector(clickEmoticonButton:)
         forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 删除按钮
    UIButton *button = self.contentView.subviews.lastObject;
    [button setImage:[UIImage hm_imageNamed:@"compose_emotion_delete"]
            forState:UIControlStateNormal];
    [button setImage:[UIImage hm_imageNamed:@"compose_emotion_delete_highlighted"]
            forState:UIControlStateHighlighted];
}

@end
