#!/bin/bash

#
# started.sh
# started.sh <dist_dirname>
#

clear

echo -e "\e[0m\c"

# 当前工作目录
work_dirname=$(pwd)

# 标签名称
tag_name=$(date +"v%Y%m%d_%H%M")
# 分支名称
branch_name=$(git branch --show-current)

# 应用名称
app_name=$(grep -Po '"name"\s*:\s*"\K[^"]+' "${work_dirname}/package.json")

# 
dist_dirname="/home/$USER/deploy/${app_name}-dist"

# 设置<dist>目录
pick_dist_directory() {
  local entered_dirname="$1"
  # 是否指定<dist>目录
  if [ "" == "$entered_dirname" ]; then
    # <dist>目录不存在则创建
    if [ ! -d "$dist_dirname" ]; then
      return 1
    fi
    return 0
  fi

  # 移除末尾所有斜杠
  while [[ "$entered_dirname" =~ /$ ]]; do
    entered_dirname="${entered_dirname%/}"
  done

  # 判断是否为目录
  if [ -d "$entered_dirname" ]; then
    dist_dirname="$entered_dirname"
    return 0
  fi
  return 1
}

# 切换分支
switch_dist_branch() {
  local flag=0
  # 执行打包命令校验
  if [[ "demo" != "$branch_name" && "main" != "$branch_name" ]]; then
    return 1
  fi

  # 校验<dist>目录是否存在版本控制
  cd "$dist_dirname"
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    # 切换分支
    if git show-ref --verify --quiet "refs/heads/$branch_name"; then
      git switch "$branch_name" > /dev/null 2>&1
    else
      git switch -c "$branch_name" > /dev/null 2>&1
    fi
  fi

  local name=$(git branch --show-current)

  if [ "$branch_name" != "$name" ]; then
    flag=2
    # else
    # 推送标签
    # git tag -a $tag_name -m "Release $tag_name" > /dev/null 2>&1
    # git push origin $tag_name -f > /dev/null 2>&1
  fi
  
  cd "$work_dirname"
  return $flag
}

# 拷贝build目录
copy_build_directory() {
  local build_dirname="$work_dirname/build"
  if [ ! -d "$build_dirname" ]; then
    echo "build directory not found."
    return
  fi

  # 初始化<session>目录
  local session_dirname="$dist_dirname/session"
  # 初始化session .gitignore
  if [ ! -d $session_dirname ]; then
    mkdir -p "$session_dirname"
    cat <<EOF > "$session_dirname/.gitignore"
*
!.gitignore

EOF
  fi

  # 拷贝deploy目录
  rm -rf "$dist_dirname/deploy"
  cp -rf "$work_dirname/deploy" "$dist_dirname/deploy"

  # 拷贝产出目录
  if [ -d "$build_dirname" ]; then
    rm -rf "$dist_dirname/build"
    cp -rf "$build_dirname" "$dist_dirname/build"
  fi

  # 拷贝ORM并清理数据库文件
  rm -rf "$dist_dirname/prisma"
  cp -rf "$work_dirname/prisma" "$dist_dirname/prisma"
  rm -rf $dist_dirname/prisma/*.db

  # 拷贝
  for name in package.json package-lock.json pm2.config.cjs .npmrc .env-example; do
    source="$work_dirname/$name"
    if [ -f "$source" ]; then
      cp -rf "$source" "$dist_dirname/$name"
    fi
  done

  # 增加reload脚本
  cat <<EOF > "$dist_dirname/reload-service.sh"
#!/bin/bash
# 拉取最新代码
git pull --rebase
# 安装依赖
npm ci --omit="dev"
# 重启服务
pm2 reload "$app_name"

EOF

  chmod +x "$dist_dirname/reload-service.sh"
}

start() {
  # 设置<dist>目录
  pick_dist_directory "$1"

  # <dist>目录不存在
  if [ "1" == "$?" ]; then
    echo "The directory '${dist_dirname}' does not exist."
    return
  fi

  # 切换分支
  switch_dist_branch
  if [ "1" == "$?" ]; then
    echo "The branch '${branch_name}' is not buildable."
    return
  elif [ "2" == "$?" ]; then
    echo "Failed to switch to branch '${branch_name}'."
    return
  fi

  # 执行打包命令
  npm run build:${branch_name}

  copy_build_directory

  # 打印<dist>目录
  if command -v tree >/dev/null 2>&1; then
    tree -L 2 "$dist_dirname"
  else
    ls -al "$dist_dirname"
  fi
  # 推到远程
  cd "$dist_dirname"
  git add .
  git commit -am "Release $tag_name"
  git push origin "$branch_name"
  cd "$work_dirname"
}

start "$1"