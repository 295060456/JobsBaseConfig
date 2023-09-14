# 读取本地plist

```objective-c
+ (TYFSITE)siteType{
    static NSInteger site = 6;
    static dispatch_once_t dispatchOnce;
    dispatch_once(&dispatchOnce, ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MetaData" ofType:@"plist"];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:filePath]) {
            NSDictionary *config = [[NSDictionary alloc] initWithContentsOfFile:filePath];
            NSString *appTypeStr = config[@"appType"];
            site = appTypeStr.integerValue;
        }
    });return site;
}
```

