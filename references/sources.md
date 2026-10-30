# 来源与复用边界

本技能以 Cursor pstack 的 **unslop** 为主要改写方法，不再维护一套平行的去套话规则。保留 `plain-language-zh` 名称、技能分支和自动发现方式，兼容现有安装与 `$plain-language-zh` 调用。

## 固定上游

- 仓库：[cursor/plugins](https://github.com/cursor/plugins)。作者：Lauren Tan（poteto）。
- 提交：`4dd1d05818d19792e7cd6e818f1667f95f7e1dbe`。
- 原文件：[pstack/skills/unslop/SKILL.md](https://github.com/cursor/plugins/blob/4dd1d05818d19792e7cd6e818f1667f95f7e1dbe/pstack/skills/unslop/SKILL.md)，本地副本：[unslop.md](unslop.md)，内容未经修改。
- 原文 SHA-256：`ccab208e315ce05e2fab8eeee2f7879f1289b5c6844840b2d307adf31c79144f`。
- 许可：[pstack/LICENSE](https://github.com/cursor/plugins/blob/4dd1d05818d19792e7cd6e818f1667f95f7e1dbe/pstack/LICENSE)，MIT，Copyright (c) 2026 Lauren Tan；本地完整副本：[unslop.LICENSE](unslop.LICENSE)。
- 许可 SHA-256：`bc957ca6bee02792566a1a028d105e02e247c6e77cf057061674273da77b200e`。

更新上游时一并核对来源、许可与文件校验值，并抽查中文、英文和受保护的操作内容。无需跟随上游安装其他技能、运行 pstack 流程或委派 Agent。

## 本地适配

`SKILL.md` 仅保留读者与任务边界、必要术语解释、中文标点及保真检查。事实和代码保护优先于上游统一的风格规则。上游文件 frontmatter 中的 `name: unslop` 和 `disable-model-invocation: true` 是原文元数据，不改变本技能入口的名字或自动发现设置。

旧版自行整理的长规则与教学示例已被上述入口和上游原文替代，历史仍可从 [旧版本](https://github.com/YijiaQian/skills/tree/326100def0639c8c849c10752c89a0e736af0d8b) 查阅。本技能不保证任何 AI 检测器分数，结构检查通过也不代表每次改写都保真。
