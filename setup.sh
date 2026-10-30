#!/usr/bin/env bash
# 사용법: 작업 공간 루트에서
#   git clone https://github.com/yijuuuun/my-codex-kit.git .kit && bash .kit/setup.sh
# 일부 경로에 쓰기가 막혀도 나머지는 계속 진행한다.

KIT="$(cd "$(dirname "$0")" && pwd)"
WS="$(pwd)"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"

ok()   { echo "  [OK]   $1"; }
skip() { echo "  [skip] $1"; }

echo "my-codex-kit 설치"

# 1) 전역 AGENTS.md (기존 내용이 있으면 덮어쓰지 않고 뒤에 추가)
if mkdir -p "$CODEX_HOME" 2>/dev/null; then
  if [ -f "$CODEX_HOME/AGENTS.md" ]; then
    if grep -q "작업 규칙 (Codex용)" "$CODEX_HOME/AGENTS.md"; then
      ok "AGENTS.md 이미 있음 -> $CODEX_HOME/AGENTS.md"
    elif { printf '\n\n'; cat "$KIT/AGENTS.md"; } >> "$CODEX_HOME/AGENTS.md" 2>/dev/null; then
      ok "AGENTS.md 기존 파일 뒤에 추가 -> $CODEX_HOME/AGENTS.md"
    else
      skip "AGENTS.md 추가 실패 ($CODEX_HOME)"
    fi
  elif cp "$KIT/AGENTS.md" "$CODEX_HOME/AGENTS.md" 2>/dev/null; then
    ok "AGENTS.md -> $CODEX_HOME/AGENTS.md"
  else
    skip "AGENTS.md 복사 실패 ($CODEX_HOME)"
  fi
else
  skip "$CODEX_HOME 생성 불가"
fi

# 2) Skill: Codex 버전에 따라 경로가 달라서 후보 경로에 모두 복사
for dir in "$CODEX_HOME/skills" "$HOME/.agents/skills" "$WS/.codex/skills" "$WS/.agents/skills"; do
  if mkdir -p "$dir" 2>/dev/null && cp -R "$KIT/skills/." "$dir/" 2>/dev/null; then
    ok "skills -> $dir"
  else
    skip "skills -> $dir"
  fi
done

# 3) 템플릿
if mkdir -p "$CODEX_HOME/kit-templates" 2>/dev/null && cp -R "$KIT/templates/." "$CODEX_HOME/kit-templates/" 2>/dev/null; then
  ok "templates -> $CODEX_HOME/kit-templates"
fi

cat <<'EOF'

다음 단계
  1. codex가 이미 켜져 있으면 종료 후 다시 실행 (AGENTS.md는 시작할 때 읽음)
  2. codex에 아래 문장을 그대로 입력 (경로 인식과 상관없이 확실하게 적용됨):

     .kit/START.md를 읽고 그대로 따라줘.

  MCP가 필요하면 플랫폼 MCP 탭에 .kit/mcp.json 내용을 붙여넣기
EOF
