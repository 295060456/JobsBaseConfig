# iOS 锁的使用



```objective-c
/// 获取颜色值
- (UIColor *)colorForKey:(NSString *)key {
  pthread_rwlock_rdlock(&_rwlock);// 读写锁
  UIColor *color = UIColor.redCor;
  pthread_rwlock_unlock(&_rwlock);// 读写锁
  return color;
}
```

