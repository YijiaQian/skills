# 来源与适配

上游：[WncFht/agent-maintenance](https://github.com/WncFht/agent-maintenance)，固定提交 [`527af880f6feb0e352cae42b2c7601dc443b2b70`](https://github.com/WncFht/agent-maintenance/tree/527af880f6feb0e352cae42b2c7601dc443b2b70)，按 [MIT 许可](../LICENSE)复用。

上游是维护包，包含三个技能和工具链；此分支根目录是一个可直接安装的 `agent-maintenance` 技能。根 SKILL.md 是针对 Codex / OpenCode 项目任务增加的组合入口；`rules/` 保留三个技能、全部共享参考、模板及 Notes 规则。`docs/` 只保留采用工具链时需要的说明。保留原文语义，仅调整相对链接；不随包复制上游已实施决策、过程记录或 MPE 预览资源。

`upstream-manifest.json` 登记每份复用文件的上游路径、源 SHA-256 和打包后 SHA-256，用于核对固定快照。目标项目的源码和 AGENTS.md 才是目标事实源；本包不证明目标功能已经验证。

## 安装与默认使用

按个人 skills 仓库约定，`skill/agent-maintenance` 是独立分支，根目录即技能目录，不合并进 main。用 main 分支的安装脚本安装时指定共享目录：

```powershell
.\install.ps1 agent-maintenance -Target "$env:USERPROFILE\.agents\skills"
```

Codex 与 OpenCode 均支持用户级 `~/.agents/skills/<name>/SKILL.md`。在各自全局 AGENTS.md 增加项目任务开工前显式读取此技能的规则，使其成为默认项目约定；仅安装技能不保证每次自动选择。更改全局规则后使用新会话验证。

原工具链和流程文档里的本地链接若指向未分发的脚本、配置或预览载荷，改为固定提交的上游链接；它们是接入参考，不是本技能本地可运行命令。不要在技能目录执行上游 setup，也不要假定目标项目存在相同检查器。根据目标现状复制或实现必要工具并验证，而不是自动整包接入。

## 验证

技能结构可用本机 skill-creator 的 quick_validate.py 和个人 skills main 的 tools/validate_skill.py 检查。manifest 的 packaged_sha256 可逐文件重新计算。行为验收使用新的 Codex / OpenCode 会话，观察实际加载路径与回答，不把结构通过当作效率提升证据。

官方依据：[Codex 技能](https://developers.openai.com/codex/skills/)、[Codex 全局规则](https://developers.openai.com/codex/guides/agents-md/)、[OpenCode 技能](https://opencode.ai/docs/skills/)、[OpenCode 全局规则](https://opencode.ai/docs/rules/)。
