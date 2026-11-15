package ModelingConventionsAndPolicies {
    doc
    /* ASELCM System 3 (Environment & Governance System)
     * 통제 대상:
     *   - System 2 (LV2: INCOSE Korea Chapter 조직 및 과제 운영 모델)
     *   - System 1 (LV1: 워킹그룹별 도메인 참조모델 - 3_ASELCM_LV1_Target_Reference_Models)
     * 목적: 챕터 운영 모델과 도메인 참조모델의 일관성, 확장성, 표준 준수성 및 학술적 엄밀성을 통제하는 거버넌스 프레임워크
     *
     * 의존 방향: LV3는 LV2/LV1을 import하지 않는다. LV2와 LV3를 함께 묶는 요소는
     * 0_ASELCM_Integration/ASELCM_SystemOfSystems.sysml 에만 둔다.
     */

    private import ScalarValues::*;

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
            /* 모델 요소 명명 규칙. 아래 패턴은 현재 모델에서 실제로 쓰이는 형태를 기준으로 정리한 것이며,
             * 각 판정값은 기본값 없이 검토(리뷰/린트) 결과를 입력으로 받는다.
             *
             * 1) Definition(part def, action def, item def, constraint def 등)과 Package는 PascalCase.
             *    숫자와 밑줄(_)은 구분자로만 허용한다. (예: Gate1_WholeSystemScopeRule, SprintMeetings_2026_Q4)
             * 2) Usage와 Attribute는 lowerCamelCase.
             *    밑줄(_)은 '순번/식별자/날짜' 접미 또는 접두 구분에만 허용한다.
             *    (예: folder1_Meeting, kickOffMeeting_20261009, ai1_setupChannels, need_M001)
             * 3) Enum 값은 lowerCamelCase. 순번이 필요하면 'stage1_...' 처럼 소문자 접두 + 순번 + 밑줄을 쓴다.
             * 4) 식별자(예: 회원 ID)는 별도 attribute를 만들지 않고 SysML short name(<M001>)으로 부여한다.
             * 5) 따옴표 이름('이수', 'member value viewpoint')은 사람 이름과 Viewpoint처럼 표시명이 필요한 요소에만 허용한다.
             * 6) 주석(doc)으로만 정보를 남기지 않고 정형 속성(attribute)과 참조(ref)로 모델링한다.
             */
            in isPascalCaseDef : Boolean;
            in isPascalCasePackage : Boolean;
            in isCamelCaseUsage : Boolean;
            in isCamelCaseEnumLiteral : Boolean;
            in isUnderscoreUsedOnlyAsSeparator : Boolean;
            isPascalCaseDef and isPascalCasePackage and isCamelCaseUsage and
            isCamelCaseEnumLiteral and isUnderscoreUsedOnlyAsSeparator
            // TODO(확인 필요): 위 판정값을 채우는 자동 점검 수단(Syside Python API 린트 스크립트 등)이 아직 없다.
            //   입력이 바인딩되지 않은 동안에는 판정이 수행되지 않는다(과거의 'default true'로 인한 항상 참 문제는 제거함).
        }

        constraint def VersionControlPolicy {
            doc
            /* 메인 브랜치(main) 및 KnowledgeRepository 병합 전:
             * 1) 워킹그룹 리드(WG Lead)의 1차 모델 검토
             * 2) 학술자문단(Academic Advisors)의 방법론/피드백 검증
             * 3) 보안 및 형상 관리 Pull Request 승인 필수
             * 위 순서는 QualityGatesAndReviewProcess::ModelReviewProcess 의 검토 단계와 일치해야 한다.
             */
            in isWGLeadReviewed : Boolean;
            in isAcademicAdvisorApproved : Boolean;
            in isSecretaryMerged : Boolean;
            isWGLeadReviewed and isAcademicAdvisorApproved and isSecretaryMerged
        }

        constraint def ScaffoldInheritanceRule {
            doc
            /* [LV1 참조모델 아키텍처 일관성 규칙]
             * 3_ASELCM_LV1_Target_Reference_Models 내 모든 워킹그룹 모델은
             * 'LV1_BlackBox_ConOps_Scaffold'의 추상 정의(BaseMissionObjective, BaseBlackBoxSoI,
             * BaseBlackBoxOperationalContext, BaseBlackBoxConOpsScenario)를 상속(:>)하여 구현해야 함.
             */
            in inheritsCommonScaffold : Boolean;
            in maintainsPortTypeSymmetry : Boolean; // 외부 액터 포트(~)와 SoI 포트 간 대칭성 유지 여부
            inheritsCommonScaffold and maintainsPortTypeSymmetry
        }

        constraint def EnterpriseSecurityRule {
            in isInternalDataExcluded : Boolean;
            in isCompanyProjectAnonymized : Boolean;
            isInternalDataExcluded and isCompanyProjectAnonymized
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

        private import ModelingConventions::*;

        requirement def SectorComplianceRule {
            doc
            /* 아시아-오세아니아 섹터(Sector III) 정기 활동 보고 양식 및 주기 준수 규정 */
            attribute isReportFormatCompliant : Boolean;
            attribute isReportedWithinRequiredPeriod : Boolean;

            require constraint sectorReportCompliance {
                isReportFormatCompliant and isReportedWithinRequiredPeriod
            }
        }

        requirement def ToolLicensePolicy {
            doc
            /* 상용 MBSE 툴(Cameo 등), Syside 및 SysML v2 API 사용 시 라이선스 위반 방지 규정 */
            attribute isLicenseHeldByAllParticipants : Boolean;
            attribute isUsageWithinLicenseScope : Boolean; // 예: Community Edition 가용 범위

            require constraint toolLicenseCompliance {
                isLicenseHeldByAllParticipants and isUsageWithinLicenseScope
            }
        }

        requirement def SEStandardAlignmentPolicy {
            doc
            /* [실무 가이드 표준 근거 반영]
             * 모든 LV1 참조모델 및 LV2 요구사항은 아래 국제 표준을 준거 틀로 삼아야 함:
             * 1) ISO/IEC/IEEE 15288 (시스템 생명주기 프로세스 - 문제 공간과 해결 공간의 분리)
             * 2) INCOSE GtWR v4 (Guide to Writing Requirements - What/Why/Validation 축)
             * 3) OMG SysML v2 (정형 텍스트 및 그래픽 모델링 표준 문법)
             */
            attribute isAlignedWithIso15288 : Boolean;
            attribute isAlignedWithGtWR : Boolean;
            attribute isAlignedWithSysMLv2 : Boolean;

            require constraint standardAlignment {
                isAlignedWithIso15288 and isAlignedWithGtWR and isAlignedWithSysMLv2
            }
        }

        requirement def EnterpriseSecurityAndIPPolicy {
            doc
            /* [킥오프 합의 및 회원 보안 요구사항 반영]
             * 소속 기업의 지적 재산(IP) 및 방산/산업 민감 데이터 보호를 위해:
             * 1) 사내 실제 수치 및 프로젝트명/회사명 직접 기재 절대 금지
             * 2) 인터넷 공개 데이터 및 AI 기반 가상 치환 데이터(Anonymized Data)만 사용
             */
            require constraint security : EnterpriseSecurityRule;
        }
    } // package PolicyAndDirectives
} // package ModelingConventionsAndPolicies
