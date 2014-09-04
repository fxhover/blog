#Blog演示页面

##首页

![首页](https://github.com/fxhover/blog/raw/master/doc/index.png)

##博文列表

![文章列表](https://github.com/fxhover/blog/raw/master/doc/articles_list.png)

##写博客页面

![写博客](https://github.com/fxhover/blog/raw/master/doc/new_article.png)

##文章详情页面

![文章详情](https://github.com/fxhover/blog/raw/master/doc/show_article.png)

##设置页面

![设置头像](https://github.com/fxhover/blog/raw/master/doc/set1.png)

![设置博客](https://github.com/fxhover/blog/raw/master/doc/set2.png)

#Blog部署文档#

##环境
    git、ruby 2.1.2、rails 4.1.5、nginx 1.2+、mysql 5.0+

##下载代码##
    
    git clone git@github.com:fxhover/blog.git

##安装ruby依赖类库##

    bundle exec bundle install

##配置文件##

    cd blog

    cp config/database.yml.example config/database.yml 修改数据库配置信息

    cp config/secrets.yml.example config/secrets.yml
 
    cp config/blog.yml.example config/blog.yml 修改好博客配置信息

    cp config/unicorn.rb.example config/unicorn.rb 修改unicorn配置文件，配置应用目录等信息

##执行数据脚本##

    RAILS_ENV=production bundle exec rake db:create  创建数据库
   
    RAILS_ENV=production bundle exec rake db:migrate 创建表及索引

    RAILS_ENV=production bundle exec rake db:seed 创建默认分类和管理员账号，编辑 db/seeds.rb可以修改默认分类和管理员账号密码，然后再执行

##预编译前端资源##

    RAILS_ENV=production bundle exec rake assets:clean
    
    RAILS_ENV=production bundle exec rake assets:precompile

##启动##

###创建服务用到的文件夹###
    mkdir -p tmp/pids

    mkdir -p log 

###拷贝启动服务文件###

    sudo cp deployment/init.d/blog /etc/init.d 编辑文件中的app目录和sudo user的配置

###启动blog服务###
    
    sudo service blog start
    
    sudo service blog stop/restart 停止或者重启服务

###nginx配置###

    以下列出部分配置，完整配置见 deployment/nginx/nginx.conf文件

    upstream blog {
        server unix:/home/fangxiang/blog/tmp/sockets/blog.socket;
    }
    server {
        listen 80;
        server_name blog.com;
        root /home/fangxiang/blog/public;
        try_files $uri/index.html $uri.html $uri @user1;
        location @user1 {
            proxy_redirect off;
            proxy_set_header Host $host;
            proxy_set_header X-Forwarded-Host $host;
            proxy_set_header X-Forwarded-Server $host;
            proxy_set_header X-Real-Ip $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_buffering on;
            proxy_pass http://blog;
        }
        location ~ ^(/assets) {
            access_log off;
            expires max;
        }

    }

###重启nginx###
    
    sudo service nginx restart
###绑定hosts
   
    127.0.0.1  blog.com 

###访问###

    http://blog.com

