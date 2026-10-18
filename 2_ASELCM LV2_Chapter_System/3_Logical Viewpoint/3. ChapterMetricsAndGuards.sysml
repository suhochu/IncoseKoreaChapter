package ChapterMetricsAndGuards {
    doc
    /* [MagicGrid: Measures of Effectiveness (MoEs) & System Parameters]
     * 기업 스폰서 등 외부 환경 변수를 배제하고, 챕터 내부의 산출물과 인적 역량만으로
     * 성장을 측정 및 통제하는 5대 핵심 성과 지표(Core MoEs)와 Gate 제약 수식 정의.
     */

    private import ScalarValues::*;
    private import INCOSE_Korea_Chapter_Governance::QualityAssurance::*;

    // =========================================================================
    // 1. 5대 핵심 성과 지표 홀더 (Core 5 MoEs Holder)
    // =========================================================================
    part def ChapterMoEsHolder {
        doc
        /* KoreaChapter(SoI)가 상속받는 5대 핵심 정량 지표(MoEs) */

        attribute accumulatedPresentationsCount : Integer default 1; // MoE 1: 누적 발표/사례 자료 수 (목표 >= 10)
        attribute completedReferenceModelsCount : Integer default 0; // MoE 2: 완성된 도메인 참조모델 수 (목표 >= 3)
        attribute developedAISkillsCount : Integer default 0; // MoE 3: 단계별 AI Skills 수 (Phase2 >= 3, Phase3 >= 5)
        attribute regularActiveMembersCount : Integer default 12; // MoE 4: 고정 활동 인원 수 (Phase2 > 15, Phase3 >= 30)
        attribute sepCertifiedMembersCount : Integer default 1; // MoE 5: SEP 자격 보유자 수 (Phase2 >= 3, Phase3 >= 10)
    }

    // =========================================================================
    // 2. Phase 1 -> Phase 2 전환 게이트 제약 (온라인 스터디 -> 오프라인 세미나 정례화)
    // =========================================================================
    constraint def Phase1ToPhase2GateConstraint :> PhaseTransitionGateCondition {
        doc
        /* [Phase 1 -> Phase 2 전환 조건 (기업 스폰서 조건 제외)]
         * 1) 누적 발표/사례 자료 10건 이상 OR 고정 활동 인원 15명 초과
         * 2) 도메인별 참조모델 3건 이상 완성
         * 3) 단계별 AI Architecting Skills 3개 이상 구축
         * 4) INCOSE SEP 자격 보유 인원 3명 이상 확보
         */
        in presentations : Integer;
        in refModels : Integer;
        in aiSkills : Integer;
        in activeMembers : Integer;
        in sepMembers : Integer;

        (presentations >= 10 or activeMembers > 15) and
        refModels >= 3 and
        aiSkills >= 3 and
        sepMembers >= 3
    }

    // =========================================================================
    // 3. Phase 2 -> Phase 3 전환 게이트 제약 (세미나 정례화 -> 공식 WG 및 학회 Joint WG)
    // =========================================================================
    constraint def Phase2ToPhase3GateConstraint :> PhaseTransitionGateCondition {
        doc
        /* [Phase 2 -> Phase 3 전환 조건 (기업 스폰서 조건 제외)]
         * 1) 고정 활동 인원 30명 이상 확대 (국내 학회 산하 Joint WG 연계 기준)
         * 2) INCOSE SEP(CSEP 등) 자격 보유자 10명 이상 확보 (자체 아키텍트 인증 프로그램 개발 기준)
         * 3) MagicGrid 전 단계(5단계) AI Architecting Skills 5개 이상 완비
         * 4) 도메인별 참조모델 3건 이상 유지 및 고도화
         */

        (presentations >= 10 or activeMembers > 15) and
        refModels >= 3 and
        aiSkills >= 3 and
        sepMembers >= 3
    }
} // package ChapterMetricsAndGuards
