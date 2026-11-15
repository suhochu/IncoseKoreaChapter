package QualityGatesAndReviewProcess {
    private import ScalarValues::*;

    // =========================================================================
    // 3. Quality Assurance & Maturity Gates (품질 보증, 학술자문단 피드백 & 가이드 Gate)
    // =========================================================================

    doc
    /* System 2(챕터 운영)의 성장 단계 통제(Maturity Gate)와
     * System 1(LV1 도메인 참조모델 과제)의 무결성 검증(학술자문단 피드백 원칙 + 실무 가이드 Gate)을
     * 수행하는 품질 보증 패키지.
     *
     * 이 패키지는 LV2/LV1을 import하지 않는다. LV2는 이 패키지의 정의(def)와 임계값을 import해서 쓴다.
     */

    // ---------------------------------------------------------------------
    // 3.0 공통 타입
    // ---------------------------------------------------------------------
    enum def SEAssignmentStageKind {
        stage1_SoIAndQuestionSelection; // 과제 1: 대상시스템(SoI) 및 Engineering Question 선정
        stage2_BlackBoxAndConOps; // 과제 2: 블랙박스 정의, 임무/MOE 설정 및 5-Tuple ConOps 시나리오
        stage3_LogicalArchitecture; // 과제 3: 화이트박스 논리 아키텍처 및 기능 분해/할당
        stage4_PhysicalAndSimulation; // 과제 4: 물리 아키텍처, 요구사항 추적성 및 시뮬레이션 검증(V&V)
    }

    abstract constraint def AssignmentCheckpointRule {
        doc
        /* 과제 통과 필수 요건(ModelingAssignment.mandatoryCheckpoints)으로 참조되는 모든 Feedback/Gate 규칙의 공통 상위 정의.
         * 새 규칙을 추가할 때는 이 정의를 상속(:>)하면 과제에서 같은 방식으로 참조할 수 있다.
         */
    }

    // ---------------------------------------------------------------------
    // 3.1 학술자문단 핵심 모델링 검증 규칙 (Feedback)
    // ---------------------------------------------------------------------
    constraint def Feedback1_MissionAchievementConOpsRule :> AssignmentCheckpointRule {
        doc
        /* [Feedback 1: 임무 달성 중심 ConOps]
         * 단순 기능 나열이 아닌, 대상시스템(SoI)이 이해관계자의 최상위 임무(Mission)를
         * 달성하는 종단간(End-to-End) 운용 시나리오(ConOps)로 구성되었는가?
         * 운용 개념은 대상시스템의 존재목적(임무 또는 사업목표) 달성을 표현하고 satisfy 관계로 연결해야 한다.
         */
        in isMissionOrientedConOps : Boolean;
        in hasEndToEndScenarioFlow : Boolean;
        isMissionOrientedConOps and hasEndToEndScenarioFlow
    }

    constraint def Feedback2_QuantitativeMOEStructureRule :> AssignmentCheckpointRule {
        doc
        /* [Feedback 2: 정량적 MOE/MOP 체계]
         * 모호한 형용사(빠르게, 안전하게 등)가 배제되고, 이해관계자 효과성 척도(MOE)와
         * 블랙박스 시스템 성능 척도(MOP)가 정량적 수치 및 단위로 구조화되었는가?
         * MOE는 고객/임무/공장 효과 중심의 계층 구조로 정의하고 목표값(Target)/한계값(Threshold)/단위(Unit)를 지정해야 한다.
         */
        attribute minMoeCount : Integer = 1;
        in moeCount : Integer;
        in hasQuantitativeMOEAndMOP : Boolean;
        in isFreeOfVagueAdjectives : Boolean;
        moeCount >= minMoeCount and hasQuantitativeMOEAndMOP and isFreeOfVagueAdjectives
    }

    constraint def Feedback3_BlackBoxAndTimeframeInfraRule :> AssignmentCheckpointRule {
        doc
        /* [Feedback 3: 블랙박스 순수성 및 운용 시점 인프라 정합성]
         * 내부 구현 기술(White-Box) 유출 없이 외부 인프라 및 운용 시점(Timeframe) 전제가
         * 컨텍스트 및 시나리오와 일관되게 연결되었는가?
         * 운용 시점의 PESTEL-CTIMMRA 인프라 가정을 명시하고, 블랙박스 SoI가 외부 환경(조직/물리/자연)과
         * 상호작용하는 것에 초점을 두고 시나리오를 작성해야 한다.
         */
        in isBlackBoxContextConsistent : Boolean;
        in isTimeframeInfraLinked : Boolean;
        isBlackBoxContextConsistent and isTimeframeInfraLinked
    }

    // ---------------------------------------------------------------------
    // 3.2 과제 산출물 자체 감사 게이트 (Verification Gates)
    // ---------------------------------------------------------------------
    constraint def Gate1_WholeSystemScopeRule :> AssignmentCheckpointRule {
        doc
        /* [Gate 1: Whole-System]
         * 대상시스템(SoI)이 하위 모듈/센서/단일 제어기가 아닌, 독립적으로 이해관계자에게
         * 임무를 완수할 수 있는 최상위 전체 시스템(Whole-System)으로 선정되었는가?
         */
        in isIndependentWholeSystem : Boolean;
        isIndependentWholeSystem
    }

    constraint def Gate2_BlackBoxSolutionFreeRule :> AssignmentCheckpointRule {
        doc
        /* [Gate 2: Black-Box (Solution-Free 원칙)]
         * 내부 아키텍처(특정 MCU, ECU, SW 함수, 내부 통신 버스 규격, 알고리즘)가 철저히 배제되고
         * 경계면의 입출력(Port/Item)만 노출되었는가?
         */
        in hasZeroInternalComponentsExposed : Boolean;
        hasZeroInternalComponentsExposed
    }

    constraint def Gate3_TimeframeAssumptionLinkRule :> AssignmentCheckpointRule {
        doc
        /* [Gate 3: 시점 전제 연계]
         * 단순 연도 텍스트 기재를 넘어, 운용 시점(예: 2030~2040년)의 전제 조건
         * (①외부 인프라 성숙도, ②법규/제도, ③위협/외란 수준, ④수명주기 진화 특성)이 반영되었는가?
         */
        in hasFourCategoryTimeframeAssumptions : Boolean;
        hasFourCategoryTimeframeAssumptions
    }

    constraint def Gate4_ODDSpatialGroupingRule :> AssignmentCheckpointRule {
        doc
        /* [Gate 4: 장소 그룹핑]
         * 무분별한 개별 지명 나열 대신, 물리적·기능적 부하(Stress)의 동질성을 기준으로
         * 그룹 A(공칭/정규), 그룹 B(복합/고부하), 그룹 C(극한/기능저하)로 추상화되었는가?
         */
        in hasThreeTierODDGrouping : Boolean;
        hasThreeTierODDGrouping
    }

    constraint def Gate5_ThreeExternalScopesCompletenessRule :> AssignmentCheckpointRule {
        doc
        /* [Gate 5: 외부 범위 완전성 및 외란 아이템화]
         * 외부 조직(Org), 외부 물리 시스템(Physical), 외부 자연 환경(Nature)이 각각 최소 개수 이상 식별되었으며,
         * 자연 환경 외란이 문학적 묘사가 아닌 EnvironmentalDisturbanceItem으로 정형화되었는가?
         * 최소 개수는 minActorCountPerScope 한 곳에서만 정의한다.
         */
        attribute minActorCountPerScope : Integer = 2;
        in externalOrgCount : Integer;
        in externalPhysicalCount : Integer;
        in externalNatureCount : Integer;
        in isNaturalDisturbanceItemized : Boolean;

        externalOrgCount >= minActorCountPerScope and
        externalPhysicalCount >= minActorCountPerScope and
        externalNatureCount >= minActorCountPerScope and
        isNaturalDisturbanceItemized
    }

    constraint def Gate6_NoIsolatedActorTraceabilityRule :> AssignmentCheckpointRule {
        doc
        /* [Gate 6: 고립 액터 방지 (Traceability 강제)]
         * 컨텍스트에 정의된 모든 외부 액터(조직/물리/자연)와 시점·장소 그룹이
         * 최종 5-Tuple 운용 시나리오(공칭 + 외란 적응 + 비상 폴백/MRC)에 최소 1회 이상 등장하는가?
         */
        in hasZeroIsolatedExternalActors : Boolean;
        in includesNominalDisturbanceAndMRCFlows : Boolean;
        hasZeroIsolatedExternalActors and includesNominalDisturbanceAndMRCFlows
    }

    // ---------------------------------------------------------------------
    // 3.3 LV1 참조모델 과제 통합 승인 게이트 (Feedback + Gate 통합)
    // ---------------------------------------------------------------------
    attribute def AssignmentGateChecklist {
        doc
        /* 통합 승인 게이트(ReferenceModelAssignmentApprovalGate)의 입력 전체를 속성별로 분리해 담는 체크리스트.
         * 속성 이름은 각 Feedback/Gate constraint def의 파라미터 이름과 같다.
         * 각 항목은 개별 속성이므로 하나의 판정값을 여러 파라미터에 중복 입력하는 정보 손실이 없다.
         */
        // Feedback 1
        attribute isMissionOrientedConOps : Boolean default false;
        attribute hasEndToEndScenarioFlow : Boolean default false;
        // Feedback 2
        attribute moeCount : Integer default 0;
        attribute hasQuantitativeMOEAndMOP : Boolean default false;
        attribute isFreeOfVagueAdjectives : Boolean default false;
        // Feedback 3
        attribute isBlackBoxContextConsistent : Boolean default false;
        attribute isTimeframeInfraLinked : Boolean default false;
        // Gate 1 ~ 4
        attribute isIndependentWholeSystem : Boolean default false;
        attribute hasZeroInternalComponentsExposed : Boolean default false;
        attribute hasFourCategoryTimeframeAssumptions : Boolean default false;
        attribute hasThreeTierODDGrouping : Boolean default false;
        // Gate 5
        attribute externalOrgCount : Integer default 0;
        attribute externalPhysicalCount : Integer default 0;
        attribute externalNatureCount : Integer default 0;
        attribute isNaturalDisturbanceItemized : Boolean default false;
        // Gate 6
        attribute hasZeroIsolatedExternalActors : Boolean default false;
        attribute includesNominalDisturbanceAndMRCFlows : Boolean default false;
    }

    constraint def ReferenceModelAssignmentApprovalGate :> AssignmentCheckpointRule {
        doc
        /* 워킹그룹이 제출한 LV1 모델이 KnowledgeRepository에 정식 Baseline으로 승격되기 위한 통합 품질 게이트.
         * 입력은 checklist 하나이며, 판정 기준 설명은 각 Feedback/Gate constraint def의 doc에만 둔다.
         */
        in checklist : AssignmentGateChecklist;

        constraint fb1 : Feedback1_MissionAchievementConOpsRule {
            in :>> isMissionOrientedConOps = checklist.isMissionOrientedConOps;
            in :>> hasEndToEndScenarioFlow = checklist.hasEndToEndScenarioFlow;
        }
        constraint fb2 : Feedback2_QuantitativeMOEStructureRule {
            in :>> moeCount = checklist.moeCount;
            in :>> hasQuantitativeMOEAndMOP = checklist.hasQuantitativeMOEAndMOP;
            in :>> isFreeOfVagueAdjectives = checklist.isFreeOfVagueAdjectives;
        }
        constraint fb3 : Feedback3_BlackBoxAndTimeframeInfraRule {
            in :>> isBlackBoxContextConsistent = checklist.isBlackBoxContextConsistent;
            in :>> isTimeframeInfraLinked = checklist.isTimeframeInfraLinked;
        }

        constraint gate1 : Gate1_WholeSystemScopeRule {
            in :>> isIndependentWholeSystem = checklist.isIndependentWholeSystem;
        }
        constraint gate2 : Gate2_BlackBoxSolutionFreeRule {
            in :>> hasZeroInternalComponentsExposed = checklist.hasZeroInternalComponentsExposed;
        }
        constraint gate3 : Gate3_TimeframeAssumptionLinkRule {
            in :>> hasFourCategoryTimeframeAssumptions = checklist.hasFourCategoryTimeframeAssumptions;
        }
        constraint gate4 : Gate4_ODDSpatialGroupingRule {
            in :>> hasThreeTierODDGrouping = checklist.hasThreeTierODDGrouping;
        }
        constraint gate5 : Gate5_ThreeExternalScopesCompletenessRule {
            in :>> externalOrgCount = checklist.externalOrgCount;
            in :>> externalPhysicalCount = checklist.externalPhysicalCount;
            in :>> externalNatureCount = checklist.externalNatureCount;
            in :>> isNaturalDisturbanceItemized = checklist.isNaturalDisturbanceItemized;
        }
        constraint gate6 : Gate6_NoIsolatedActorTraceabilityRule {
            in :>> hasZeroIsolatedExternalActors = checklist.hasZeroIsolatedExternalActors;
            in :>> includesNominalDisturbanceAndMRCFlows =
                checklist.includesNominalDisturbanceAndMRCFlows;
        }

        // 통합 판정식: 하위 constraint usage 자체를 AND 연산으로 평가
        fb1 and fb2 and fb3 and gate1 and gate2 and gate3 and gate4 and gate5 and gate6
    }

    // ---------------------------------------------------------------------
    // 3.4 모델 검수 및 승인 프로세스 (WG Lead → 학술자문단 → 챕터 리더십)
    // ---------------------------------------------------------------------
    action def ModelReviewProcess {
        doc
        /* 정기적인 챕터 모델 및 LV1 과제 산출물 검수·승인 워크플로우.
         * 검토 순서는 ModelingConventions::VersionControlPolicy(WG Lead → 학술자문단 → 보안/형상 승인)와 같다.
         * 게이트 미통과 또는 자문단 미승인이면 reviseModel(SubmissionStatusKind::revisionRequired에 해당)을 거쳐 재제출한다.
         */
        in attribute submittedChecklist : AssignmentGateChecklist;
        in attribute isAdvisorApproved : Boolean default false;

        constraint gateEvaluation : ReferenceModelAssignmentApprovalGate {
            in :>> checklist = submittedChecklist;
        }

        action submitModelUpdate {
            doc
            /* 워킹그룹 또는 회원이 스캐폴드 기반 모델 제출 */
        }
        action checkAutomatedConventionsAndGates {
            doc
            /* 가이드 Gate 및 스캐폴드 상속·포트 대칭성 1차 점검 */
        }
        action reviewByWGLead {
            doc
            /* 워킹그룹 리드(WG Lead)의 1차 모델 검토 */
        }
        action reviewByAcademicAdvisors {
            doc
            /* 학술자문단의 피드백 1·2·3 충족 여부 심사 */
        }
        action reviewByChapterLeadership {
            doc
            /* 챕터 대표 및 총무의 보안 규정(사내 데이터 배제) 확인 및 최종 승인 */
        }
        action mergeAndDeploy {
            doc
            /* GitHub 메인 브랜치 및 Google Workspace 단일 진실 공급원(SSOT) 배포 */
        }
        action reviseModel {
            doc
            /* 게이트 미통과 또는 자문단 지적 사항을 반영하는 재작업 */
        }

        first start;
        then submitModelUpdate;
        then checkAutomatedConventionsAndGates;
        then gateDecision;

        // TODO(확인 필요): decide/if/else 분기 문법은 Syside 0.10.x 에서 check 통과를 확인했으나,
        //   gateEvaluation.result 를 가드로 쓰는 실행 의미(시뮬레이션)는 확인하지 못했다.
        decide gateDecision;
            if gateEvaluation.result then reviewByWGLead;
            else reviseModel;

        first reviewByWGLead then reviewByAcademicAdvisors;
        first reviewByAcademicAdvisors then advisorDecision;

        decide advisorDecision;
            if isAdvisorApproved then reviewByChapterLeadership;
            else reviseModel;

        first reviewByChapterLeadership then mergeAndDeploy;
        first mergeAndDeploy then done;
        first reviseModel then submitModelUpdate;
    }

    // ---------------------------------------------------------------------
    // 3.5 System 2 (챕터 조직) 성장 단계 전환 조건 (Maturity Gate)
    // ---------------------------------------------------------------------
    attribute def MaturityGateThresholds {
        doc
        /* Phase 전환 조건의 임계값 묶음. 모든 값은 '이상(>=)' 최소값이다. */
        attribute presentations : Integer;
        attribute refModels : Integer;
        attribute aiSkills : Integer;
        attribute activeMembers : Integer;
        attribute sepMembers : Integer;
    }

    // Phase 임계값의 단일 정의 위치. 판정식과 doc은 숫자를 다시 적지 않고 이 값을 참조한다.
    attribute phase1To2Thresholds : MaturityGateThresholds {
        :>> presentations = 10;
        :>> refModels = 3;
        :>> aiSkills = 3;
        :>> activeMembers = 16; // 정원 '15명 초과'를 정수 최소값으로 표현
        :>> sepMembers = 3;
    }

    attribute phase2To3Thresholds : MaturityGateThresholds {
        :>> presentations = 0; // Phase 2 -> 3 판정식에서는 사용하지 않음
        :>> refModels = 3;
        :>> aiSkills = 5;
        :>> activeMembers = 30;
        :>> sepMembers = 10;
    }

    abstract constraint def PhaseTransitionGateCondition {
        doc
        /* 조직 성장 조건 (Maturity Gate):
         * LV1 참조모델 승인 누적 건수 및 세미나 발표 건수 등 정량적 지표를 기반으로
         * System 2(KoreaChapter)의 Lifecycle Phase 전환 가능 여부를 판정하는 공통 입력 정의.
         * 구체 판정식과 임계값은 하위 constraint def(Phase1ToPhase2GateConstraint 등)와
         * MaturityGateThresholds 값에만 존재한다.
         */
        in presentations : Integer;
        in refModels : Integer;
        in aiSkills : Integer;
        in activeMembers : Integer;
        in sepMembers : Integer;
        in thresholds : MaturityGateThresholds;
    }

    // ---- Phase 1 -> Phase 2 전환 게이트 (온라인 스터디 -> 오프라인 세미나 정례화) ----
    constraint def Phase1ToPhase2GateConstraint :> PhaseTransitionGateCondition {
        doc
        /* [Phase 1 -> Phase 2 전환 조건 (기업 스폰서 조건 제외)]
         * 판정식: (발표/사례 자료 OR 고정 활동 인원 중 하나) AND 참조모델 AND AI Skills AND SEP 보유 인원.
         * 임계값은 phase1To2Thresholds 를 참조한다.
         */
        in :>> thresholds : MaturityGateThresholds default phase1To2Thresholds;

        (presentations >= thresholds.presentations or activeMembers >= thresholds.activeMembers) and
        refModels >= thresholds.refModels and
        aiSkills >= thresholds.aiSkills and
        sepMembers >= thresholds.sepMembers
    }

    // ---- Phase 2 -> Phase 3 전환 게이트 (세미나 정례화 -> 공식 WG 및 학회 Joint WG) ----
    constraint def Phase2ToPhase3GateConstraint :> PhaseTransitionGateCondition {
        doc
        /* [Phase 2 -> Phase 3 전환 조건 (기업 스폰서 조건 제외)]
         * 판정식: 고정 활동 인원 AND SEP 자격 보유자 AND AI Skills AND 참조모델 유지.
         * 임계값은 phase2To3Thresholds 를 참조한다.
         */
        in :>> thresholds : MaturityGateThresholds default phase2To3Thresholds;

        activeMembers >= thresholds.activeMembers and
        sepMembers >= thresholds.sepMembers and
        aiSkills >= thresholds.aiSkills and
        refModels >= thresholds.refModels
    }
} // package QualityGatesAndReviewProcess
