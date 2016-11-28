//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "DemoCustomButtomMessageMediaView.h"

@interface DemoCustomButtomMessageMediaView ()

@property(nonatomic) UILabel *label;
@property(nonatomic) UIButton *button;

@end

@implementation DemoCustomButtomMessageMediaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        [self addSubview:label];
        _label = label;
        
        label.textAlignment = NSTextAlignmentCenter;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIEdgeInsets layoutMargins = self.layoutMargins;
        
        [self jsq_pinSubview:label toEdge:NSLayoutAttributeTop constant:-layoutMargins.top];
        [self jsq_pinSubview:label toEdge:NSLayoutAttributeLeft constant:-layoutMargins.left];
        [self jsq_pinSubview:label toEdge:NSLayoutAttributeRight constant:-layoutMargins.right];
        
        label.text = @"You rock. Want to be friends? Will add you on Facebook!";
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"Yes!" forState:UIControlStateNormal];
        [button setTitleColor:button.tintColor forState:UIControlStateNormal];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        [self addSubview:button];
        _button = button;
        
        NSLayoutConstraint *xCenterConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self addConstraint:xCenterConstraint];
        
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(==200)]"
                                                                      options: 0
                                                                      metrics:nil
                                                                        views:@{@"button" : button}]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label][button(==35)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(label, button)]];
        
        self.textPropertiesChangedBlock = ^(JSQCustomMediaView *aView) {
            label.textColor = aView.preferredTextColor;
            label.font = aView.preferredFont;
            button.titleLabel.font = aView.preferredFont;
        };
        
    }
    return self;
}

- (CGSize)desiredContentSize {
    const CGSize superDesiredContentSize = [super desiredContentSize];
    
    [self.button layoutIfNeeded];
    
    const CGSize labelSize = [self.label sizeThatFits:CGSizeMake(superDesiredContentSize.width - self.layoutMargins.left - self.layoutMargins.right, CGFLOAT_MAX)];
    const CGSize buttonSize = self.button.frame.size;
    
    return CGSizeMake(self.layoutMargins.left + labelSize.width + self.layoutMargins.right, labelSize.height + buttonSize.height + self.layoutMargins.bottom + self.layoutMargins.top);
}

+ (UIEdgeInsets)defaultLayoutMargins {
    return UIEdgeInsetsMake(5, 10, 0, 5);
}

@end
