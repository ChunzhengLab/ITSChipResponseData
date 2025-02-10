#!/bin/bash

# ----------------------------
# 脚本：重命名文件并插入一行“50”
# ----------------------------

# 步骤0：备份原始文件（可选但强烈推荐）
backup_dir="backup_$(date +%Y%m%d%H%M%S)"
mkdir -p "$backup_dir"
cp charge_mapping_*.txt "$backup_dir/" 2>/dev/null

# 步骤1：重命名文件
shopt -s nullglob
for file in charge_mapping_*.txt; do
    # 检查文件是否存在
    if [ -e "$file" ]; then
        # 构建新文件名
        newname="data_pixels_${file#charge_mapping_}"
        # 重命名文件
        mv -- "$file" "$newname"
        echo "已将 '$file' 重命名为 '$newname'"
    else
        echo "未找到匹配的文件：$file"
    fi
done

# 步骤2：在文件开头插入一行“50”
for file in data_pixels_*.txt; do
    if [ -e "$file" ]; then
        # 使用sed在第一行插入“50”
        sed -i '' '1s/^/50\
/' "$file"
        echo "已在 '$file' 的开头插入 '50'"
    else
        echo "未找到匹配的文件：$file"
    fi
done

echo "操作完成。"