#!/usr/bin/env bash
# 사용법: 작업 공간 루트에서
#   git clone https://github.com/yijuuuun/my-codex-kit.git .kit && bash .kit/setup.sh
set -euo pipefail

KIT="$(cd "$(dirname "$0")" && pwd)"
WS="$(pwd)"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"

# 1) 전역 AGENTS.md (기존 내용이 있으면 덮어쓰지 않고 뒤에 추가)
mkdir -p "$CODEX_HOME"
if [ -f "$CODEX_HOME/AGENTS.md" ] && ! grep -q "작업 규칙 (Codex용)" "$CODEX_HOME/AGENTS.md"; then
  printf '\n\n' >> "$CODEX_HOME/AGENTS.md"
  cat "$KIT/AGENTS.md" >> "$CODEX_HOME/AGENTS.md"
elif [ ! -f "$CODEX_HOME/AGENTS.md" ]; then
  cp "$KIT/AGENTS.md" "$CODEX_HOME/AGENTS.md"
fi

# 2) Skill: Codex 버전에 따라 경로가 달라서 후보 경로에 모두 복사
for dir in "$CODEX_HOME/skills" "$HOME/.agents/skills" "$WS/.codex/skills" "$WS/.agents/skills"; do
  mkdir -p "$dir"
  cp -R "$KIT/skills/." "$dir/"
done

# 3) 템플릿이 Skill 안에서 보이도록 같이 둠
mkdir -p "$CODEX_HOME/kit-templates"
cp -R "$KIT/templates/." "$CODEX_HOME/kit-templates/"

echo "설치 완료"
echo "  AGENTS.md -> $CODEX_HOME/AGENTS.md"
echo "  skills    -> $CODEX_HOME/skills, ~/.agents/skills, ./.codex/skills, ./.agents/skills"
echo "  MCP       -> 플랫폼 MCP 탭에 $KIT/mcp.json 내용을 붙여넣기 (필요할 때만)"
echo "다음: codex 실행 후 '/skills' 또는 '적용된 AGENTS.md 규칙을 요약해줘'로 인식 여부 확인"
