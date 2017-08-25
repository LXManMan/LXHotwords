# LXHotwords
![image](https://github.com/liuxinixn/LXHotwords/blob/master/LXHotwords/%E7%83%AD%E8%AF%8D.gif)

使用方法如下：
LXWS(weakSelf);
    self.tagsView  =[[LXTagsView alloc]initWithFrame:CGRectMake(0, 100, 300, 40) ItemClick:^(NSInteger index) {
        NSLog(@"%ld",index);
        UIViewController *vc =[[UIViewController alloc]init];
        vc.view.backgroundColor = LXRandomColor;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    self.tagsView.btnFont =[UIFont systemFontOfSize:16];
    self.tagsView.tagSpace = 10;
    self.tagsView.tagsMargin = 5;
    self.tagsView.tagInsetSpace = 15;
    self.tagsView.tagsLineSpace =10;
    self.tagsView.tagsArray = @[@"无知安徽噶人噶人家噶加热机噶进入国阿嘎热噶人噶热狗如果",@"风云变幻",@"施耐庵",@"唉",@"西门吹雪",@"呵呵哒你没打答题的啊啊噶而过阿哥人argergaergaergag阿嘎人家居然就噶间距根据",@"他大舅他二舅都是他就",@"窿窿啦啦",@"火麒麟",@"合欢花",@"暴走大事件",@"非诚勿扰",@"呵呵呵",@"miss",@"我爱你",@"thelife",@"永生",@"不忘",@"你",@"爱好个人拉人给哈尔和老公哈拉尔挂了会考",@"爱人噶人更好惹过哈儿噶尔 ",@"爱人杆儿隔热管",@"爱人跟人"];
    
    [self.view addSubview:self.tagsView];
