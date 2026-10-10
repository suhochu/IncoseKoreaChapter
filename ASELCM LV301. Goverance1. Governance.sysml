package INCOSE_Korea_Chapter_Governance {
    doc
    /* ASELCM System 3 (Environment & Governance System)
     * 대상: System 2 (INCOSE Korea Chapter 조직 및 운영 모델)
     * 목적: 챕터 모델의 일관성, 확장성, 표준 준수성을 통제하는 거버넌스 프레임워크
     */

    // 통제 대상인 System 2(조직 모델) 및 외부 컨텍스트 임포트 (Lifecycle 제외)
    private import SystemContext::*;

    // ==========================================
    // 1. Modeling Conventions (모델링 규약 및 형상 관리)
    // ==========================================
    package ModelingConventions {
        doc 
        /* System-as-Code 접근 방식에 따른 SysML v2 모델 작성 표준 및 버전 관리 체계.
         * Git/GitHub 기반의 브랜치 전략, 커밋 메시지 규칙, 그리고 
         * 모델 요소별 명명 규칙(Naming Convention)을 정의하여 다수 회원의 협업 충돌을 방지.
         */

        constraint def NamingConventionRule {
            doc /* 예: 모든 part def는 PascalCase, 속성은 camelCase 준수 등 */
        }
        
        constraint def VersionControlPolicy {
            doc /* 예: 메인 브랜치 병합 전 총무 및 운영진의 Pull Request 승인 필수 */
        }
    }

    // ==========================================
    // 2. Policy & Directives (글로벌 정책 및 외부 규정)
    // ==========================================
    package PolicyAndDirectives {
        doc 
        /* INCOSE Global (Board of Directors) 및 Asia-Oceania Sector의 상위 지침.
         * 챕터 운영 모델이 글로벌 규정(Operations Manual)과 상충하지 않도록 제약(Constraint)을 가함.
         */

        requirement def SectorComplianceRule {
            doc /* 아시아-오세아니아 섹터 정기 활동 보고 양식 및 주기 준수 규정 */
        }

        requirement def ToolLicensePolicy {
            doc /* 상용 MBSE 툴(Cameo 등) 및 SysML v2 API 사용 시 라이선스 위반 방지 규정 */
        }
    }

    // ==========================================
    // 3. Quality Assurance & Maturity Gates (품질 보증 및 성장 통제)
    // ==========================================
    package QualityAssurance {
        doc 
        /* System 2 모델의 무결성 평가 및 조직 성장을 통제하는 프로세스.
         * 구체적인 Lifecycle(상태머신) 구현체가 없더라도, 거버넌스 차원에서 
         * 조직이 다음 단계로 나아가기 위한 품질/정량적 요건을 제약(Constraint)으로 관리함.
         */

        action def ModelReviewProcess {
            doc /* 정기적인 챕터 모델 리팩토링 및 논리적 오류(Validation) 검수 흐름 */
            action submitModelUpdate;
            action reviewByChapterLeadership;
            action mergeAndDeploy;

            first submitModelUpdate;
            then reviewByChapterLeadership;
            then mergeAndDeploy;
        }

        constraint def PhaseTransitionGateCondition {
            doc /* 조직 성장 조건 (Maturity Gate): 
                 * 오프라인 세미나 정례화 및 공식 워킹그룹 발족 등 
                 * 특정 수준에 도달하기 위해 요구되는 정량적/정성적 지표 달성 여부 검증.
                 */
        }
    }

    // ==========================================
    // 4. Tooling Ecosystem (도구 사슬 및 IT 환경)
    // ==========================================
    package ToolingEcosystem {
        doc 
        /* 챕터 모델이 배포되고 시각화되는 외부 IT 인프라 환경.
         * SysML v2 API 연동, 시각화 도구(Tom Sawyer 등), 웹 블로그/지식 저장소 파이프라인.
         */

        part def ModelRepositoryServer {
            doc /* SysML v2 모델을 호스팅하고 REST API를 제공하는 백엔드 환경 */
        }

        part def VisualizationEngine {
            doc /* 텍스트 모델을 다이어그램으로 렌더링하는 시각화 도구 환경 */
        }
    }

    // ==========================================
    // 5. Governance System (System 3 실체 및 통제 포트)
    // ==========================================
    part def GovernanceSystem {
        doc 
        /* System 2(KoreaChapter)를 감싸고 통제하는 System 3의 최상위 컨텍스트.
         * 챕터 운영 시스템이 거버넌스 규칙을 입력받고(in), 규정 준수 상태를 출력(out)하는 구조.
         */
        
        // 거버넌스를 구성하는 하위 규정 및 시스템들
        part conventions : ModelingConventions::NamingConventionRule [1..*];
        part directives : PolicyAndDirectives::SectorComplianceRule [1..*];
        part qaProcess : QualityAssurance::ModelReviewProcess;
        part toolchain : ToolingEcosystem::ModelRepositoryServer;

        // System 2(KoreaChapter)를 통제하기 위한 인터페이스
        port governanceControlPort {
            doc /* 거버넌스 정책(규칙, 라이선스, 승인 요건)을 System 2로 전달 */
            out item policyDirectives;
        }
        
        port complianceMonitoringPort {
            doc /* System 2의 운영 데이터 및 활동 지표를 수집하여 상태 전환(Maturity Gate) 심사에 활용 */
            in item chapterOperationalMetrics;
        }
    }
}
