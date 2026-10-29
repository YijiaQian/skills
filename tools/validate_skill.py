#!/usr/bin/env python3
"""校验一个技能目录的结构与引用。

用法：
    python tools/validate_skill.py <技能目录>

只检查结构和文件一致性，不判断内容质量，也不代表模型上真的有效。
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

FENCE = re.compile(r"(?ms)^(`{3,}|~{3,})[^\n]*\n.*?^\1\s*$")
LINK = re.compile(r"\]\(([^)]+)\)")


def parse_frontmatter(text: str) -> dict[str, str]:
    parts = text.split("---")
    if len(parts) < 3 or parts[0].strip():
        raise ValueError("SKILL.md 必须以 --- 包裹的 frontmatter 开头")
    data: dict[str, str] = {}
    for line in parts[1].splitlines():
        if ":" in line and not line.startswith((" ", "\t")):
            key, value = line.split(":", 1)
            data[key.strip()] = value.strip().strip("'\"")
    return data


def check(skill_dir: Path) -> list[str]:
    problems: list[str] = []

    skill_md = skill_dir / "SKILL.md"
    if not skill_md.is_file():
        return [f"缺少 {skill_md}"]

    text = skill_md.read_text(encoding="utf-8")
    try:
        meta = parse_frontmatter(text)
    except ValueError as exc:
        return [str(exc)]

    for key in ("name", "description"):
        if not meta.get(key):
            problems.append(f"frontmatter 缺少 {key}")

    name = meta.get("name", "")
    if name and name != skill_dir.name:
        problems.append(f"name={name!r} 与目录名 {skill_dir.name!r} 不一致")

    description = meta.get("description", "")
    if len(description) > 1024:
        problems.append(f"description 长度 {len(description)} 超过 1024")
    if len(description) < 20:
        problems.append("description 过短，可能无法被隐式触发")

    for path in sorted(p for p in skill_dir.rglob("*") if p.is_file()):
        if ".git" in path.parts:
            continue
        raw = path.read_bytes()
        try:
            content = raw.decode("utf-8")
        except UnicodeDecodeError:
            problems.append(f"{path.relative_to(skill_dir)} 不是合法 UTF-8")
            continue
        if "\ufffd" in content:
            problems.append(f"{path.relative_to(skill_dir)} 含替换字符 U+FFFD")
        if path.suffix != ".md":
            continue
        prose = FENCE.sub("", content)
        for target in LINK.findall(prose):
            if re.match(r"(https?:|mailto:|#)", target):
                continue
            local = target.split("#")[0]
            if local and not (path.parent / local).exists():
                problems.append(f"{path.relative_to(skill_dir)} 的链接目标不存在：{target}")

    return problems


def main(argv: list[str]) -> int:
    if len(argv) != 2:
        print("用法: python tools/validate_skill.py <技能目录>", file=sys.stderr)
        return 2

    skill_dir = Path(argv[1]).resolve()
    if not skill_dir.is_dir():
        print(f"不是目录: {skill_dir}", file=sys.stderr)
        return 2

    problems = check(skill_dir)
    if problems:
        print(f"未通过：{skill_dir}")
        for item in problems:
            print(f"  - {item}")
        return 1

    print(f"通过：{skill_dir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
