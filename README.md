# Skills：把话讲清楚，把项目维护好

给 AI 编程助手的实用技能：用自然中文解释复杂问题，让代码、文档和验证一起更新。

Agent skills for clear Chinese writing and practical project maintenance.

本仓库目前提供两个技能，可用于支持 `SKILL.md` 的助手；安装示例面向 Codex 和 OpenCode。不需要额外的模型 API、账号或运行服务。

## 选一个适合你的技能

| 技能 | 解决什么问题 | 适合什么时候用 |
| --- | --- | --- |
| [plain-language-zh](https://github.com/YijiaQian/skills/tree/skill/plain-language-zh) | 把黑话和过度压缩的句子展开，解释必要术语，保留事实、条件和不确定性 | 写解释、文档、方案、评审意见，或改写难懂的中文 |
| [agent-maintenance](https://github.com/YijiaQian/skills/tree/skill/agent-maintenance) | 核对事实来源，明确文档归属，同步代码与说明，复用已有检查 | 开发、重构和维护项目，整理与实现脱节的文档 |

两者可以搭配：`plain-language-zh` 负责让读者看懂；`agent-maintenance` 负责让修改有来源、说明与实现一致、验证范围说得清楚。

例如：

- **写技术说明**：把“检索链路已经打通”写成具体的数据如何进入索引、怎样查询，以及验证了什么；不凭空补充实现。
- **修改项目**：先读现有规则、源码和测试；接口变化时同步使用说明，运行相关检查。格式检查通过，不等于产品功能正确。

## 快速安装

需要 Git。安装脚本只下载选中的技能分支、检查入口并放入指定目录；不会修改全局指令，也不会给项目安装 lint、hooks 或 CI。目标已有同名目录时，会先改名备份。

### Windows PowerShell

```powershell
git clone --branch main --single-branch https://github.com/YijiaQian/skills.git
cd skills
.\install.ps1 plain-language-zh -Target "$env:USERPROFILE\.agents\skills"
.\install.ps1 agent-maintenance -Target "$env:USERPROFILE\.agents\skills"
```

### macOS / Linux

```bash
git clone --branch main --single-branch https://github.com/YijiaQian/skills.git
cd skills
bash ./install.sh plain-language-zh "$HOME/.agents/skills"
bash ./install.sh agent-maintenance "$HOME/.agents/skills"
```

`~/.agents/skills` 是 Codex 和 OpenCode 支持的用户级技能目录。示例显式指定这个共享目录；省略目标参数时，现有脚本默认安装到 `~/.codex/skills`。其他助手请使用其实际支持的目录。已有安装不会被后台自动更新，重新安装前可先核对对应分支的变更。

## 怎么使用

可以在任务中明确指定：

```text
使用 plain-language-zh，向第一次接触这个项目的人解释它的架构和取舍。
```

```text
使用 agent-maintenance，为当前项目完成这次修改。先读取项目规则，保留已有检查入口，同步相关文档并验证。
```

Codex 也支持用 `$plain-language-zh`、`$agent-maintenance` 点名技能。技能安装后是否自动选择，取决于助手、任务和配置；希望项目任务默认遵循维护规范，可以在全局 `AGENTS.md` 中加入读取技能的约定。配置位置和可复制示例见[持续规则与技能的分工](docs/layering.md)、[通用提示词与配置模板](docs/prompt-templates.md)。

规则进入上下文与模型正确执行规则是两回事。需要确定执行的机械检查，应接入项目的脚本、hook 或 CI；事实是否正确、功能是否满足需求仍需相应验证。本仓库不承诺跨模型通用的效果提升比例。

## 为什么每个技能一个分支

| 分支 | 放什么 |
| --- | --- |
| `main` | 技能索引、安装与校验脚本、通用使用说明 |
| `skill/<name>` | 一个完整技能；根目录就是技能目录，包含 `SKILL.md` 及其引用 |
| `tool/<name>` | 为独立工具预留的分支约定；目前没有工具条目 |
| `chore/*`、`docs/*` 等 | 修改索引或文档的临时工作分支，不是可安装技能 |

因此，浏览 `main` 时看不到全部技能正文，点击上表中的技能链接即可查看。`chore/index-agent-maintenance` 用于给目录表加入新技能，其索引 PR 已合并；技能内容始终在 `skill/agent-maintenance`。独立技能分支不合并进 `main`。

## 校验与贡献

从 `main` 使用校验器，参数是实际安装的技能目录：

```powershell
python -X utf8 tools/validate_skill.py "$env:USERPROFILE\.agents\skills\agent-maintenance"
```

它检查入口元数据、UTF-8 编码与本地文件引用，不判断自然语言结论或模型实际效果。行为变化还应使用真实任务和适当反例验证，不能只检查文件格式。

欢迎通过 Issue 报告具体难读的案例、事实损失或维护规则误用，也欢迎提交 PR。新增技能时保持独立分支结构，附上所需引用、来源和许可，再同步 `main` 的索引；修复问题时请说明触发条件与实际结果，不附带凭据或私有业务材料。

## 许可与来源

`agent-maintenance` 适配自 [WncFht/agent-maintenance](https://github.com/WncFht/agent-maintenance)，技能分支保留上游 MIT 许可、固定版本和文件校验清单。

本仓库原创脚本、通用说明及 `plain-language-zh` 暂未单独指定开源许可证；如需用于再分发，请先联系维护者。仓库公开与授予开源许可是两个独立决定。

技能参考的外部文章与项目仍归各自作者；引用来源不表示转载其全部内容。各技能的具体取舍见对应分支的 `references/sources.md`。
