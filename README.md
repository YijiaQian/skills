# skills

个人使用的技能与小工具。每个技能或工具放在自己的分支上，`main` 只放索引、安装脚本和校验脚本。

## 现有条目

| 条目 | 分支 | 说明 |
| --- | --- | --- |
| `plain-language-zh` | `skill/plain-language-zh` | 把话说清楚：减少黑话与生僻词，解释必要术语，收束"缺少 X"式免责清单 |

## 目录与分支约定

- `skill/<name>`：一个可以直接放进技能目录的技能。**分支根目录就是技能目录**（根下是 `SKILL.md`）。
- `tool/<name>`：一个独立小工具。**分支根目录就是工具目录**。
- `main`：索引、安装脚本、校验脚本，不放具体技能内容。

这样约定的好处是：`git clone -b skill/<name>` 出来的文件夹，改个名字就能直接放进 `~/.codex/skills/`，不需要再挑子目录。

代价是分支不便于"一眼看全"。所以新增条目后要回 `main` 更新上表；这也是唯一需要手工同步的地方。

## 装到本地

```powershell
# 装到 %USERPROFILE%\.codex\skills
.\install.ps1 plain-language-zh

# 装到别处（例如另一个 agent 的技能目录）
.\install.ps1 plain-language-zh -Target "D:\some\skills"
```

脚本用 `git clone --depth 1 -b skill/<name>` 拉取，校验根目录存在 `SKILL.md` 后再移动到目标位置；目标已存在时先改名备份为 `<name>.bak-<时间戳>`，不直接覆盖。

Unix 上用 `install.sh`，参数相同：

```bash
./install.sh plain-language-zh
./install.sh plain-language-zh /path/to/skills
```

## 校验

```powershell
python tools/validate_skill.py <技能目录>
```

检查：`SKILL.md` 存在且 frontmatter 有 `name`、`description`；`description` 不超过 1024 字符；正文相对链接指向的文件存在；文件是合法 UTF-8 且无替换字符。

## 新增一个技能

```powershell
git switch --orphan skill/<name>
# 放入 SKILL.md、references/ 等
git add -A
git commit -m "skill: <name>"
git push -u origin skill/<name>
git switch main   # 回到索引，更新上表后再提交
```

`--orphan` 表示这条分支从空树开始，不与 `main` 共享历史。技能之间本来就没有共同代码，这样做比从 `main` 切出来再删文件更干净。

## 说明

- 仓库里的规则来自公开资料、官方文档和实际使用中的调整，具体取舍见各技能分支里的 `references/sources.md`。
- 已知未验证项也写在技能里，不在此处重复。
