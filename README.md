# 表白页面

这是一个纯静态页面，不需要数据库，也不需要后端服务。

## 最简单的公网发布方式

用 `GitHub Pages` 就可以让任何人通过链接访问：

1. 在 GitHub 新建一个仓库，比如 `biaobai-page`
2. 把这个目录里的 `index.html` 上传到仓库根目录
3. 进入 GitHub 仓库的 `Settings -> Pages`
4. 在 `Build and deployment` 里选择：
   - `Source`: `Deploy from a branch`
   - `Branch`: `main`
   - `Folder`: `/ (root)`
5. 保存后等待几十秒到几分钟
6. 打开生成的链接：

```text
https://你的GitHub用户名.github.io/biaobai-page/
```

## 建议上传哪些文件

- `index.html`
- `README.md`
- `.gitignore`

原始文件 `❤️.html` 可以保留在本地作备份，不一定要上传。

## 数据库说明

这个页面目前是单文件静态页，没有留言、登录、远程保存等功能，所以：

- 想让别人打开页面：不需要数据库
- 想保存留言、访问记录、点击结果：再接免费数据库，例如 `Supabase`

## 如果你想做成独立仓库

建议不要直接在你现在这个大仓库里操作，可以新建一个单独文件夹，只放发布需要的文件。

例如：

```bash
mkdir ~/Desktop/biaobai-page
cp /Users/zhaoshuai/表白/index.html ~/Desktop/biaobai-page/
cp /Users/zhaoshuai/表白/README.md ~/Desktop/biaobai-page/
cp /Users/zhaoshuai/表白/.gitignore ~/Desktop/biaobai-page/
```

然后在这个新文件夹里初始化 Git：

```bash
cd ~/Desktop/biaobai-page
git init
git add .
git commit -m "init confession page"
```

再把它推到你新建的 GitHub 仓库即可。
