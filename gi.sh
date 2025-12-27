#!/bin/bash

echo "生成静态文章列表..."

# 创建 index.html 并包含静态文章列表
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Hulandy's Blog</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
            line-height: 1.6;
        }
        h1 {
            color: #333;
            border-bottom: 1px solid #eaeaea;
            padding-bottom: 10px;
        }
        .post-list {
            margin-top: 30px;
        }
        .post-item {
            margin: 25px 0;
            padding: 20px;
            border: 1px solid #eaeaea;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .post-item:hover {
            border-color: #0366d6;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .post-title {
            margin: 0 0 10px 0;
            font-size: 1.4em;
        }
        .post-title a {
            color: #0366d6;
            text-decoration: none;
        }
        .post-title a:hover {
            text-decoration: underline;
        }
        .post-date {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        .post-excerpt {
            color: #444;
            margin: 10px 0;
        }
        .read-more {
            color: #0366d6;
            text-decoration: none;
            font-weight: 500;
        }
        .read-more:hover {
            text-decoration: underline;
        }
        footer {
            margin-top: 50px;
            padding-top: 20px;
            border-top: 1px solid #eaeaea;
            color: #666;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <h1>Hulandy's Blog</h1>
    <p>从 WordPress 迁移的静态博客</p>
    
    <div class="post-list">
EOF

# 添加文章列表
if [ -d "posts" ]; then
    echo "添加文章列表..."
    # 按日期倒序排列
    for file in $(ls -r posts/*.md 2>/dev/null | head -20); do
        if [ -f "$file" ]; then
            filename=$(basename "$file" .md)
            date=${filename:0:10}
            title=${filename:11}
            title=$(echo "$title" | sed 's/-/ /g')
            
            # 获取文章摘要（前 100 字符）
            excerpt=$(head -n 20 "$file" | grep -v "^#" | head -c 100 | sed 's/^[ \t]*//')
            
            cat >> index.html << EOF
        <article class="post-item">
            <h2 class="post-title">
                <a href="posts/${filename}.md">${title}</a>
            </h2>
            <div class="post-date">📅 ${date}</div>
            <p class="post-excerpt">${excerpt}...</p>
            <a href="posts/${filename}.md" class="read-more">阅读全文 →</a>
        </article>
EOF
        fi
    done
fi

cat >> index.html << 'EOF'
    </div>
    
    <footer>
        <p>© 2024 Hulandy's Blog. 基于 GitHub Pages 构建。</p>
        <p>文章总数: 
EOF

# 添加文章计数
if [ -d "posts" ]; then
    count=$(ls posts/*.md 2>/dev/null | wc -l)
    echo "<strong>${count}</strong>" >> index.html
else
    echo "<strong>0</strong>" >> index.html
fi

cat >> index.html << 'EOF'
        篇</p>
    </footer>
    
    <script>
        // 简单的交互效果
        document.addEventListener('DOMContentLoaded', function() {
            // 为文章链接添加点击统计（可选）
            const links = document.querySelectorAll('.post-title a');
            links.forEach(link => {
                link.addEventListener('click', function() {
                    console.log('访问文章:', this.textContent);
                });
            });
            
            // 如果浏览器支持，添加平滑滚动
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({ behavior: 'smooth' });
                    }
                });
            });
        });
    </script>
</body>
</html>
EOF

echo "✅ 已生成静态首页"
echo "文章数量: $(ls posts/*.md 2>/dev/null | wc -l)"
