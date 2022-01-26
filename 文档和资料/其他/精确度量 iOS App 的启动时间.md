#  精确度量 iOS App 的启动时间
参考资料来源：https://www.jianshu.com/p/c14987eee107
方法一：
Edit scheme --> Run --> Arguments 中将环境变量 DYLD_PRINT_STATISTICS 设为 1，就可以看到 main 之前各个阶段的时间消耗。
方法二：
Edit scheme --> Run --> Arguments 中将环境变量 DYLD_PRINT_STATISTICS_DETAILS 设为 1 就可以。

