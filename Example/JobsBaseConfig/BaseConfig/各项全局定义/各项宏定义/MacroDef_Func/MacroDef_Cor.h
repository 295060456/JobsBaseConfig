//
//  MacroDef_Cor.h
//  UBallLive
//
//  Created by Jobs on 2020/10/9.
//

#ifndef MacroDef_Cor_h 
#define MacroDef_Cor_h

#pragma mark ======================================== 色彩相关 ========================================
///常见颜色
/* lightTextColor is always light, and darkTextColor is always dark, regardless of the current UIUserInterfaceStyle.
 * When possible, we recommend using `labelColor` and its variants, instead.
 */
#define JobsLightTextColor [UIColor xy_createWithLightColor:UIColor.lightTextColor darkColor:UIColor.lightTextColor]
#define JobsLightGrayColor [UIColor xy_createWithLightColor:UIColor.lightGrayColor darkColor:UIColor.lightGrayColor]
#define JobsGreenColor     [UIColor xy_createWithLightColor:UIColor.greenColor darkColor:UIColor.greenColor]
#define JobsMagentaColor   [UIColor xy_createWithLightColor:UIColor.magentaColor darkColor:UIColor.magentaColor]
#define JobsClearColor     [UIColor xy_createWithLightColor:UIColor.clearColor darkColor:UIColor.clearColor]
#define JobsBlackColor     [UIColor xy_createWithLightColor:UIColor.blackColor darkColor:UIColor.blackColor]
#define JobsBlueColor      [UIColor xy_createWithLightColor:UIColor.blueColor darkColor:UIColor.blueColor]
#define JobsWhiteColor     [UIColor xy_createWithLightColor:UIColor.whiteColor darkColor:UIColor.whiteColor]
#define JobsCyanColor      [UIColor xy_createWithLightColor:UIColor.cyanColor darkColor:UIColor.cyanColor]
#define JobsGrayColor      [UIColor xy_createWithLightColor:UIColor.grayColor darkColor:UIColor.grayColor]
#define JobsOrangeColor    [UIColor xy_createWithLightColor:UIColor.orangeColor darkColor:UIColor.orangeColor]
#define JobsRedColor       [UIColor xy_createWithLightColor:UIColor.redColor darkColor:UIColor.redColor]
#define JobsBrownColor     [UIColor xy_createWithLightColor:UIColor.brownColor darkColor:UIColor.brownColor]
#define JobsDarkGrayColor  [UIColor xy_createWithLightColor:UIColor.darkGrayColor darkColor:UIColor.darkGrayColor]
#define JobsDarkTextColor  [UIColor xy_createWithLightColor:UIColor.darkTextColor darkColor:UIColor.darkTextColor]
#define JobsYellowColor    [UIColor xy_createWithLightColor:UIColor.yellowColor darkColor:UIColor.yellowColor]
#define JobsPurpleColor    [UIColor xy_createWithLightColor:UIColor.purpleColor darkColor:UIColor.purpleColor]
///System colors
/* Some colors that are used by system elements and applications.
* These return named colors whose values may vary between different contexts and releases.
* Do not make assumptions about the color spaces or actual colors used.
*/
#define JobsSystemRedColor [UIColor xy_createWithLightColor:UIColor.systemRedColor darkColor:UIColor.systemRedColor]
#define JobsSystemGreenColor [UIColor xy_createWithLightColor:UIColor.systemGreenColor darkColor:UIColor.systemGreenColor]
#define JobsSystemBlueColor [UIColor xy_createWithLightColor:UIColor.systemBlueColor darkColor:UIColor.systemBlueColor]
#define JobsSystemOrangeColor [UIColor xy_createWithLightColor:UIColor.systemOrangeColor darkColor:UIColor.systemOrangeColor]
#define JobsSystemYellowColor [UIColor xy_createWithLightColor:UIColor.systemYellowColor darkColor:UIColor.systemYellowColor]
#define JobsSystemPinkColor [UIColor xy_createWithLightColor:UIColor.systemPinkColor darkColor:UIColor.systemPinkColor]
#define JobsSystemPurpleColor [UIColor xy_createWithLightColor:UIColor.systemPurpleColor darkColor:UIColor.systemPurpleColor]
#define JobsSystemTealColor [UIColor xy_createWithLightColor:UIColor.systemTealColor darkColor:UIColor.systemTealColor]
#define JobsSystemIndigoColor [UIColor xy_createWithLightColor:UIColor.systemIndigoColor darkColor:UIColor.systemIndigoColor]
#define JobsSystemGrayColor [UIColor xy_createWithLightColor:UIColor.systemGrayColor darkColor:UIColor.systemGrayColor]
/* The numbered variations, systemGray2 through systemGray6, are grays which increasingly
* trend away from systemGray and in the direction of systemBackgroundColor.
*
* In UIUserInterfaceStyleLight: systemGray1 is slightly lighter than systemGray.
*                               systemGray2 is lighter than that, and so on.
* In UIUserInterfaceStyleDark:  systemGray1 is slightly darker than systemGray.
*                               systemGray2 is darker than that, and so on.
*/
#define JobsSystemGray2Color [UIColor xy_createWithLightColor:UIColor.systemGray2Color darkColor:UIColor.systemGray2Color]
#define JobsSystemGray3Color [UIColor xy_createWithLightColor:UIColor.systemGray3Color darkColor:UIColor.systemGray3Color]
#define JobsSystemGray4Color [UIColor xy_createWithLightColor:UIColor.systemGray4Color darkColor:UIColor.systemGray4Color]
#define JobsSystemGray5Color [UIColor xy_createWithLightColor:UIColor.systemGray5Color darkColor:UIColor.systemGray5Color]
#define JobsSystemGray6Color [UIColor xy_createWithLightColor:UIColor.systemGray6Color darkColor:UIColor.systemGray6Color]
/* Foreground colors for static text and related elements.
*/
#define JobsLabelColor [UIColor xy_createWithLightColor:UIColor.labelColor darkColor:UIColor.labelColor]
#define JobsSecondaryLabelColor [UIColor xy_createWithLightColor:UIColor.secondaryLabelColor darkColor:UIColor.secondaryLabelColor]
#define JobsTertiaryLabelColor [UIColor xy_createWithLightColor:UIColor.tertiaryLabelColor darkColor:UIColor.tertiaryLabelColor]
#define JobsQuaternaryLabelColor [UIColor xy_createWithLightColor:UIColor.quaternaryLabelColor darkColor:UIColor.quaternaryLabelColor]
/* Foreground color for standard system links.
*/
#define JobsLinkColor [UIColor xy_createWithLightColor:UIColor.linkColor darkColor:UIColor.linkColor]
#define JobsPlaceholderTextColor [UIColor xy_createWithLightColor:UIColor.placeholderTextColor darkColor:UIColor.placeholderTextColor]
#define JobsSeparatorColor [UIColor xy_createWithLightColor:UIColor.separatorColor darkColor:UIColor.separatorColor]
#define JobsOpaqueSeparatorColor [UIColor xy_createWithLightColor:UIColor.opaqueSeparatorColor darkColor:UIColor.opaqueSeparatorColor]
///Background colors
/* We provide two design systems (also known as "stacks") for structuring an iOS app's backgrounds.
*
* Each stack has three "levels" of background colors. The first color is intended to be the
* main background, farthest back. Secondary and tertiary colors are layered on top
* of the main background, when appropriate.
*
* Inside of a discrete piece of UI, choose a stack, then use colors from that stack.
* We do not recommend mixing and matching background colors between stacks.
* The foreground colors above are designed to work in both stacks.
*
* 1. systemBackground
*    Use this stack for views with standard table views, and designs which have a white
*    primary background in light mode.
*/
#define JobsSystemBackgroundColor [UIColor xy_createWithLightColor:UIColor.systemBackgroundColor darkColor:UIColor.systemBackgroundColor]
#define JobsSecondarySystemBackgroundColor [UIColor xy_createWithLightColor:UIColor.secondarySystemBackgroundColor darkColor:UIColor.secondarySystemBackgroundColor]
#define JobsTertiarySystemBackgroundColor [UIColor xy_createWithLightColor:UIColor.tertiarySystemBackgroundColor darkColor:UIColor.tertiarySystemBackgroundColor]
/* 2. systemGroupedBackground
*    Use this stack for views with grouped content, such as grouped tables and
*    platter-based designs. These are like grouped table views, but you may use these
*    colors in places where a table view wouldn't make sense.
*/
#define JobsSystemGroupedBackgroundColor [UIColor xy_createWithLightColor:UIColor.systemGroupedBackgroundColor darkColor:UIColor.systemGroupedBackgroundColor]
#define JobsSecondarySystemGroupedBackgroundColor [UIColor xy_createWithLightColor:UIColor.secondarySystemGroupedBackgroundColor darkColor:UIColor.secondarySystemGroupedBackgroundColor]
#define JobsTertiarySystemGroupedBackgroundColor [UIColor xy_createWithLightColor:UIColor.tertiarySystemGroupedBackgroundColor darkColor:UIColor.tertiarySystemGroupedBackgroundColor]
///Fill colors
/* Fill colors for UI elements.
* These are meant to be used over the background colors, since their alpha component is less than 1.
*
* systemFillColor is appropriate for filling thin and small shapes.
* Example: The track of a slider.
*/
#define JobsSystemFillColor [UIColor xy_createWithLightColor:UIColor.systemFillColor darkColor:UIColor.systemFillColor]
/* secondarySystemFillColor is appropriate for filling medium-size shapes.
* Example: The background of a switch.
*/
#define JobsSecondarySystemFillColor [UIColor xy_createWithLightColor:UIColor.secondarySystemFillColor darkColor:UIColor.secondarySystemFillColor]
/* tertiarySystemFillColor is appropriate for filling large shapes.
* Examples: Input fields, search bars, buttons.
*/
#define JobsTertiarySystemFillColor [UIColor xy_createWithLightColor:UIColor.tertiarySystemFillColor darkColor:UIColor.tertiarySystemFillColor]
/* quaternarySystemFillColor is appropriate for filling large areas containing complex content.
* Example: Expanded table cells.
*/
#define JobsQuaternarySystemFillColor [UIColor xy_createWithLightColor:UIColor.quaternarySystemFillColor darkColor:UIColor.quaternarySystemFillColor]
///Other colors
/* groupTableViewBackgroundColor is now the same as systemGroupedBackgroundColor.*/
#define JobsGroupTableViewBackgroundColor [UIColor xy_createWithLightColor:UIColor.groupTableViewBackgroundColor darkColor:UIColor.groupTableViewBackgroundColor]
#define JobsViewFlipsideBackgroundColor [UIColor xy_createWithLightColor:UIColor.viewFlipsideBackgroundColor darkColor:UIColor.viewFlipsideBackgroundColor]
#define JobsScrollViewTexturedBackgroundColor [UIColor xy_createWithLightColor:UIColor.scrollViewTexturedBackgroundColor darkColor:UIColor.scrollViewTexturedBackgroundColor]
#define JobsUnderPageBackgroundColor [UIColor xy_createWithLightColor:UIColor.underPageBackgroundColor darkColor:UIColor.underPageBackgroundColor]
/// RGB颜色
#define RGBA_SAMECOLOR(x,a) [UIColor colorWithRed:(x)/255.0 green:(x)/255.0 blue:(x)/255.0 alpha:a]
#define RGB_SAMECOLOR(x) [UIColor colorWithRed:(x)/255.0 green:(x)/255.0 blue:(x)/255.0 alpha:1]
#define RGBA_COLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGB_COLOR(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
/// 随机颜色
#define JobsRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 \
green:arc4random_uniform(256) / 255.0 \
blue:arc4random_uniform(256) / 255.0 \
alpha:1] \
/// 十六进制颜色
#define HEXCOLOR(hexValue)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1]
#define HEXCOLOR_ALPHA(hexValue, al)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:al]
#define JobsCor(带井号的十六进制的颜色) [UIColor colorFromHexString:带井号的十六进制的颜色]

#endif /* MacroDef_Cor_h */
