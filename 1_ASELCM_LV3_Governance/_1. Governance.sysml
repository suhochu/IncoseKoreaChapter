package INCOSE_Korea_Chapter_Governance {
    doc
    /* ASELCM System 3 (Environment & Governance System)
     * 통제 대상:
     *   - System 2 (LV2: INCOSE Korea Chapter 조직 및 과제 운영 모델)
     *   - System 1 (LV1: 워킹그룹별 도메인 참조모델 - 3_ASELCM_LV1_Target_Reference_Models)
     * 목적: 챕터 운영 모델과 도메인 참조모델의 일관성, 확장성, 표준 준수성 및 학술적 엄밀성을 통제하는 거버넌스 프레임워크
     */

    private import ScalarValues::*;
    private import ChapterSystemContext::*;
    private import LV1_BlackBox_ConOps_Scaffold::*;

    // ==========================================
    // 1. Modeling Conventions (모델링 규약, 스캐폴드 상속 및 형상 관리)
    // ==========================================
    package ModelingConventions {
        doc
        /* System-as-Code 접근 방식에 따른 SysML v2 모델 작성 표준 및 버전 관리 체계.
         * Git/GitHub 기반의 브랜치 전략, 명명 규칙, 그리고 LV1 공통 스캐폴드 상속 규칙을 정의하여
         * 다수 회원의 협업 충돌을 방지하고 도메인 간 메타모델 일관성을 유지함.
         */

        constraint def NamingConventionRule {
            doc
            /* 1) 모든 Definition(part def, action def, item def 등)은 PascalCase 준수
             * 2) 모든 Usage 및 Attribute는 camelCase 준수
             * 3) 주석(doc)으로만 정보를 남기지 않고 정형 속성(attribute)과 참조(ref)로 모델링
             */
            attribute isPascalCaseDef : Boolean default true;
            attribute isCamelCaseUsage : Boolean default true;
        }

        constraint def VersionControlPolicy {
            doc
            /* 메인 브랜치(main) 및 KnowledgeRepository 병합 전:
             * 1) 워킹그룹 리드(WG Lead)의 1차 모델 검토
             * 2) 학술자문단(Academic Advisors: 교수진)의 방법론/피드백 검증
             * 3) 보안 및 형상 관리 Pull Request 승인 필수
             */
            attribute isWGLeadReviewed : Boolean;
            attribute isAcademicAdvisorApproved : Boolean;
            attribute isSecretaryMerged : Boolean;
            isWGLeadReviewed and isAcademicAdvisorApproved and isSecretaryMerged
        }

        constraint def ScaffoldInheritanceRule {
            doc
            /* [LV1 참조모델 아키텍처 일관성 규칙]
             * 3_ASELCM_LV1_Target_Reference_Models 내 모든 워킹그룹 모델은
             * 'LV1_BlackBox_ConOps_Scaffold'의 추상 정의(BaseMissionObjective, BaseBlackBoxSoI,
             * BaseBlackBoxOperationalContext, BaseBlackBoxConOpsScenario)를 상속(:>)하여 구현해야 함.
             */
            attribute inheritsCommonScaffold : Boolean;
            attribute maintainsPortTypeSymmetry : Boolean; // 외부 액터 포트(~)와 SoI 포트 간 대칭성 유지 여부
            inheritsCommonScaffold and maintainsPortTypeSymmetry
        }
    } // package ModelingConventions

    // =========================================================================
    // 2. Policy & Directives (글로벌 정책, SE 국제 표준 및 보안 규정)
    // =========================================================================
    package PolicyAndDirectives {
        doc
        /* INCOSE Global (Board of Directors), Asia-Oceania Sector 상위 지침 및
         * 국제 SE 표준(ISO 15288, GtWR v4), 기업 정보보안 규정을 강제하는 정책 패키지.
         */

        requirement def SectorComplianceRule {
            doc
            /* 아시아-오세아니아 섹터(Sector III) 정기 활동 보고 양식 및 주기 준수 규정 */
        }

        requirement def ToolLicensePolicy {
            doc
            /* 상용 MBSE 툴(Cameo 등), Syside 및 SysML v2 API 사용 시 라이선스 위반 방지 규정 */
        }

        requirement def SEStandardAlignmentPolicy {
            doc
            /* [실무 가이드 표준 근거 반영]
             * 모든 LV1 참조모델 및 LV2 요구사항은 아래 3대 국제 표준을 준거 틀로 삼아야 함:
             * 1) ISO/IEC/IEEE 15288 (시스템 생명주기 프로세스 - 문제 공간과 해결 공간의 분리)
             * 2) INCOSE GtWR v4 (Guide to Writing Requirements - What/Why/Validation 3대 축)
             * 3) OMG SysML v2 (정형 텍스트 및 그래픽 모델링 표준 문법)
             */
        }

        requirement def EnterpriseSecurityAndIPPolicy {
            doc
            /* [킥오프 합의 및 회원 보안 요구사항 반영]
             * 소속 기업의 지적 재산(IP) 및 방산/산업 민감 데이터 보호를 위해:
             * 1) 사내 실제 수치 및 프로젝트명/회사명 직접 기재 절대 금지
             * 2) 인터넷 공개 데이터 및 AI 기반 가상 치환 데이터(Anonymized Data)만 사용
             */
            attribute isInternalDataExcluded : Boolean;
            attribute isCompanyProjectAnonymized : Boolean;
        }
    } // package PolicyAndDirectives

    // =========================================================================
    // 3. Quality Assurance & Maturity Gates (품질 보증, 교수님 피드백 & 6대 게이트)
    // =========================================================================
    package QualityAssurance {
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
            hasMissionAndBusinessNarrative and
            hasMOETargetValue and
            hasMOEThresholdValue and
            hasMOEUnit
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
    } // package QualityAssurance

    // =========================================================================
    // 4. Tooling Ecosystem (도구 사슬 및 IT 환경)
    // =========================================================================
    package ToolingEcosystem {
        doc
        /* 챕터 모델이 작성, 검증, 배포되고 시각화되는 외부 IT 인프라 환경. */

        part def ModelRepositoryServer {
            doc
            /* GitHub 및 Google Workspace 기반 SysML v2 모델 호스팅 및 버전 관리 서버 */
        }

        part def VisualizationEngine {
            doc
            /* Syside / Tom Sawyer 등 텍스트 모델을 다이어그램 및 테이블/매트릭스로 렌더링하는 환경 */
        }

        part def SimulationAndCodeGenPipeline {
            doc
            /* [ChapterObjective 3번 연계]
             * SysML v2 모델로부터 MILS/SILS/HILS 시뮬레이션 및 Simulink 오토코드 제너레이션까지
             * End-to-End 추적성을 검증하는 도구 사슬.
             */
        }
    } // package ToolingEcosystem

    // =========================================================================
    // 5. Governance System (System 3 실체 및 통제 인터페이스)
    // =========================================================================
    // 거버넌스 포트 교환 아이템 정의
    item def GovernancePolicyDirectiveItem {
        doc
        /* System 3 -> System 2 & System 1: 모델링 규약, 스캐폴드 상속 지침, 보안 규정, 6대 Gate 기준 */
        attribute policyVersion : String;
        attribute targetAssignmentStage : String;
    }

    item def ChapterComplianceAndMetricsItem {
        doc
        /* System 2 & System 1 -> System 3: 과제 게이트 통과 결과, 승인 모델 수, 운영 지표 보고 */
        attribute submittedModelName : String;
        attribute isAssignmentGatePassed : Boolean;
        attribute currentApprovedModelsCount : Integer;
    }

    part def GovernanceSystem {
        doc
        /* System 2(KoreaChapter)와 System 1(LV1 참조모델)을 감싸고 통제하는 System 3의 최상위 컨텍스트.
         * 거버넌스 규칙과 품질 게이트(교수님 피드백 + 6대 Gate)를 하달하고(out),
         * 규정 준수 상태 및 과제 검증 결과를 수집(in)하여 승인 및 조직 성장(Maturity Gate)을 통제함.
         */

        // 1) 모델링 규약 및 스캐폴드 상속 원칙
        part namingConventions : ModelingConventions::NamingConventionRule [1..*];
        part vcsPolicy : ModelingConventions::VersionControlPolicy;
        part scaffoldRule : ModelingConventions::ScaffoldInheritanceRule;

        // 2) 글로벌 정책, 국제 SE 표준 및 기업 보안 규정
        part sectorDirectives : PolicyAndDirectives::SectorComplianceRule [1..*];
        part standardPolicy : PolicyAndDirectives::SEStandardAlignmentPolicy;
        part securityPolicy : PolicyAndDirectives::EnterpriseSecurityAndIPPolicy;

        // 3) 품질 보증 프로세스 및 게이트 (교수님 피드백 3종 + 가이드 6대 Gate + 챕터 성장 Gate)
        part qaProcess : QualityAssurance::ModelReviewProcess;
        part lv1AssignmentGate : QualityAssurance::ReferenceModelAssignmentApprovalGate;
        part chapterMaturityGate : QualityAssurance::PhaseTransitionGateCondition;

        // 4) 도구 생태계 인프라
        part repositoryServer : ToolingEcosystem::ModelRepositoryServer;
        part visualizer : ToolingEcosystem::VisualizationEngine;
        part simPipeline : ToolingEcosystem::SimulationAndCodeGenPipeline [0..1];

        // System 2(KoreaChapter) 및 System 1(LV1 Models)을 통제하기 위한 인터페이스 포트
        port governanceControlPort {
            doc
            /* 거버넌스 정책(스캐폴드 규약, 교수님 피드백 기준, 6대 검증 게이트, 보안 규칙)을 하달 */
            out item policyDirectives : GovernancePolicyDirectiveItem;
        }

        port complianceMonitoringPort {
            doc
            /* LV1 과제 게이트 통과 여부 및 LV2 운영 지표를 수집하여 Baseline 승인 및 Phase 전환 심사 */
            in item chapterOperationalMetrics : ChapterComplianceAndMetricsItem;
        }
    }
} // package INCOSE_Korea_Chapter_Governance
