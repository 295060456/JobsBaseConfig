
GDFadeView *iphoneFade = [[GDFadeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
iphoneFade.text = @"伟易博";
iphoneFade.foreColor = [UIColor redColor];
iphoneFade.backColor = [UIColor grayColor];
iphoneFade.font = [UIFont systemFontOfSize:39 weight:UIFontWeightRegular];
iphoneFade.alignment = NSTextAlignmentCenter;
iphoneFade.center = CGPointMake(SCREEN_WIDTH/2, 64+100);
[self.view addSubview:iphoneFade];
[iphoneFade iPhoneFadeWithDuration:2];
