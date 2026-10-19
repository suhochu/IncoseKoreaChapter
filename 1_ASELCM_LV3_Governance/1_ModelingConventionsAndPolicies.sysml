package ModelingConventionsAndPolicies {
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
} // package ModelingConventionsAndPolicies
