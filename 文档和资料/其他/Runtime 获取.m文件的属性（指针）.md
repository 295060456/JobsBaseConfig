# Runtime 获取.m文件的属性（指针）

```objective-c
-(void)test{
    Ivar ivar = class_getInstanceVariable([ZFJTreeView class], "_tableView");//必须是下划线接属性
    UITableView *tableView = object_getIvar(self.treeView, ivar);
    tableView.mj_header = self.tableViewHeader;
    tableView.mj_footer = self.tableViewFooter;
}
```

```objective-c
-(void)Test{
    Ivar ivar = class_getInstanceVariable([BRDatePickerView class], "_monthNames");//必须是下划线接属性
    NSArray *_monthNames = @[@"一月份", @"二月份", @"三月份", @"四月份", @"五月份", @"六月份", @"七月份", @"八月份", @"九月份", @"十月份", @"十一月份", @"十二月份"];
    object_setIvar(self.datePickerView, ivar, _monthNames);
}
```

```
也可以用KVC
比方说有一个变量叫aaa
然后我用 变量 = 【对象 valueForKey：@“aaa”】来取，顺序是这样的：
1、看是否有- （类型）aaa{}方法，如果有就调用
2、看是否有_aaa变量，如果有，直接取
3、看是否有aaa变量，如果有，直接取
4、看是否有_isAaa变量，如果有，直接取
5、看是否有isAaa变量，如果有，直接取
6、返回nil
```

