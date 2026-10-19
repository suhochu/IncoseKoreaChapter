package GovernanceSystemAndTooling {
    private import ModelingConventionsAndPolicies::*;
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
    package GovernanceSystem {
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
            part qaProcess : ModelReviewProcess;
            part lv1AssignmentGate : ReferenceModelAssignmentApprovalGate;
            part chapterMaturityGate : PhaseTransitionGateCondition;

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
    } // package GovernanceSystem
} // package GovernanceSystemAndTooling
