# 来源与设计取舍

整理日期：2026-10-29。以下材料用于形成写作规则，不构成跨模型效果保证。技能正文和教学示例重新编写；不依赖这些项目的运行代码、账号或外部 API。

## 直接相关的中文材料

- **《GPT 黑话、口癖、文风及语言边界的讨论》**：通过用户本地知识库核读已保存的公众号正文。主要吸收“必要术语保留”“翻译腔需还原为自然中文”“补回过度压缩的操作与关系”。其关于后训练如何造成口癖的解释属于作者分析，本技能不将其作为已证实机制，也不据此断言 GPT 一定比 Gemini 难读。[原文](https://mp.weixin.qq.com/s?__biz=Mzg2ODYyOTk2Mw%3D%3D&mid=2247483744&idx=1&sn=a5925c226cec4c7ce796f2feb571c99b)。本次使用本地已保存版本，未重新核实公众号网页是否更新。
- **[Humanizer-zh 的 SKILL.md](https://github.com/op7418/Humanizer-zh/blob/main/SKILL.md)**：本地 README 与网上技能正文交叉阅读。吸收保留数字、条件、归因、不确定性和完成状态，避免把句式清单当黑名单，以及保护代码与链接的边界。它主要编辑已有文字；本技能增加了面向陌生读者的生成、解释和必要扩写。

## 技术写作与明白语言指南

- **[Google Technical Writing: Words](https://developers.google.com/tech-writing/one/words)**：核读官方正文。陌生术语应给解释或链接，名称保持一致；新缩写可能增加读者在脑中展开的负担。因此术语数量下降不等于理解成本下降，首次只写英文全称也可能不够。
- **[GOV.UK: Use clear language](https://guidance.publishing.service.gov.uk/writing-to-gov-uk-standards/writing-guidelines/clear-language/)**：核读官方正文。专业读者也需要清楚的语言；必要术语可保留并在首次出现时解释；行话应展开为实际在做的事。该页明确不以整页总长度设上下限。本技能没有将其英文词数、英国法律用语或缩写规范直接照搬到中文。

## 现有技能的可借鉴之处与限制

- **[writing-clearly-and-concisely](https://github.com/softaworks/agent-toolkit/blob/main/skills/writing-clearly-and-concisely/SKILL.md)**：核读技能入口，未读其全部参考文件或运行。吸收具体表达、段落主题和相关信息放在一起。其删冗余目标不等于缩短每一次回答；不照搬英文标点规则，也不继承自动委派流程。
- **[blader/humanizer](https://github.com/blader/humanizer/blob/main/SKILL.md)**：核读入口前 7000 字符，含工作流程、声音与输出模式，未完整审计。吸收先保留主张再处理模板表达。本技能不默认交付中间稿或擅自增加作者反应。
- **[stop-slop](https://github.com/hardikpandya/stop-slop/blob/main/SKILL.md)**：核读入口。具体动词和减少无内容的铺垫有帮助；一律删副词、禁用被动句、每句必须有人类主语等规则过强，未采用。其自评分不作为验收依据。
- **[De-AI Prompt Enhancer & Writer Booster](https://github.com/OUBIGFA/De-AI-Prompt-Enhancer-Writer-Booster-SKILL)**：本地与网上 README 核读，未核对所有技能文件或执行脚本。其作者风格复现可用于观点文，但“半文半白”和固定句式禁用未必符合普通读者的理解需要。本技能不移植作者经历、数据或文风。

## 提示与承载方式

- **[OpenAI: Prompt engineering](https://developers.openai.com/api/docs/guides/prompt-engineering)**：核读官方正文，支持明确行为要求、提供多样输入输出示例，以及用实际评估检查提示改变。文档提醒同系列不同版本也可能表现不同。
- **[Google: Prompt design strategies](https://ai.google.dev/gemini-api/docs/prompting-strategies)**：核读官方正文，支持明确读者和输出约束、用示例控制表达方式、根据实际输出迭代。不将页面的任意模型参数解释当作所有模型的固定配置。
- **[OpenAI: Build skills](https://learn.chatgpt.com/docs/build-skills)**：核读官方正文。技能可能通过明确提及或任务匹配加载；安装技能不等于每条回复自动使用。[AGENTS.md 指南](https://learn.chatgpt.com/docs/agent-configuration/agents-md)可用于持续偏好。
- **[Codex: Skills](https://docs.arantic.com/codex/skills)**：核读第三方整理页，其"渐进披露（会话开始只加载 name、description 与路径，命中后才读 SKILL.md）"与官方说明一致；页内的分层对照表（`AGENTS.md` 每轮加载、技能按描述匹配、hooks 由生命周期事件确定性触发）作为"常驻规则与按需流程分开"的依据，未逐条核实其全部陈述。由此得出的结论：需要每条回复都生效的写作规则放常驻指令文件，完整流程放技能。
- **[Claude Code: Output styles](https://code.claude.com/docs/en/output-styles)**：核读官方正文。会话层面的风格适合持续影响回复，技能适合特定任务。迁移到其他产品时，以该产品实际支持的配置为准。

可读性、自然程度和事实准确性要分别检查。本次未做 GPT/Gemini 同题盲测，未建立中文阅读等级阈值，不保证任何 AI 检测器结果。
