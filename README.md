# Histb Doc

```bash
# 移除旧版
apt-get remove -y nodejs

# 添加 Node 20 源并安装
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# 验证
node -v   # 应显示 v20.x.x

npm install
npm run build
npm run serve
```

```
https://netlify.com/
```

### 注意，2026年升级到node20，模板升级到3.9.2
