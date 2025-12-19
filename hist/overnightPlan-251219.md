## Q
https://github.com/aniketkarne/ClaudeNightsWatch

세션 만료 시 기다렸다가 재시작하는 도구를 이용해 큰 작업을 완료할 때까지 진행하려고 합니다.

실행 환경

github codespaces
terminal bash. claude code cli의 skip permission
질의 시 계획을 세우고 자동 수행 각 phase 가 끝나면 실행 및 검증까지 수행하며 도중에 커밋과 푸쉬도 포함합니다. 각 phase는 동적분할로 토큰 제한 내에서 해결하고 모든 계획이 완료될 때까지 반복합니다

## A
해당 repo를 clone 함

## Q
기존 overnight plugin 을 바탕으로 질의에 대해 작업 지시서를 먼저 만들고 세션이 만기되면     
  기다렸다가 다시 시작하는 프로그램 작성                                                      
  의도: 하나의 질의로 끝나지 않는 작업에 대해 명확하게 계획하는 것이 도움이 될 수 있습니다.   
  전체 출력 컨텍스트를 작업에 사용하는 것이 권장됩니다 - 중요한 커밋되지 않은 작업으로        
  컨텍스트가 부족하지 않도록 하세요. 이 작업을 완료할 때까지 체계적으로 계속 작업하세요.      
  배포: claude plugin. .claude-plugin/marketplace.json 포함                                   
  agent friendly
  https://platform.claude.com/docs/ko/build-with-claude/prompt-engineering/claude-4-best-practices#

  ## A
  생성된 Plugin 구조
  work-directive/
  ├── .claude-plugin/
  │   ├── plugin.json          # Plugin manifest
  │   └── marketplace.json     # Marketplace 등록 정보
  ├── agents/
  │   └── directive-planner.md # 작업 계획 및 세션 관리 에이전트
  ├── commands/
  │   ├── plan.md              # /work plan - 작업 지시서 생성
  │   ├── execute.md           # /work execute - 실행
  │   ├── resume.md            # /work resume - 재개
  │   ├── status.md            # /work status - 상태 확인
  │   └── reset.md             # /work reset - 초기화
  ├── hooks/
  │   ├── hooks.json           # Hook 설정
  │   └── scripts/
  │       ├── check-directive.sh      # 세션 시작시 directive 확인
  │       ├── save-session-state.sh   # 세션 종료시 상태 저장
  │       └── track-tool-usage.sh     # 도구 사용 추적
  ├── scripts/
  │   ├── directive-manager.sh        # 상태 관리 스크립트
  │   └── session-restart-daemon.sh   # 자동 재시작 데몬
  ├── examples/
  │   ├── directive.example.json      # Directive JSON 예제
  │   ├── simple-task.example.md      # 간단한 작업 예제
  │   └── complex-task.example.md     # 복잡한 멀티세션 예제
  └── README.md
  핵심 기능
  | 기능             | 설명                                  |
  |------------------|---------------------------------------|
  | 작업 지시서 생성 | 복잡한 질의를 단계별 계획으로 분해    |
  | 세션 경계 감지   | 컨텍스트 한계 접근 시 자동 상태 저장  |
  | 자동 재개        | 새 세션 시작 시 미완료 작업 자동 감지 |
  | 진행 상황 추적   | 모든 단계와 아티팩트 기록             |
  | 데몬 모드        | 세션 만료 후 자동 재시작              |
  사용법
  # 작업 계획 생성
  /work plan "JWT 인증 시스템 구현 - 로그인, 로그아웃, 비밀번호 재설정 포함"
  # 실행
  /work execute
  # 상태 확인
  /work status
  # 재개 (새 세션에서)
  /work resume
  # 자동 재시작 데몬 시작
  ./scripts/session-restart-daemon.sh start
  Agent-Friendly 특징
  - 구조화된 JSON 상태 파일
  - 파싱 가능한 출력 마커: [STEP_COMPLETE:1], [PROGRESS:2/5], [SESSION_BOUNDARY]
  - 예측 가능한 Hook 시스템
  - 자동화 친화적 인터페이스

모든 테스트 통과했습니다.
  테스트 결과 요약
  | 테스트                       | 결과                   |
  |------------------------------|------------------------|
  | Script syntax (3개)          | ✅ OK                  |
  | directive-manager.sh exists  | ✅ false → true        |
  | directive-manager.sh active  | ✅ true                |
  | check-directive.sh hook      | ✅ 활성 directive 감지 |
  | directive-manager.sh archive | ✅ archive 생성        |
  | directive-manager.sh reset   | ✅ 초기화 완료         |
  | plugin.json validation       | ✅ valid JSON          |
  | marketplace.json validation  | ✅ valid JSON          |
  | hooks.json validation        | ✅ valid JSON          |
  커밋 완료
  e93d1a3 feat: add work-directive plugin for session-aware task execution
  - 18 files, 2224 lines
  플러그인 사용 준비 완료
  # 설치
  claude plugins add /workspaces/overnightPlan/work-directive
  # 사용
  /work plan "복잡한 작업 설명"
  /work execute
  /work status
  /work resum