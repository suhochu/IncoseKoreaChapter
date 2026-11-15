package GovernanceSystemAndTooling {
    private import ModelingConventionsAndPolicies::ModelingConventions::*;
    private import ModelingConventionsAndPolicies::PolicyAndDirectives::*;
    private import QualityGatesAndReviewProcess::*;
    private import ScalarValues::*;

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
            /* [ChapterObjective 연계]
             * SysML v2 모델로부터 MILS/SILS/HILS 시뮬레이션 및 Simulink 오토코드 제너레이션까지
             * End-to-End 추적성을 검증하는 도구 사슬.
             */
        }
    } // package ToolingEcosystem

    // =========================================================================
    // 5-a. Governance Interfaces (System 3 <-> System 2/1 교환 아이템과 포트 정의)
    // =========================================================================
    package GovernanceInterfaces {
        doc
        /* LV3가 정의하는 인터페이스. LV2는 이 포트의 켤레(~GovernanceInterfacePort)를 사용해 연결한다. */

        item def GovernancePolicyDirectiveItem {
            doc
            /* System 3 -> System 2 & System 1: 모델링 규약, 스캐폴드 상속 지침, 보안 규정, Gate 기준 */
            attribute policyVersion : String;
            attribute targetAssignmentStage : SEAssignmentStageKind;
        }

        item def ChapterComplianceAndMetricsItem {
            doc
            /* System 2 & System 1 -> System 3: 과제 게이트 통과 결과, 승인 모델 수, 운영 지표 보고 */
            attribute submittedModelName : String;
            attribute isAssignmentGatePassed : Boolean;
            attribute currentApprovedModelsCount : Integer;
        }

        port def GovernanceInterfacePort {
            doc
            /* System 3 기준 포트. 정책은 내보내고(out), 지표는 받는다(in).
             * System 2 측은 별도 포트를 중복 정의하지 않고 켤레 포트(~)를 사용한다.
             */
            out item policyDirectives : GovernancePolicyDirectiveItem; // 거버넌스 정책(스캐폴드 규약, 피드백 기준, 검증 게이트, 보안 규칙)을 하달
            in item chapterOperationalMetrics : ChapterComplianceAndMetricsItem; // LV1 과제 게이트 통과 여부 및 LV2 운영 지표를 수집
        }
    } // package GovernanceInterfaces

    // =========================================================================
    // 5-b. Governance System (System 3 실체)
    // =========================================================================
    package GovernanceSystem {
        private import GovernanceInterfaces::*;
        private import ToolingEcosystem::*;

        part def GovernanceSystemContext {
            doc
            /* System 2(KoreaChapter)와 System 1(LV1 참조모델)을 감싸고 통제하는 System 3의 최상위 컨텍스트.
             * 거버넌스 규칙과 품질 게이트(학술자문단 피드백 + 가이드 Gate)를 하달하고(out),
             * 규정 준수 상태 및 과제 검증 결과를 수집(in)하여 승인 및 조직 성장(Maturity Gate)을 통제함.
             */

            // 1) 모델링 규약 및 스캐폴드 상속 원칙
            constraint namingConventions : NamingConventionRule [1..*];
            constraint vcsPolicy : VersionControlPolicy;
            constraint scaffoldRule : ScaffoldInheritanceRule;

            // 2) 글로벌 정책, 국제 SE 표준, 도구 라이선스 및 기업 보안 규정
            requirement sectorDirectives : SectorComplianceRule [1..*];
            requirement standardPolicy : SEStandardAlignmentPolicy;
            requirement toolLicensePolicy : ToolLicensePolicy;
            requirement securityPolicy : EnterpriseSecurityAndIPPolicy;

            // 3) 품질 보증 프로세스 및 게이트 (학술자문단 피드백 + 가이드 Gate + 챕터 성장 Gate)
            perform action qaProcess : ModelReviewProcess;
            constraint lv1AssignmentGate : ReferenceModelAssignmentApprovalGate;

            // 챕터 성장 Gate: 구체 게이트만 usage로 두고, 임계값은 MaturityGateThresholds 한 곳에서 가져온다.
            constraint chapterMaturityGate : PhaseTransitionGateCondition [1..*];
            constraint phase1To2Gate : Phase1ToPhase2GateConstraint :> chapterMaturityGate;
            constraint phase2To3Gate : Phase2ToPhase3GateConstraint :> chapterMaturityGate;

            // 4) 도구 생태계 인프라
            part repositoryServer : ModelRepositoryServer;
            part visualizer : VisualizationEngine;
            part simPipeline : SimulationAndCodeGenPipeline [0..1];

            // System 2(KoreaChapter) 및 System 1(LV1 Models)을 통제하기 위한 인터페이스 포트
            port governanceInterface : GovernanceInterfacePort;
        }
    } // package GovernanceSystem
} // package GovernanceSystemAndTooling
