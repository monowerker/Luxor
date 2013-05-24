//
//  IADrawingUtilities.m
//  IACoreKit
//
//  Copyright iDeal Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

typedef enum {
	IADrawBadgeAlignLeft,
	IADrawBadgeAlignRight,
} IADrawBadgeAlign;

extern CGRect CGRectSetX(CGRect rect, CGFloat x);
extern CGRect CGRectSetY(CGRect rect, CGFloat y);
extern CGRect CGRectSetWidth(CGRect rect, CGFloat width);
extern CGRect CGRectSetHeight(CGRect rect, CGFloat height);
extern CGRect CGRectSetOrigin(CGRect rect, CGPoint origin);
extern CGRect CGRectSetSize(CGRect rect, CGSize size);
extern CGRect CGRectSetZeroOrigin(CGRect rect);
extern CGRect CGRectSetZeroSize(CGRect rect);
extern CGSize CGSizeAspectScaleToSize(CGSize size, CGSize toSize);
extern CGRect CGRectAddPoint(CGRect rect, CGPoint point);
extern CGRect CGRectContract(CGRect rect, CGFloat dx, CGFloat dy);
extern CGRect CGRectShift(CGRect rect, CGFloat dx, CGFloat dy);
extern CGRect IARectInset(CGRect rect, UIEdgeInsets insets);


extern CGGradientRef IACreateGradientWithColors(NSArray *colors);
extern CGGradientRef IACreateGradientWithColorsAndLocations(NSArray *colors, NSArray *locations, CGColorSpaceRef colorSpace);

// Adds rounded rects to current path, use CGContextSaveGState to save state
extern void IAAddRoundedRect(CGRect rect, UIRectCorner corners, CGSize cornerRadii);

// Draws a line between two points ,use current stroke color
// To get crisp lines, use half points
extern void IADrawLine(CGPoint start, CGPoint stop, CGFloat lineWidth);

// Draws a badge (rounded rect, border, one line text) drawAtPoint is att the top left/right depending on align
// To get crisp lines, use half points
extern void IADrawBadge(CGPoint drawAtPoint,
												IADrawBadgeAlign align,
												NSString *text,
												UIFont *font,
												BOOL multiple,
												UIColor *textColor,
												UIColor *textShadowColor);

// Draws the gradient in the current rect path
extern void IADrawGradientInRect(CGGradientRef gradient, CGRect rect, CGGradientDrawingOptions options);
