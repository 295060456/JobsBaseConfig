/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A custom presentation controller which slides the presenting view controller
  upwards to reveal the presented view controller.
 */

@import UIKit;

@interface AAPLCustomPresentationController : UIPresentationController 
<
UIViewControllerTransitioningDelegate,
UIViewControllerAnimatedTransitioning
>

@end
