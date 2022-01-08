#  系统Nav
和tabbarVC一样，会将VC顶起来
self.navigationController.navigationBar.hidden = YES;//导航栏还在只是bar被隐藏了，所以VC在视图的样子是保持顶起
[self.navigationController setNavigationBarHidden:YES animated:NO];//整个导航栏（包括bar）全部隐藏，VC是全屏


iOS隐藏导航栏的返回按钮
[self.navigationController.navigationItem setHidesBackButton:YES]; 
[self.navigationItem setHidesBackButton:YES]; 
[self.navigationController.navigationBar.backItem setHidesBackButton:YES];
另类做法
[self.navigationItem.backBarButtonItem setTitle:@""];

设置返回按钮title ，在父视图写：
self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:nil
                                                                        action:nil];
