# Supabase 接入说明

这个页面已经预留好了 Supabase 读取和写入纪念时间的逻辑。

你现在需要做 3 件事：

1. 创建 Supabase 项目
2. 执行 SQL 建表
3. 把 `Project URL` 和 `anon public key` 填回 `index.html`

## 1. 创建项目

1. 打开 <https://supabase.com/>
2. 注册并登录
3. 点击 `New project`
4. 选择组织后新建项目
5. 设置数据库密码
6. 等待项目初始化完成

## 2. 获取 URL 和 anon key

进入项目后：

1. 打开 `Settings`
2. 打开 `API`
3. 记下这两个值：

- `Project URL`
- `Project API keys` 里的 `anon public`

然后把它们填到 `index.html` 里这个配置对象：

```js
const SUPABASE_CONFIG = {
  url: '这里填 Project URL',
  anonKey: '这里填 anon public key',
  table: 'love_milestones',
  key: 'relationship_start'
};
```

## 3. 在 SQL Editor 执行下面的 SQL

打开 `SQL Editor`，新建查询，然后执行：

```sql
create table if not exists public.love_milestones (
  milestone_key text primary key,
  started_at timestamptz not null,
  created_at timestamptz not null default timezone('utc', now())
);

alter table public.love_milestones enable row level security;

drop policy if exists "public can read milestones" on public.love_milestones;
create policy "public can read milestones"
on public.love_milestones
for select
to anon
using (true);

drop policy if exists "public can insert first milestone" on public.love_milestones;
create policy "public can insert first milestone"
on public.love_milestones
for insert
to anon
with check (milestone_key = 'relationship_start');
```

## 4. 这个表怎么工作

页面会只读写一条数据：

- `milestone_key = relationship_start`
- `started_at = 正式确认的精确时间`

逻辑是：

- 第一次有人点 `好呀` 时，写入当前时间
- 以后所有设备打开页面时，都读取这同一个时间
- 页面会自动计算已经过了多少天、小时、分钟、秒

## 5. 如果以后想手动重置时间

目前最安全的方式不是在前端公开放一个“重置按钮”，而是你自己去 Supabase 后台手动改这条记录。

在 `Table Editor -> love_milestones` 里：

- 找到 `relationship_start`
- 修改 `started_at`

或者在 SQL Editor 执行：

```sql
update public.love_milestones
set started_at = '2026-10-25T20:13:00+08:00'
where milestone_key = 'relationship_start';
```

## 6. 改完别忘了重新发布

把 `index.html` 填好配置后，再执行：

```bash
cd /Users/zhaoshuai/表白
git add .
git commit -m "add supabase anniversary support"
git push
```
