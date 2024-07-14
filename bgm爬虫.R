# 先安装包，运行：
#install.packages(c("rvest","dplyr","purrr","parallel","parallelMap")

library(rvest)
library(dplyr)
library(purrr)
library(parallel)
library(parallelMap)


# 在此修改bgm邮箱
email <- c('771399','794514')

# 读取页数
get_page <- function(url){
  
  # 读取网址
  web <- read_html(url)
  
  # 读取页数，由于page中包含“>>”故减2
  pagelist <- web %>% html_nodes('div.page_inner') %>% html_text()
  as.character(nchar(pagelist)-2)
}

# 获取名字
get_name <- function(url){
  read_html(url) %>% html_nodes('div.name a') %>% html_text()
}

# 读取所在页游戏
get_game <- function(url){
  read_html(url) %>% html_nodes('h3 a') %>% html_text()
}

# 读取所有页数的游戏
all_get_game <- function(url,page){
  urlvec <- c()
  for (i in 1:page) {
    urlvec <- c(urlvec,paste0(url,"?page=",i))
  }
   
  map(urlvec,get_game)
}

# 输入用户bgm邮箱，输出用户玩过的游戏
user_get_game <- function(email){
  
  # 得到用户“玩过”页网址
  url <- map_chr(email,~paste0('https://bangumi.tv/game/list/',.x,'/collect'))  
  
  page <- map_chr(url,get_page)
  
  name <- map_chr(url,get_name) 
    
  game <- map2(url,page,all_get_game)
  names(game) <- name
  game
}


# 多核运行
parallelStartSocket(cpus = detectCores())
usergamelist <- user_get_game(email)
parallelStop()


# 在此修改保存地址
for (i in 1:length(email)) {
  name <- names(usergamelist[i])
  write.csv(unlist(usergamelist[[i]]),file=paste0("E:/galgame/",name,".txt")) 

}


