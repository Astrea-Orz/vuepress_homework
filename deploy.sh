#!/usr/bin/env sh

# 终止一个错误
set -e

# 构建
npm run build

# 进入生成的构建文件夹
cd blog/.vuepress/dist

# 如果你是要部署到自定义域名
# echo 'www.example.com' > CNAME

git init
git add -A
git commit -m 'deploy'

# 如果你想要部署到 https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git master

# 如果你想要部署到 https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:Astrea-Orz/vuepress_homework.git master:gh-pages

# 链接远程仓库
git remote add origin https://github.com/Astrea-Orz/vuepress_homework.git
# 拉取远程仓库的文件
git pull --rebase origin master
# 同步更新代码
git push -u origin master

cd -