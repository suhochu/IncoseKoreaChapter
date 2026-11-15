package SprintMeetings_2026_Q4 {
    doc
    /* [1. Meeting 폴더 매핑]
     * 2026년 4분기 킥오프 및 격주 온라인 스프린트 미팅 기록과 단기 Action Item 관리.
     *
     * [새 분기 회의록 추가] 파일명 'N_SprintMeetings_YYYY_Qn.sysml', 패키지명 'SprintMeetings_YYYY_Qn' 으로 만들고
     * 스프린트(Sprint)와 회의(ChapterSprintMeeting) usage만 추가한다. 스키마 def는 수정하지 않는다.
     */
    private import ScalarValues::*;
    private import Time::*;
    private import StakeholderDefinitions::*;
    private import ChapterMembersDirectory::*;
    private import ChapterSystemContext::*;
    private import ChapterSprint::*;

    // =========================================================================
    // 0. 스프린트 정의 (Action Item/과제는 이 usage를 ref로 참조)
    // =========================================================================
    item sprint1 : Sprint {
        :>> sprintNo = 1;
        attribute :>> endDate {
            :>> year = 2026;
            :>> month = 10;
            :>> day = 23;
        }
    }

    item sprint2 : Sprint {
        :>> sprintNo = 2;
        attribute :>> endDate {
            :>> year = 2026;
            :>> month = 11;
            :>> day = 13;
        }
    }

    item sprint3 : Sprint {
        :>> sprintNo = 3;
        attribute :>> endDate {
            :>> year = 2026;
            :>> month = 11;
            :>> day = 27;
        }
    }

    // =========================================================================
    // 1. 2026-10-09 킥오프 미팅 Usage
    // =========================================================================
    action kickOffMeeting_20261009 : ChapterSprintMeeting {
        in :>> mode = OnlineExchangeKind::projectLab;

        attribute :>> meetingDate : Iso8601DateTimeStructure {
            :>> year = 2026;
            :>> month = 10;
            :>> day = 9;
            :>> hour = 18;
            :>> minute = 0;
            :>> second = 0;
            :>> hourOffset = 9; // KST 시차 (UTC+9)
            :>> minuteOffset = 0;
        }
        :>> location = "사당역 주변 셀스스토리 8인 회의실 / 우담정";

        ref :>> attendees = ('이중윤', '서은석', '추수호', '최성열', '이수', '박홍석');

        :>> keyDecisions = (
            "싱크탱크(Think-Tank)가 아닌 실제 산출물을 만드는 도탱크(Do-Tank) 지향",
            "자동차는 SDV 비히클 전체, 우주는 임무 시스템 전체를 대상으로 Operational Stakeholder Requirement부터 하향식 모델링",
            "기업 내부 민감 데이터 문서화 금지, AI 및 공개 데이터를 기반으로 3개월 단위 레고 블록 모델링 수행",
            "공식 소통은 카카오톡, 저장소는 Google Workspace 및 GitHub, 격주(2주) 웹 미팅 및 분기(3개월) 오프라인 모임 진행"
        );

        out item :>> producedArtifact : ChapterArtifact {
            :>> title = "INCOSE Korea KickOff Meeting (20261009) - 회의록";
            ref :>> owner = '추수호';
            :>> locationURL =
                "https://drive.google.com/drive/folders/1-6HQj61Tbnf058-X5QRyGfeXwE0YXCtw?usp=drive_link";
        }

        action ai1_setupChannels : ActionItemTask {
            ref :>> owner = '추수호';
            :>> taskDescription =
                "카카오톡 단체방 개설 및 미참석 3명 동의 후 초대, 구글 워크스페이스 및 GitHub 세팅";
            :>> isImmediate = true;
        }
        action ai2_selectTargetSoI : ActionItemTask {
            ref :>> owner = ('추수호', '최성열', '이수', '박홍석');
            :>> taskDescription =
                "각자 모델링할 대상 시스템(Engineering Question & SoI) 선정 및 1차 웹 미팅 발표 준비";
            ref :>> dueSprint = sprint1;
        }
    }

    // =========================================================================
    // 2. 2026-10-30 1차 온라인 스프린트 미팅 Usage
    // =========================================================================
    action onlineMeeting1_20261030 : ChapterSprintMeeting {
        in :>> mode = OnlineExchangeKind::onlineReview;

        attribute :>> meetingDate : Iso8601DateTimeStructure {
            :>> year = 2026;
            :>> month = 10;
            :>> day = 30;
            :>> hour = 19;
            :>> minute = 52;
            :>> second = 0;
            :>> hourOffset = 9; // KST 시차 (UTC+9)
            :>> minuteOffset = 0;
        }
        :>> location = "온라인 화상 회의 (Google Meet) 및 SE-Labs AI 협업 공간";

        ref :>> attendees = (
            '이중윤', '추수호', '김다운', '박홍석', '박승훈', '최성열', '구정모', '김희재', '최지원'
        );

        :>> keyDecisions = (
            "워킹그룹별 대상 시스템(SOI) 확정: 다목적 쿼드콥터 드론(1. Aerospace), 소프트웨어 중심 자동차 SDV(2. Automotive), EUV 제니스 반도체 장비(4. Semiconductor), 재난 탐색 및 구조 지원 로봇(3. IT)",
            "2035년 롱텀 목표 시점 설정 및 DoDAF 2.02 프레임워크, SysML v2, SE-Labs 도구를 표준으로 활용하며 워킹그룹 간 AV-1, AV-2, OV-1 목차 구조를 통일",
            "기업별 기밀 정보를 철저히 배제하고 오픈소스 및 공통 문서를 기반으로 인코즈 코리아 챕터(INCOSE Korea Chapter) 레퍼런스 아키텍처로 공개 및 활용",
            "다목적 드론 시스템은 감시정찰, 공격, 보급 3대 임무별로 PESTEL-CTIMMRA 운영 맥락, 위협/환경 조건, 공급망, 가정/제약, 이해관계자 관심사 및 OV-1 시나리오(전형적 조건 및 최악 조건)를 각각 분리 작성",
            "효과 척도(MOE)는 시스템 내부 성능이 아닌 상위 임무 성공 여부 및 고객/공장 효과성(와우 포인트, 웨이퍼 수율/품질 등)에 초점을 맞추고, 직접 측정 가능한 말단 지표를 포함한 계층 구조로 정의",
            "반도체 장비 등 컴포넌트 성격의 시스템은 내부 기능/인터록보다 상위 추상화 수준(Level 0 컨텍스트, 타 공정 연계, 수요처 공장별 베리에이션)부터 하향식으로 재정의"
        );

        out item :>> producedArtifact : ChapterArtifact {
            :>> title = "[Incose Korea Chapter] 1st Online Meeting (20261030) - 회의록";
            ref :>> owner = '추수호';
            :>> locationURL =
                "https://drive.google.com/file/d/1fub4f8KklxVbGjWEzn0hmlWP-RMrTL4Q/view?usp=drive_link";
        }

        action ai1_unifyDocumentStructure : ActionItemTask {
            ref :>> owner = ('추수호', '김다운', '최성열', '박홍석', '구정모');
            :>> taskDescription =
                "전 워킹그룹 간 DoDAF 기반 AV-1, AV-2, OV-1 문서 및 모델의 목차 구조를 동일하게 통일하고, 작업 중 유용한 AI 프롬프트 및 워크플로우를 프로젝트 내 '6. Projects/3. AI Skills' 폴더에 공유";
            ref :>> dueSprint = sprint2;
        }

        action ai2_aerospaceDroneConOps : ActionItemTask {
            ref :>> owner = ('김다운', '박승훈', '박홍석', '이수');
            :>> taskDescription =
                "감시정찰/공격/보급 3가지 임무별 독립된 OV-1(정상/최악 조건 시나리오 포함) 작성, PESTEL-CTIMMRA 맥락 분석표/위협/공급망/제약/이해관계자 임무별 분리, 작전 효과 중심의 MOE 계층 구조화 및 OV-5b 액티비티 모델링 진행";
            ref :>> dueSprint = sprint2;
        }

        action ai3_automotiveSdvConOps : ActionItemTask {
            ref :>> owner = ('최성열', '추수호');
            :>> taskDescription =
                "PESTEL 분석 자료를 타 팀과 공유하고, 10~20년 장기 운용 가치 등 사용자에게 감동을 주는 와우 포인트(Wow Point) 및 MOE 계층 구조를 반영하여 세부 운용 시나리오 보완 및 액티비티 모델(OV-5b) 개발";
            ref :>> dueSprint = sprint2;
        }

        action ai4_semiconductorContextAndVariation : ActionItemTask {
            ref :>> owner = '김희재';
            :>> taskDescription =
                "EUV 제니스 장비 내부 기능 대신 상위 추상화 수준(Level 0)에서 리소그래피 공정 및 타 공정과의 외부 컨텍스트를 먼저 정의하고, 납품될 다양한 반도체 공장 환경에 대한 베리에이션(Variation) 및 공장 수율/품질 관점의 MOE 설정";
            ref :>> dueSprint = sprint2;
        }

        action ai5_roboticsDisasterConOps : ActionItemTask {
            ref :>> owner = ('구정모', '최지원', '박홍석');
            :>> taskDescription =
                "재난 탐색 및 구조 지원 로봇 시스템의 통일된 AV-1, OV-1 목차 구조 반영 및 기본(Nominal) 운용 시나리오와 최악 조건(통신 두절, 침수 등) 시나리오 구체화";
            ref :>> dueSprint = sprint2;
        }

        action ai6_seLabsWorkspaceAndSeminar : ActionItemTask {
            ref :>> owner = '박홍석';
            :>> taskDescription =
                "SE-Labs AI 내 INCOSE Korea Chapter 팀 공간 공유/초대 및 팀원들을 위한 SE-Labs AI 모델링 도구 사용법 세미나 일정 조율 및 진행 ('4. Tools' 연계)";
            :>> isImmediate = true;
        }

        action ai7_nextMeetingVote : ActionItemTask {
            ref :>> owner = '추수호';
            :>> taskDescription =
                "'7. Source' 폴더(PESTEL-CTIMMRA, AI 프롬프트, MBSE 쿡북 자료) 안내 및 격주 금요일 기준 차기(2차) 온라인 미팅 일정 확정 투표 진행";
            attribute :>> dueDate : Iso8601DateTimeStructure {
                :>> year = 2026;
                :>> month = 11;
                :>> day = 4;
            }
        }
    }

    // =========================================================================
    // 3. 2026-11-13 2차 온라인 스프린트 미팅 Usage
    // =========================================================================

    action onlineMeeting2_20261113 : ChapterSprintMeeting {
        in :>> mode = OnlineExchangeKind::onlineReview;

        attribute :>> meetingDate : Iso8601DateTimeStructure {
            :>> year = 2026;
            :>> month = 11;
            :>> day = 13;
            :>> hour = 19;
            :>> minute = 53;
            :>> second = 0;
            :>> hourOffset = 9; // KST 시차 (UTC+9)
            :>> minuteOffset = 0;
        }
        :>> location = "온라인 화상 회의 (Google Meet) 및 SE-Labs AI 협업 공간";

        ref :>> attendees = ('이중윤', '추수호', '박홍석', '최성열', '김희재');

        :>> keyDecisions = (
            "오토모티브 워킹그룹(2. Automotive) 대상 시스템을 '인간-AI-다중로봇 공생형 전주기 자율주행 모빌리티 복합체계(SoS)'로 확장 채택하고, 7대 구성 시스템(인간 아키텍트, 생성형 AI 오케스트레이션, SDV 플릿, 다종 전주기 물리로봇 작업단, 마이크로팩토리/정비소 디포, 외부 V2X/스마트그리드, 검증 및 블랙박스/리사이클링 관리 시스템)으로 정의",
            "생성형 AI 설계 결과물 검증 시 AI가 생성한 평가 루브릭에 의존하지 않고, 아키텍처 모델을 설명 가능한 AI(Explainable AI) 형태로 작성하여 인간 아키텍트가 직접 읽고 검토·합의·승인하는 거버넌스 확립",
            "이해관계자/사용자 관점의 운영 효과 척도(MOE)와 개발자 관점의 시스템 성능 척도(MOP)를 명확히 분리 정의하고, 설계 초기(V-사이클 좌측 상단 개념 설계 단계)에서 시뮬레이션과 실험, 현실적인 해저드 시나리오 기반 FMEA를 통해 MOE 달성 여부를 사전 검증",
            "단일 시스템 및 복합체계(SoS) 개발 시 포트폴리오 관점의 Capability View(CV)는 생략하고, AV-1, AV-2, OV-1(유스케이스별 운영 개념도, 줄글 시나리오, MOE 통합), OV-5b(액티비티 모델 및 박스별 목표값/한계값 성능 기입), SV-10c(시스템 기능 흐름도 및 인간을 머신 펑션으로 포함한 수행 주체 할당) 순서로 모델링 절차 표준화",
            "SE-Labs AI 내 상세 연결 패널을 활용하여 운영 액티비티(OV-5b)와 시스템 펑션(SV-10c) 간 할당(Allocation) 및 구현(implementedBy / traceTo) 추적성 관계를 설정",
            "SE-Labs AI의 메타모델 관리 모드(Definition)와 사용 모드(Usage) 분리 구조를 적용하되, 프로젝트 거버넌스를 위해 표준 메타모델 변경은 통제(Change Process 적용)하고 기업별 독립 프로세스는 사용자 정의(User-defined) 방식으로 확장 지원하며, VS Code 탐색기 및 GitHub 베이스라인 연동을 통해 형상 관리 수행",
            "반도체 워킹그룹(4. Semiconductor)의 EUV 제니스(EUV Zenith) 진공 펌프 시스템은 ASML 노광 장비(스캐너/소스)의 진공 및 수소 환경 조성을 미션 서비스(수소 회수, 진공 펌핑, 산소 누설 감시, 공기 기반 수소 희석 배출 및 공급 허가 인터록 신호 공유)로 정의하고, 규격 한계값 외에 자체 개발 목표값(10% 마진 등)과 허용 산포(3시그마) 통제 기준 및 내·외부 최악 조건(부품 산포, 정전/전력 불안정, 지진 등) 시나리오를 모델에 반영"
        );

        out item :>> producedArtifact : ChapterArtifact {
            :>> title = "[Incose Korea Chapter] 2nd Online Meeting (20261113) - 회의록 및 스크립트";
            ref :>> owner = '추수호';
            :>> locationURL = "TBD"; // Google Drive 업로드 후 링크 업데이트 필요
        }

        action ai1_automotiveMoeMopAndScopeRefinement : ActionItemTask {
            ref :>> owner = ('추수호', '최성열');
            :>> taskDescription =
                "사용자 관점의 운영 효과 척도(MOE)와 개발자 관점의 시스템 성능 척도(MOP)를 분리 정의하여 시나리오 필요성과 연계 보강하고, 다종 전주기 물리로봇 작업단(CS4)의 개념 스코프를 외부 로봇 전문 기업(보스턴 다이노믹스 등)에 구체적으로 제안 가능한 수준으로 상세화";
            ref :>> dueSprint = sprint3;
        }

        action ai2_automotiveArchitectureModelingAndPresentation : ActionItemTask {
            ref :>> owner = ('추수호', '최성열');
            :>> taskDescription =
                "전체 운영 시나리오 목록 중 핵심 메인 시나리오(5~6개)를 선정하여 인간 검토 기반으로 MOE 달성 여부를 확인한 뒤, SE-Labs에서 OV-1 보완, OV-5b 액티비티 모델(목표값/한계값 포함) 및 SV-10c 시스템 기능 모델 생성, 액티비티-펑션 간 구현(Allocation/Implements) 관계 매핑을 수행하고 차기 회의에서 발표";
            ref :>> dueSprint = sprint3;
        }

        action ai3_seLabsDiscussionInviteShare : ActionItemTask {
            ref :>> owner = '박홍석';
            :>> taskDescription =
                "SE-Labs 내 INCOSE Korea Chapter 조직 및 프로젝트 토론탭/이슈 게시판을 활용할 수 있도록 초대 링크를 채팅방에 공유";
            :>> isImmediate = true;
        }

        action ai4_semiconductorWorstCaseAndMrsSpec : ActionItemTask {
            ref :>> owner = '김희재';
            :>> taskDescription =
                "EUV 제니스 장비의 한계 규격 외 자체 개발 목표값 및 허용 산포(3시그마) 통제 목표를 설정하고, 내·외부 최악 조건(부품 산포, 정전, 전력 흔들림, 지진 등) 시나리오와 시장 요구사항 명세(MRS) 기반의 경쟁사 대비 차별화 포인트(Beating Point)를 반영하여 시스템 모델 설계 및 기능 규격 산출 후 발표 자료 업데이트";
            ref :>> dueSprint = sprint3;
        }
    }
} // package SprintMeetings_2026_Q4
