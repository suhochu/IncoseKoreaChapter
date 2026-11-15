package ChapterMetricsAndGuards {
    doc
    /* [MagicGrid: Measures of Effectiveness (MoEs) & System Parameters]
     * 기업 스폰서 등 외부 환경 변수를 배제하고, 챕터 내부의 산출물과 인적 역량만으로
     * 성장을 측정 및 통제하는 핵심 성과 지표(Core MoEs)와 Phase 전환 판정 결과.
     *
     * 판정식과 임계값은 LV3(QualityGatesAndReviewProcess)가 한 곳에서 정의한다.
     * 이 패키지는 지표 값을 그 constraint의 입력에 연결하고 판정 결과를 파생할 뿐, 숫자를 다시 적지 않는다.
     */

    private import ScalarValues::*;
    private import QualityGatesAndReviewProcess::*;

    part def ChapterMoEsHolder {
        doc
        /* KoreaChapter(SoI)가 상속받는 핵심 정량 지표(MoEs).
         * 각 지표의 목표 임계값은 QualityGatesAndReviewProcess::phase1To2Thresholds / phase2To3Thresholds 를 참조한다.
         */

        attribute accumulatedPresentationsCount : Integer; // MoE: 누적 발표/사례 자료 수 (수동 입력)
        attribute completedReferenceModelsCount : Integer; // MoE: 완성된 도메인 참조모델 수 (KoreaChapter에서 repository 크기로 파생)
        attribute developedAISkillsCount : Integer; // MoE: 단계별 AI Skills 수 (KoreaChapter에서 repository 크기로 파생)
        attribute regularActiveMembersCount : Integer; // MoE: 고정 활동 인원 수 (수동 입력)
        attribute sepCertifiedMembersCount : Integer; // MoE: SEP 자격 보유자 수 (수동 입력)

        // Phase 1 -> Phase 2 전환 판정: 지표 값을 LV3 constraint의 입력에 연결
        constraint phase1To2GateCheck : Phase1ToPhase2GateConstraint {
            in :>> presentations = accumulatedPresentationsCount;
            in :>> refModels = completedReferenceModelsCount;
            in :>> aiSkills = developedAISkillsCount;
            in :>> activeMembers = regularActiveMembersCount;
            in :>> sepMembers = sepCertifiedMembersCount;
        }

        // Phase 2 -> Phase 3 전환 판정
        constraint phase2To3GateCheck : Phase2ToPhase3GateConstraint {
            in :>> presentations = accumulatedPresentationsCount;
            in :>> refModels = completedReferenceModelsCount;
            in :>> aiSkills = developedAISkillsCount;
            in :>> activeMembers = regularActiveMembersCount;
            in :>> sepMembers = sepCertifiedMembersCount;
        }

        // Phase 전환 Guard용 파생 Boolean (상태머신 transition의 accept when 조건에서 참조).
        // 판정식은 constraint 한 곳에만 있고, 여기서는 그 결과(result)만 가져온다.
        // TODO(확인 필요): constraint usage 자체는 Boolean에 type-conform 하지 않아(Syside type-error) '.result'로 참조했다.
        //   Syside 정적 평가기는 constraint usage를 평가하지 못하고('no result expression') '.result'도 값이 아닌
        //   result feature 참조로 돌려준다. 실행(시뮬레이션) 수준에서의 평가 확인이 필요하다.
        //   대안: 파생 Boolean만 남기고 constraint는 'assert constraint'로 사용(판정식 1곳 유지).
        attribute isPhase1To2Ready : Boolean = phase1To2GateCheck.result;
        attribute isPhase2To3Ready : Boolean = phase2To3GateCheck.result;
    }
} // package ChapterMetricsAndGuards
