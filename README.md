# my-codex-kit

Codex CLI용 개인 작업 규칙, Skill, 문서 템플릿 모음. 과제 정답이나 코드는 들어 있지 않음.

## 설치
```bash
git clone https://github.com/yijuuuun/my-codex-kit.git .kit && bash .kit/setup.sh
```

그다음 codex를 (재)실행하고 이렇게 입력:
```
.kit/START.md를 읽고 그대로 따라줘.
```

- `START.md`: Codex에게 주는 시작 지시 (규칙·Skill을 경로 상관없이 직접 읽게 함)
- `AGENTS.md`: 작업 규칙 (계획 → 구현 → 기록 → 검증)
- `skills/plan-and-log`: PLAN.md / DECISIONS.md 작성
- `skills/verify`: 검증 루틴과 제출 전 점검
- `templates/`: PLAN.md, DECISIONS.md 틀
- `mcp.json`: 문서 조회용 MCP 설정 (선택)

`.kit` 폴더는 제출물에 섞이지 않게 `.gitignore`에 추가하거나 마지막에 지우기.
