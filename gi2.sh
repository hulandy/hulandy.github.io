#!/bin/bash

echo "🔍 查找嵌套的文章文件..."

# 查找所有 .md 文件（递归查找）
find posts -name "*.md" -type f > /tmp/article_list.txt
ARTICLE_COUNT=$(wc -l < /tmp/article_list.txt)

echo "找到 $ARTICLE_COUNT 篇文章"

if [ $ARTICLE_COUNT -eq 0 ]; then
    echo "❌ 没有找到文章，创建示例..."
    mkdir -p posts/2024
    cat > posts/2024/2024-01-01-欢迎.md << 'EOF'
# 欢迎

这是你的第一篇文章。
EOF
    find posts -name "*.md" -type f > /tmp/article_list.txt
    ARTICLE_COUNT=$(wc -l < /tmp/article_list.txt)
fi

# 创建首页
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Hulandy's Blog</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            line-height: 1.6;
            color: #24292e;
            background: #fff;
        }
        header {
            border-bottom: 1px solid #e1e4e8;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }
        h1 {
            margin: 0;
            font-size: 2.5em;
            color: #24292e;
        }
        .subtitle {
            color: #6a737d;
            font-size: 1.1em;
            margin-top: 10px;
        }
        .stats {
            background: #f6f8fa;
            padding: 15px;
            border-radius: 6px;
            margin: 20px 0;
            font-size: 0.95em;
            border-left: 4px solid #0366d6;
        }
        .post-list {
            margin: 30px 0;
        }
        .post-item {
            margin: 25px 0;
            padding: 25px;
            border: 1px solid #e1e4e8;
            border-radius: 8px;
            background: #fafbfc;
            transition: all 0.2s ease;
            position: relative;
        }
        .post-item:hover {
            border-color: #0366d6;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transform: translateY(-3px);
        }
        .post-title {
            margin: 0 0 10px 0;
            font-size: 1.4em;
        }
        .post-title a {
            color: #24292e;
            text-decoration: none;
            display: block;
        }
        .post-title a:hover {
            color: #0366d6;
        }
        .post-meta {
            color: #6a737d;
            font-size: 0.9em;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .post-date {
            background: #e1e4e8;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 0.85em;
        }
        .post-category {
            color: #0366d6;
            font-weight: 500;
        }
        .post-excerpt {
            color: #444;
            margin: 15px 0;
            line-height: 1.5;
        }
        .read-more {
            display: inline-block;
            color: #0366d6;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border: 1px solid #0366d6;
            border-radius: 4px;
            transition: all 0.2s ease;
        }
        .read-more:hover {
            background: #0366d6;
            color: white;
        }
        .year-section {
            margin: 40px 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #e1e4e8;
            font-size: 1.5em;
            color: #24292e;
        }
        .no-posts {
            text-align: center;
            padding: 50px;
            color: #6a737d;
            border: 2px dashed #e1e4e8;
            border-radius: 8px;
            background: #fafbfc;
            font-size: 1.1em;
        }
        footer {
            margin-top: 50px;
            padding-top: 20px;
            border-top: 1px solid #eaeaea;
            color: #6a737d;
            font-size: 0.9em;
            text-align: center;
        }
        .archive-link {
            display: inline-block;
            margin-top: 20px;
            color: #0366d6;
            text-decoration: none;
            font-weight: 500;
        }
        @media (max-width: 600px) {
            body { padding: 15px; }
            h1 { font-size: 2em; }
            .post-item { padding: 20px; }
        }
    </style>
</head>
<body>
    <header>
        <h1>Hulandy's Blog</h1>
        <p class="subtitle">知识分享 • 技术笔记 • 生活记录</p>
    </header>
    
    <div class="stats">
        📊 统计: 共 <strong id="total-count">0</strong> 篇文章，覆盖 <strong id="year-count">0</strong> 个年份
    </div>
EOF

# 按年份分组文章
declare -A year_counts
declare -A year_posts

# 处理每篇文章
while IFS= read -r file; do
    filename=$(basename "$file" .md)
    dir=$(dirname "$file")
    
    # 提取日期（从文件名或文件夹名）
    if [[ "$filename" =~ ^([0-9]{4}-[0-9]{2}-[0-9]{2})-(.+)$ ]]; then
        date_str="${BASH_REMATCH[1]}"
        title="${BASH_REMATCH[2]}"
        year=${date_str:0:4}
    else
        # 尝试从文件夹名获取年份
        year=$(basename "$dir")
        if [[ ! "$year" =~ ^[0-9]{4}$ ]]; then
            year="未分类"
        fi
        date_str="未知日期"
        title="$filename"
    fi
    
    # 清理标题
    title=$(echo "$title" | sed 's/-/ /g')
    
    # 获取摘要（前150字符）
    excerpt=$(head -n 10 "$file" | grep -v "^#" | head -c 150 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    if [ ${#excerpt} -eq 150 ]; then
        excerpt="$excerpt..."
    fi
    
    # 存储到对应年份
    year_counts[$year]=$((year_counts[$year] + 1))
    year_posts[$year]+="<div class='post-item'>
            <h3 class='post-title'><a href='$file'>$title</a></h3>
            <div class='post-meta'>
                <span class='post-date'>📅 $date_str</span>
                <span class='post-category'>年份: $year</span>
            </div>
            <p class='post-excerpt'>$excerpt</p>
            <a href='$file' class='read-more'>阅读全文 →</a>
        </div>"
    
done < /tmp/article_list.txt

# 按年份倒序输出
echo "    <div class='post-list'>" >> index.html

if [ ${#year_counts[@]} -eq 0 ]; then
    echo "        <div class='no-posts'>📝 还没有文章，快去添加吧！</div>" >> index.html
else
    # 计算总文章数
    total=0
    for year in "${!year_counts[@]}"; do
        total=$((total + year_counts[$year]))
    done
    
    # 更新统计信息
    sed -i "s/id=\"total-count\">0</id=\"total-count\">$total</" index.html
    sed -i "s/id=\"year-count\">0</id=\"year-count\">${#year_counts[@]}</" index.html
    
    # 按年份倒序输出
    for year in $(printf '%s\n' "${!year_counts[@]}" | sort -rn); do
        echo "        <h2 class='year-section'>📅 $year 年 (${year_counts[$year]} 篇)</h2>" >> index.html
        echo "${year_posts[$year]}" >> index.html
    done
fi

cat >> index.html << 'EOF'
    </div>
    
    <footer>
        <p>© 2024 Hulandy's Blog. 基于 GitHub Pages 构建。</p>
        <p>使用 <a href="https://pages.github.com/" target="_blank">GitHub Pages</a> 和静态生成技术</p>
        <a href="posts/" class="archive-link">📚 查看文章归档</a>
    </footer>
    
    <script>
        // 添加一些交互效果
        document.addEventListener('DOMContentLoaded', function() {
            // 文章点击统计
            const articles = document.querySelectorAll('.post-title a');
            articles.forEach(article => {
                article.addEventListener('click', function() {
                    console.log('访问文章:', this.textContent);
                });
            });
            
            // 平滑滚动
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function(e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({ behavior: 'smooth' });
                    }
                });
            });
            
            // 随机颜色标签（可选）
            const tags = document.querySelectorAll('.post-category');
            const colors = ['#0366d6', '#28a745', '#6f42c1', '#d73a49', '#f66a0a'];
            tags.forEach(tag => {
                const color = colors[Math.floor(Math.random() * colors.length)];
                tag.style.color = color;
            });
        });
    </script>
</body>
</html>
EOF

echo "✅ 首页生成完成！"
echo "📊 文章统计:"
echo "-------------------"
for year in $(printf '%s\n' "${!year_counts[@]}" | sort -rn); do
    echo "$year 年: ${year_counts[$year]} 篇"
done
echo "-------------------"
echo "总计: $total 篇文章"
