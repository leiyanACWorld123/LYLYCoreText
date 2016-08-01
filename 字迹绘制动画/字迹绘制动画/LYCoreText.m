//
//  LYCoreText.m
//  字迹绘制动画
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 雷晏. All rights reserved.
//

#import "LYCoreText.h"
#import <CoreText/CoreText.h>

@interface LYCoreText()
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@end


@implementation LYCoreText

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self setGradientLayer];
        [self setPathLayer];
        
    }
    return self;
}

-(void)setGradientLayer{
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = self.bounds;
    _gradientLayer.startPoint = CGPointMake(0, 0.5);
    _gradientLayer.endPoint = CGPointMake(1, 0.5);
    [self.layer addSublayer: _gradientLayer];
}

-(void)setPathLayer{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.position = _gradientLayer.position;
    _shapeLayer.geometryFlipped = YES;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineWidth = 1;
    _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
}

-(UIBezierPath *)bezierPathFrom:(NSString *)string font:(CGFloat)font
{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    //创建字形
    CTFontRef fontRef = CTFontCreateWithName(CFSTR("HelveticaNeue"), font, NULL);
    
    NSDictionary *attrs = @{(__bridge id)kCTFontAttributeName:(__bridge id)fontRef};
    
    //根据字形得到富文本
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string
                                                                     attributes:attrs];
    //根据富文本得到字迹
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    
    //获取所有字迹用数组存起来
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    //遍历字迹
    for(CFIndex runIndex = 0 ; runIndex < CFArrayGetCount(runArray) ; runIndex++){
        
        //获取每一个字迹，run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        
        //得到字迹对应的字形
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        //遍历字形
        for(CFIndex runGlyphIndex = 0 ; runGlyphIndex < CTRunGetGlyphCount(run) ; runGlyphIndex++){
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
            CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
            CGPathAddPath(pathRef, &t, letter);
            CGPathRelease(letter);
            
        }
    }
    CFRelease(line);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:pathRef]];
    return path;
}


-(void)setTextString:(NSString *)string font:(CGFloat)font{
    self.gradientLayer.colors = [self getGradientColors];
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.duration = 0.5;
    animation.repeatCount = MAXFLOAT;
    animation.toValue = [self getGradientColors];
    animation.autoreverses = YES;
    [_gradientLayer addAnimation:animation forKey:@"gradientLayer"];
    _gradientLayer.mask = _shapeLayer;
    
    
    UIBezierPath *textPath = [self bezierPathFrom:string font:font];
    _shapeLayer.bounds = CGPathGetBoundingBox(textPath.CGPath);
    _shapeLayer.path = textPath.CGPath;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.duration = 1*[string length];
    basicAnimation.fromValue = @0;
    basicAnimation.toValue = @1;
    [_shapeLayer addAnimation:basicAnimation forKey:nil];

}
#pragma mark - private method

-(NSArray<UIColor *>*)getGradientColors
{
    NSMutableArray *colors = [NSMutableArray array];
    int count = 10;
    for(int i = 0 ; i < count ; i ++){
        [colors addObject:(__bridge id)[self randomColor].CGColor];
    }
    return colors;
}

-(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
