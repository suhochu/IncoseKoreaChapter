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
        /* [Feedback 1: 임무 달성 중심 ConOps]
         * 단순 기능 나열이 아닌, 대상시스템(SoI)이 이해관계자의 최상위 임무(Mission)를
         * 달성하는 종단간(End-to-End) 운용 시나리오(ConOps)로 구성되었는가?
         */
        in isMissionOrientedConOps : Boolean;
        in hasEndToEndScenarioFlow : Boolean;
        isMissionOrientedConOps and hasEndToEndScenarioFlow
    }

    constraint def Feedback2_QuantitativeMOEStructureRule {
        doc
        /* [Feedback 2: 정량적 MOE/MOP 체계]
         * 모호한 형용사(빠르게, 안전하게 등)가 배제되고, 이해관계자 효과성 척도(MOE)와
         * 블랙박스 시스템 성능 척도(MOP)가 정량적 수치 및 단위로 구조화되었는가?
         */
        in moeCount : Integer;
        in hasQuantitativeMOEAndMOP : Boolean;
        in isFreeOfVagueAdjectives : Boolean;
        moeCount >= 1 and hasQuantitativeMOEAndMOP and isFreeOfVagueAdjectives
    }

    constraint def Feedback3_BlackBoxAndTimeframeInfraRule {
        doc
        /* [Feedback 3: 블랙박스 순수성 및 운용 시점 인프라 정합성]
         * 내부 구현 기술(White-Box) 유출 없이 외부 인프라 및 운용 시점(Timeframe) 전제가
         * 컨텍스트 및 시나리오와 일관되게 연결되었는가?
         */
        in isBlackBoxContextConsistent : Boolean;
        in isTimeframeInfraLinked : Boolean;

        isBlackBoxContextConsistent and isTimeframeInfraLinked
    }

    // ---------------------------------------------------------------------
    // 3.2 과제 산출물 6대 자체 감사 게이트 (Verification Gates)
    // ---------------------------------------------------------------------
    constraint def Gate1_WholeSystemScopeRule {
        doc
        /* [Gate 1: Whole-System]
         * 대상시스템(SoI)이 하위 모듈/센서/단일 제어기가 아닌, 독립적으로 이해관계자에게
         * 임무를 완수할 수 있는 최상위 전체 시스템(Whole-System)으로 선정되었는가?
         */
        in attribute isIndependentWholeSystem : Boolean;
        isIndependentWholeSystem
    }

    constraint def Gate2_BlackBoxSolutionFreeRule {
        doc
        /* [Gate 2: Black-Box (Solution-Free 원칙)]
         * 내부 아키텍처(특정 MCU, ECU, SW 함수, 내부 통신 버스 규격, 알고리즘)가 철저히 배제되고
         * 경계면의 입출력(Port/Item)만 노출되었는가?
         */
        in attribute hasZeroInternalComponentsExposed : Boolean;
        hasZeroInternalComponentsExposed
    }

    constraint def Gate3_TimeframeAssumptionLinkRule {
        doc
        /* [Gate 3: 시점 전제 연계]
         * 단순 연도 텍스트 기재를 넘어, 운용 시점(예: 2030~2040년)의 4대 전제 조건
         * (①외부 인프라 성숙도, ②법규/제도, ③위협/외란 수준, ④수명주기 진화 특성)이 반영되었는가?
         */
        in attribute hasFourCategoryTimeframeAssumptions : Boolean;
        hasFourCategoryTimeframeAssumptions
    }

    constraint def Gate4_ODDSpatialGroupingRule {
        doc
        /* [Gate 4: 장소 그룹핑]
         * 무분별한 개별 지명 나열 대신, 물리적·기능적 부하(Stress)의 동질성을 기준으로
         * 그룹 A(공칭/정규), 그룹 B(복합/고부하), 그룹 C(극한/기능저하)로 추상화되었는가?
         */
        in attribute hasThreeTierODDGrouping : Boolean;
        hasThreeTierODDGrouping
    }

    constraint def Gate5_ThreeExternalScopesCompletenessRule {
        doc
        /* [Gate 5: 3대 범위 완전성 및 외란 아이템화]
         * 외부 조직(Org), 외부 물리 시스템(Physical), 외부 자연 환경(Nature)이 각각 2개 이상 식별되었으며,
         * 자연 환경 외란이 문학적 묘사가 아닌 EnvironmentalDisturbanceItem으로 정형화되었는가?
         */
        in attribute externalOrgCount : Integer;
        in attribute externalPhysicalCount : Integer;
        in attribute externalNatureCount : Integer;
        in attribute isNaturalDisturbanceItemized : Boolean;

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
        in attribute hasZeroIsolatedExternalActors : Boolean;
        in attribute includesNominalDisturbanceAndMRCFlows : Boolean;
        hasZeroIsolatedExternalActors and includesNominalDisturbanceAndMRCFlows
    }

    // ---------------------------------------------------------------------
    // 3.3 LV1 참조모델 과제 통합 승인 게이트 (교수님 피드백 3종 + 가이드 Gate 6종 통합)
    // ---------------------------------------------------------------------
    constraint def ReferenceModelAssignmentApprovalGate {
        doc
        /* 워킹그룹이 제출한 LV1 모델이 KnowledgeRepository에 정식 Baseline으로 승격되기 위한 통합 품질 게이트 */

        // Feedback 1~3용 입력 (필요 시 Feedback 규칙의 세부 파라미터로 세분화 가능)
        in isMissionConOps : Boolean;
        in hasE2EFlow : Boolean;
        in definedMoeCount : Integer;
        in hasQuantMetrics : Boolean;
        in noVagueWords : Boolean;
        in isBBContextConsistent : Boolean;
        in isTimeframeLinked : Boolean;

        // Gate 1~4용 입력
        in isWholeSystem : Boolean;
        in isBlackBoxPure : Boolean;
        in hasFourTimeframeAssumptions : Boolean;
        in hasThreeTierODD : Boolean;

        // Gate 5용 세부 입력 (Integer 및 Boolean)
        in orgActorCount : Integer;
        in physActorCount : Integer;
        in natureActorCount : Integer;
        in isDisturbanceItemized : Boolean;

        // Gate 6용 세부 입력
        in noIsolatedActors : Boolean;
        in hasAllThreeScenarioFlows : Boolean;

        // 하위 Constraint 선언 및 파라미터 바인딩
        constraint fb1 : Feedback1_MissionAchievementConOpsRule {
            in isMissionOrientedConOps = isMissionConOps;
            in hasEndToEndScenarioFlow = hasE2EFlow;
        }
        constraint fb2 : Feedback2_QuantitativeMOEStructureRule {
            in moeCount = definedMoeCount;
            in hasQuantitativeMOEAndMOP = hasQuantMetrics;
            in isFreeOfVagueAdjectives = noVagueWords;
        }
        constraint fb3 : Feedback3_BlackBoxAndTimeframeInfraRule {
            in isBlackBoxContextConsistent = isBBContextConsistent;
            in isTimeframeInfraLinked = isTimeframeLinked;
        }

        constraint gate1 : Gate1_WholeSystemScopeRule {
            in isIndependentWholeSystem = isWholeSystem;
        }
        constraint gate2 : Gate2_BlackBoxSolutionFreeRule {
            in hasZeroInternalComponentsExposed = isBlackBoxPure;
        }
        constraint gate3 : Gate3_TimeframeAssumptionLinkRule {
            in hasFourCategoryTimeframeAssumptions = hasFourTimeframeAssumptions;
        }
        constraint gate4 : Gate4_ODDSpatialGroupingRule {
            in hasThreeTierODDGrouping = hasThreeTierODD;
        }
        constraint gate5 : Gate5_ThreeExternalScopesCompletenessRule {
            in externalOrgCount = orgActorCount;
            in externalPhysicalCount = physActorCount;
            in externalNatureCount = natureActorCount;
            in isNaturalDisturbanceItemized = isDisturbanceItemized;
        }
        constraint gate6 : Gate6_NoIsolatedActorTraceabilityRule {
            in hasZeroIsolatedExternalActors = noIsolatedActors;
            in includesNominalDisturbanceAndMRCFlows = hasAllThreeScenarioFlows;
        }

        // 통합 판정식: 하위 constraint usage 자체를 AND 연산으로 평가
        fb1 and fb2 and fb3 and gate1 and gate2 and gate3 and gate4 and gate5 and gate6
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

        // TODO: 조직 성장 조건 판정 로직 구현 필요
    }
} // package QualityGatesAndReviewProcess
