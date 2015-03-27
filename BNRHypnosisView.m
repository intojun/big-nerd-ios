//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by infradev on 2015. 3. 23..
//  Copyright (c) 2015년 intojun. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //모든 BNRHypnosisView는 무색의 배경을 가진다.
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    CGRect bounds = self.bounds;
    
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // 가장 큰 원은 뷰를 에워싼다.  음.. hypot ???
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -=20) {
        // 이게 포인트구만!!
        [path moveToPoint:CGPointMake(center.x+currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI*2.0 clockwise:YES];
    }
    
    path.lineWidth = 10;
    
    // 신기한 코드..
    [[UIColor lightGrayColor] setStroke];
    
    [path stroke];
    
    // 동메달 과제
    
    
    // 금메달 과제
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    
    // 삼격형 그리기
    UIBezierPath *pathTri = [[UIBezierPath alloc] init];

    [pathTri moveToPoint:CGPointMake(center.x, center.y - 200)];
    [pathTri addLineToPoint:CGPointMake(center.x - 100, center.y + 200)];
    [pathTri addLineToPoint:CGPointMake(center.x + 100, center.y + 200)];
    [pathTri addLineToPoint:CGPointMake(center.x, center.y - 200)];

    
    // 그라디언트 그리기
    CGContextSaveGState(currentContext);
    [pathTri addClip];
    
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {0.0, 1.0, 0.0, 1.0,
        1.0, 1.0, 0.0, 1.0};
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    
    CGPoint startPoint = CGPointMake(center.x, center.y - 200);
    CGPoint endPoint = CGPointMake(center.x, center.y + 200);
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    CGContextRestoreGState(currentContext);
    
    
    // 로고 그림자 넣기
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4,7), 3);
    
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    [logoImage drawInRect:CGRectMake(bounds.origin.x+bounds.size.width/4,
                                     bounds.origin.y+bounds.size.height/4,
                                     bounds.size.width/2,
                                     bounds.size.height/2)];
    
    CGContextRestoreGState(currentContext);
    
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    CGRect bounds = self.bounds;
//    
//    // bounds 영역의 중심 계산
//    CGPoint center;
//    center.x = bounds.origin.x + bounds.size.width / 2.0;
//    center.y = bounds.origin.y + bounds.size.height / 2.0;
//    
//    // 원은 뷰에 들어갈 수 있는 것 중 가장 큰 크기가 된다.
//    float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    
//    // 0부터 2*PI의 라디안 각도와 radius값을 반지름으로 center를 중심점으로 한 호를 path에 추가한다.
//    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
//    
//    // 선 두께를 10포인트로 설정한다.
//    path.lineWidth = 10;
//    
//    // 전체 UI
//    [[UIColor lightGrayColor] setStroke];
//    
//    [path stroke];
//}



@end
