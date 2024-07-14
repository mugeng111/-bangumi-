# -bangumi-
使用R语言rvest包爬取bangumi网站”玩过“的游戏名称

使用前请先确保已安装包，若没有，则运行：
install.packages(c("rvest","dplyr","purrr","parallel","parallelMap"))

在email处输入需要爬取的bgm邮箱，在文末修改文档保存地址。

修改url_get_game中的url可以实现爬取其他对象，如将collect修改为wish可实现爬取想玩的游戏，将game修改为anime可实现爬取看过的动画。
