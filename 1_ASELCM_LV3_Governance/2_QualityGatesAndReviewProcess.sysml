package QualityGatesAndReviewProcess {
    private import ScalarValues::*;
    // =========================================================================
    // 3. Quality Assurance & Maturity Gates (품질 보증, 교수님 피드백 & 6대 게이트)
    // =========================================================================

    doc
    /* System 2(챕터 운영)의 성장 단계 통제(Maturity Gate)와
     * System 1(LV1 도메인 참조모델 과제)의 무결성 검증(교수님 피드백 3대 원칙 + 실무 가이드 6대 Gate)을
     * 수행하는 품질 보증 패키지.
     */

    // ---------------------------------------------------------------------
    // 3.1 [교수님 피드백 1·2·3 반영] 학술 자문단 3대 핵심 모델링 검증 규칙
    // ---------------------------------------------------------------------
    constraint def Feedback1_MissionAchievementConOpsRule {
        doc
        /* [교수님 피드백 1]
         * 운용 개념(ConOps)은 단순 기능 나열이 아니라 대상시스템(SoI)의 존재 목적(임무 또는 사업목표)을
         * 달성하는 모습을 표현해야 하며, 시나리오 수행 결과가 임무 요구사항을 satisfy해야 함.
         */
        attribute expressesMissionAndBusinessGoal : Boolean;
        attribute hasExplicitSatisfyLinkToMission : Boolean;
        expressesMissionAndBusinessGoal and hasExplicitSatisfyLinkToMission
    }

    constraint def Feedback2_QuantitativeMOEStructureRule {
        doc
        /* [교수님 피드백 2]
         * 임무/사업 목표에 대한 서술(What/Why)과 함께, 달성 여부를 판정하는
         * 운용효과성측정지표(MOE)를 정의하고 반드시 목표값(Target), 한계값(Threshold), 단위(Unit)를
         * 지정해야 함 (수치 자체의 정확성보다 정량적 구조 완결성이 필수).
         */
        attribute hasMissionAndBusinessNarrative : Boolean;
        attribute hasMOETargetValue : Boolean;
        attribute hasMOEThresholdValue : Boolean;
        attribute hasMOEUnit : Boolean;
        hasMissionAndBusinessNarrative and hasMOETargetValue and hasMOEThresholdValue and hasMOEUnit
    }

    constraint def Feedback3_BlackBoxAndTimeframeInfraRule {
        doc
        /* [교수님 피드백 3]
         * 운용 시나리오 작성 시 블랙박스 개념을 철저히 유지하여 블랙박스 대상시스템이 외부 환경과
         * 상호작용하는 것에 초점을 두어야 하며, 이때 외부 환경에 대한 가정은 반드시
         * '운용 시점의 인프라에 대한 가정(Timeframe Infrastructure Assumption)'에 기반해야 함.
         */
        attribute focusesOnExternalBoundaryInteraction : Boolean;
        attribute isExternalEnvGroundedInTimeframeInfra : Boolean;
        focusesOnExternalBoundaryInteraction and isExternalEnvGroundedInTimeframeInfra
    }

    // ---------------------------------------------------------------------
    // 3.2 [실무 가이드 7장 반영] 과제 산출물 6대 자체 감사 게이트 (Verification Gates)
    // ---------------------------------------------------------------------
    constraint def Gate1_WholeSystemScopeRule {
        doc
        /* [Gate 1: Whole-System]
         * 대상시스템(SoI)이 하위 모듈/센서/단일 제어기가 아닌, 독립적으로 이해관계자에게
         * 임무를 완수할 수 있는 최상위 전체 시스템(Whole-System)으로 선정되었는가?
         */
        attribute isIndependentWholeSystem : Boolean;
        isIndependentWholeSystem
    }

    constraint def Gate2_BlackBoxSolutionFreeRule {
        doc
        /* [Gate 2: Black-Box (Solution-Free 원칙)]
         * 내부 아키텍처(특정 MCU, ECU, SW 함수, 내부 통신 버스 규격, 알고리즘)가 철저히 배제되고
         * 경계면의 입출력(Port/Item)만 노출되었는가?
         */
        attribute hasZeroInternalComponentsExposed : Boolean;
        hasZeroInternalComponentsExposed
    }

    constraint def Gate3_TimeframeAssumptionLinkRule {
        doc
        /* [Gate 3: 시점 전제 연계]
         * 단순 연도 텍스트 기재를 넘어, 운용 시점(예: 2030~2040년)의 4대 전제 조건
         * (①외부 인프라 성숙도, ②법규/제도, ③위협/외란 수준, ④수명주기 진화 특성)이 반영되었는가?
         */
        attribute hasFourCategoryTimeframeAssumptions : Boolean;
        hasFourCategoryTimeframeAssumptions
    }

    constraint def Gate4_ODDSpatialGroupingRule {
        doc
        /* [Gate 4: 장소 그룹핑]
         * 무분별한 개별 지명 나열 대신, 물리적·기능적 부하(Stress)의 동질성을 기준으로
         * 그룹 A(공칭/정규), 그룹 B(복합/고부하), 그룹 C(극한/기능저하)로 추상화되었는가?
         */
        attribute hasThreeTierODDGrouping : Boolean;
        hasThreeTierODDGrouping
    }

    constraint def Gate5_ThreeExternalScopesCompletenessRule {
        doc
        /* [Gate 5: 3대 범위 완전성 및 외란 아이템화]
         * 외부 조직(Org), 외부 물리 시스템(Physical), 외부 자연 환경(Nature)이 각각 2개 이상 식별되었으며,
         * 자연 환경 외란이 문학적 묘사가 아닌 EnvironmentalDisturbanceItem으로 정형화되었는가?
         */
        attribute externalOrgCount : Integer;
        attribute externalPhysicalCount : Integer;
        attribute externalNatureCount : Integer;
        attribute isNaturalDisturbanceItemized : Boolean;

        externalOrgCount >= 2 and
        externalPhysicalCount >= 2 and
        externalNatureCount >= 2 and
        isNaturalDisturbanceItemized
    }

    constraint def Gate6_NoIsolatedActorTraceabilityRule {
        doc
        /* [Gate 6: 고립 액터 방지 (Traceability 강제)]
         * 컨텍스트에 정의된 모든 외부 액터(조직/물리/자연)와 시점·장소 그룹이
         * 최종 5-Tuple 운용 시나리오(공칭 + 외란 적응 + 비상 폴백/MRC)에 최소 1회 이상 등장하는가?
         */
        attribute hasZeroIsolatedExternalActors : Boolean;
        attribute includesNominalDisturbanceAndMRCFlows : Boolean;
        hasZeroIsolatedExternalActors and includesNominalDisturbanceAndMRCFlows
    }

    // ---------------------------------------------------------------------
    // 3.3 LV1 참조모델 과제 통합 승인 게이트 (교수님 피드백 3종 + 가이드 Gate 6종 통합)
    // ---------------------------------------------------------------------
    constraint def ReferenceModelAssignmentApprovalGate {
        doc
        /* 워킹그룹이 제출한 LV1 모델이 KnowledgeRepository에 정식 Baseline으로 승격되기 위한 통합 품질 게이트 */
        constraint fb1 : Feedback1_MissionAchievementConOpsRule;
        constraint fb2 : Feedback2_QuantitativeMOEStructureRule;
        constraint fb3 : Feedback3_BlackBoxAndTimeframeInfraRule;

        constraint gate1 : Gate1_WholeSystemScopeRule;
        constraint gate2 : Gate2_BlackBoxSolutionFreeRule;
        constraint gate3 : Gate3_TimeframeAssumptionLinkRule;
        constraint gate4 : Gate4_ODDSpatialGroupingRule;
        constraint gate5 : Gate5_ThreeExternalScopesCompletenessRule;
        constraint gate6 : Gate6_NoIsolatedActorTraceabilityRule;
    }

    // ---------------------------------------------------------------------
    // 3.4 모델 검수 및 승인 프로세스 (학술 자문단 리뷰 및 6대 Gate 검증 반영)
    // ---------------------------------------------------------------------
    action def ModelReviewProcess {
        doc
        /* 정기적인 챕터 모델 및 LV1 과제 산출물 검수·승인 워크플로우 */
        action submitModelUpdate {
            doc
            /* 워킹그룹 또는 회원이 스캐폴드 기반 모델 제출 */
        }
        action checkAutomatedConventionsAndGates {
            doc
            /* 6대 자체 감사 게이트(Gate 1~6) 및 스캐폴드 상속·포트 대칭성 1차 점검 */
        }
        action reviewByAcademicAdvisors {
            doc
            /* 교수진 자문단(이중윤·서은석 교수)의 피드백 1·2·3 충족 여부 심사 */
        }
        action reviewByChapterLeadership {
            doc
            /* 챕터 대표 및 총무의 보안 규정(사내 데이터 배제) 확인 및 최종 승인 */
        }
        action mergeAndDeploy {
            doc
            /* GitHub 메인 브랜치 및 Google Workspace 단일 진실 공급원(SSOT) 배포 */
        }

        first submitModelUpdate;
        then checkAutomatedConventionsAndGates;
        then reviewByAcademicAdvisors;
        then reviewByChapterLeadership;
        then mergeAndDeploy;
    }

    // ---------------------------------------------------------------------
    // 3.5 System 2 (챕터 조직) 성장 단계 전환 조건 (Maturity Gate)
    // ---------------------------------------------------------------------
    constraint def PhaseTransitionGateCondition {
        doc
        /* 조직 성장 조건 (Maturity Gate):
         * LV1 참조모델 승인 누적 건수 및 세미나 발표 건수 등 정량적 지표를 기반으로
         * System 2(KoreaChapter)의 Lifecycle Phase 전환 가능 여부를 판정함.
         */
        in presentations : Integer;
        in refModels : Integer;
        in aiSkills : Integer;
        in activeMembers : Integer;
        in sepMembers : Integer;
    }
} // package QualityGatesAndReviewProcess
