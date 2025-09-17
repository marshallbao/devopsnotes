#!/bin/bash

# 目录路径（假设目录是 a）
dir="./notes"

# 遍历目录 a 中所有的 .md 文件
find "$dir" -type f -name "*.md" | while read file; do
  # 检查文件中是否包含一级标题
  if ! grep -q "^# " "$file"; then
    # 如果没有找到一级标题，输出文件名
    echo "文件没有一级标题: $file"
  fi
done

