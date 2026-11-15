package SprintMeetings_2026_Q4 {
    doc
    /* [1. Meeting 폴더 매핑]
     * 2026년 4분기 킥오프 및 격주 온라인 스프린트 미팅 기록과 단기 Action Item 관리
     */
    private import ScalarValues::*;
    private import Time::*;
    private import ChapterMembersDirectory::*;
    private import ChapterSystemContext::*;
    private import ChapterConOpsAndLifecycle::ConOps::*;
    private import ChapterSprint::*;

    // =========================================================================
    // 1. 2026-10-09 킥오프 미팅 Usage
    // =========================================================================
    action kickOffMeeting_20261009 : ChapterSprintMeeting {
        in :>> mode = ExchangeModeKind::handsOnLabStyle;

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

        ref :>> attendees = (
            ChapterMembersDirectory::'이중윤', ChapterMembersDirectory::'서은석',
            ChapterMembersDirectory::'추수호', ChapterMembersDirectory::'최성열',
            ChapterMembersDirectory::'이수', ChapterMembersDirectory::'박홍석',
        );

        :>> keyDecisions = (
            "싱크탱크(Think-Tank)가 아닌 실제 산출물을 만드는 도탱크(Do-Tank) 지향",
            "자동차는 SDV 비히클 전체, 우주는 임무 시스템 전체를 대상으로 Operational Stakeholder Requirement부터 하향식 모델링",
            "기업 내부 민감 데이터 문서화 금지, AI 및 공개 데이터를 기반으로 3개월 단위 레고 블록 모델링 수행",
            "공식 소통은 카카오톡, 저장소는 Google Workspace 및 GitHub, 격주(2주) 웹 미팅 및 분기(3개월) 오프라인 모임 진행",
        );

        out item :>> producedArtifact : ChapterArtifact {
            :>> title = "INCOSE Korea KickOff Meeting (20261009) - 회의록";
            :>> category = ArtifactCategoryKind::meetingMinutes;
            :>> owner = "추수호";
            :>> repoFolderPath = "1. Meeting";
            :>> locationURL =
                "https://drive.google.com/drive/folders/1-6HQj61Tbnf058-X5QRyGfeXwE0YXCtw?usp=drive_link";
        }

        action ai1_setupChannels : ActionItemTask {
            ref :>> owner = ChapterMembersDirectory::'추수호';
            :>> taskDescription =
                "카카오톡 단체방 개설 및 미참석 3명 동의 후 초대, 구글 워크스페이스 및 GitHub 세팅";
            :>> dueDate = "Immediate";
        }
        action ai2_selectTargetSoI : ActionItemTask {
            ref :>> owner = (
                ChapterMembersDirectory::'추수호', ChapterMembersDirectory::'최성열',
                ChapterMembersDirectory::'이수', ChapterMembersDirectory::'박홍석',
            );
            :>> taskDescription =
                "각자 모델링할 대상 시스템(Engineering Question & SoI) 선정 및 1차 웹 미팅 발표 준비";
            :>> dueDate = "2026-10-23 (Sprint 1)";
        }
    }

    // =========================================================================
    // 2. 2026-10-30 1차 온라인 스프린트 미팅 Usage
    // =========================================================================
    action onlineMeeting1_20261030 : ChapterSprintMeeting {
        in :>> mode = ExchangeModeKind::onlineReviewStyle;

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
            ChapterMembersDirectory::'이중윤', ChapterMembersDirectory::'추수호',
            ChapterMembersDirectory::'김다운', ChapterMembersDirectory::'박홍석',
            ChapterMembersDirectory::'박승훈', ChapterMembersDirectory::'최성열',
            ChapterMembersDirectory::'구정모', ChapterMembersDirectory::'김희재',
            ChapterMembersDirectory::'최지원',
        );

        :>> keyDecisions = (
            "워킹그룹별 대상 시스템(SOI) 확정: 다목적 쿼드콥터 드론(1. Aerospace), 소프트웨어 중심 자동차 SDV(2. Automotive), EUV 제니스 반도체 장비(4. Semiconductor), 재난 탐색 및 구조 지원 로봇(3. IT)",
            "2035년 롱텀 목표 시점 설정 및 DoDAF 2.02 프레임워크, SysML v2, SE-Labs 도구를 표준으로 활용하며 워킹그룹 간 AV-1, AV-2, OV-1 목차 구조를 통일",
            "기업별 기밀 정보를 철저히 배제하고 오픈소스 및 공통 문서를 기반으로 인코즈 코리아 챕터(INCOSE Korea Chapter) 레퍼런스 아키텍처로 공개 및 활용",
            "다목적 드론 시스템은 감시정찰, 공격, 보급 3대 임무별로 PESTEL-CTIMMRA 운영 맥락, 위협/환경 조건, 공급망, 가정/제약, 이해관계자 관심사 및 OV-1 시나리오(전형적 조건 및 최악 조건)를 각각 분리 작성",
            "효과 척도(MOE)는 시스템 내부 성능이 아닌 상위 임무 성공 여부 및 고객/공장 효과성(와우 포인트, 웨이퍼 수율/품질 등)에 초점을 맞추고, 직접 측정 가능한 말단 지표를 포함한 계층 구조로 정의",
            "반도체 장비 등 컴포넌트 성격의 시스템은 내부 기능/인터록보다 상위 추상화 수준(Level 0 컨텍스트, 타 공정 연계, 수요처 공장별 베리에이션)부터 하향식으로 재정의",
        );

        out item :>> producedArtifact : ChapterArtifact {
            :>> title = "[Incose Korea Chapter] 1st Online Meeting (20261030) - 회의록";
            :>> category = ArtifactCategoryKind::meetingMinutes;
            :>> owner = "추수호";
            :>> repoFolderPath = "1. Meeting/";
            :>> locationURL =
                "https://drive.google.com/file/d/1fub4f8KklxVbGjWEzn0hmlWP-RMrTL4Q/view?usp=drive_link";
        }

        action ai1_unifyDocumentStructure : ActionItemTask {
            ref :>> owner = (
                ChapterMembersDirectory::'추수호', ChapterMembersDirectory::'김다운',
                ChapterMembersDirectory::'최성열', ChapterMembersDirectory::'박홍석',
                ChapterMembersDirectory::'구정모',
            );
            :>> taskDescription =
                "전 워킹그룹 간 DoDAF 기반 AV-1, AV-2, OV-1 문서 및 모델의 목차 구조를 동일하게 통일하고, 작업 중 유용한 AI 프롬프트 및 워크플로우를 프로젝트 내 '6. Projects/3. AI Skills' 폴더에 공유";
            :>> dueDate = "2026-11-13 (Sprint 2)";
        }

        action ai2_aerospaceDroneConOps : ActionItemTask {
            ref :>> owner = (
                ChapterMembersDirectory::'김다운', ChapterMembersDirectory::'박승훈',
                ChapterMembersDirectory::'박홍석', ChapterMembersDirectory::'이수',
            );
            :>> taskDescription =
                "감시정찰/공격/보급 3가지 임무별 독립된 OV-1(정상/최악 조건 시나리오 포함) 작성, PESTEL-CTIMMRA 맥락 분석표/위협/공급망/제약/이해관계자 임무별 분리, 작전 효과 중심의 MOE 계층 구조화 및 OV-5b 액티비티 모델링 진행";
            :>> dueDate = "2026-11-13 (Sprint 2)";
        }

        action ai3_automotiveSdvConOps : ActionItemTask {
            ref :>> owner = (ChapterMembersDirectory::'최성열', ChapterMembersDirectory::'추수호',);
            :>> taskDescription =
                "PESTEL 분석 자료를 타 팀과 공유하고, 10~20년 장기 운용 가치 등 사용자에게 감동을 주는 와우 포인트(Wow Point) 및 MOE 계층 구조를 반영하여 세부 운용 시나리오 보완 및 액티비티 모델(OV-5b) 개발";
            :>> dueDate = "2026-11-13 (Sprint 2)";
        }

        action ai4_semiconductorContextAndVariation : ActionItemTask {
            ref :>> owner = ChapterMembersDirectory::'김희재';
            :>> taskDescription =
                "EUV 제니스 장비 내부 기능 대신 상위 추상화 수준(Level 0)에서 리소그래피 공정 및 타 공정과의 외부 컨텍스트를 먼저 정의하고, 납품될 다양한 반도체 공장 환경에 대한 베리에이션(Variation) 및 공장 수율/품질 관점의 MOE 설정";
            :>> dueDate = "2026-11-13 (Sprint 2)";
        }

        action ai5_roboticsDisasterConOps : ActionItemTask {
            ref :>> owner = (
                ChapterMembersDirectory::'구정모', ChapterMembersDirectory::'최지원',
                ChapterMembersDirectory::'박홍석',
            );
            :>> taskDescription =
                "재난 탐색 및 구조 지원 로봇 시스템의 통일된 AV-1, OV-1 목차 구조 반영 및 기본(Nominal) 운용 시나리오와 최악 조건(통신 두절, 침수 등) 시나리오 구체화";
            :>> dueDate = "2026-11-13 (Sprint 2)";
        }

        action ai6_seLabsWorkspaceAndSeminar : ActionItemTask {
            ref :>> owner = ChapterMembersDirectory::'박홍석';
            :>> taskDescription =
                "SE-Labs AI 내 INCOSE Korea Chapter 팀 공간 공유/초대 및 팀원들을 위한 SE-Labs AI 모델링 도구 사용법 세미나 일정 조율 및 진행 ('4. Tools' 연계)";
            :>> dueDate = "Immediate";
        }

        action ai7_nextMeetingVote : ActionItemTask {
            ref :>> owner = ChapterMembersDirectory::'추수호';
            :>> taskDescription =
                "'7. Source' 폴더(PESTEL-CTIMMRA, AI 프롬프트, MBSE 쿡북 자료) 안내 및 격주 금요일 기준 차기(2차) 온라인 미팅 일정 확정 투표 진행";
            :>> dueDate = "2026-11-04";
        }
    }
} // package SprintMeetings_2026_Q4
