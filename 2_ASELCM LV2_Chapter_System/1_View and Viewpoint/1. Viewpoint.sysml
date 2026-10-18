package Viewpoints {
    private import StakeholdersConcerns::*;

    viewpoint 'administrative operations viewpoint' {
        // 행정/운영 관점이 다루는 3대 관심사(운영 흐름 + 지식자산/참조모델 관리 + 수명주기/MoE 진화)를 모두 frame
        frame concern operationalFlow : OperationalFlowConcern;
        frame concern knowledgeAsset : KnowledgeAssetConcern;
        frame concern lifecycleEvolution : LifecycleEvolutionConcern;

        require constraint {
            doc
            /* 1. Chapter의 효과적이고 지속적인 운영을 위한 행정적인 관점
             * - 운영 흐름 및 과제 스프린트 프로세스 (OperationalFlowConcern)
             * - 지식 저장소(KnowledgeRepository) 및 LV1 참조모델 형상 관리 (KnowledgeAssetConcern)
             * - 향후 챕터 성장 단계(Phase 1->2->3) 및 5대 핵심 MoE 전환 규칙 (LifecycleEvolutionConcern)
             */
        }
    }

    viewpoint 'member value viewpoint' {
        // 회원 가치 관점이 다루는 3대 관심사(회원 식별 + 핵심 가치/근거/검증 + 기업 보안 규칙)를 모두 frame
        frame concern stakeholderId : StakeholderIdentificationConcern;
        frame concern valueRationale : ValueRationaleValidationConcern;
        frame concern riskSecurity : RiskSecurityConcern;

        require constraint {
            doc
            /* 2. Chapter가 각 멤버들에게 실질적인 긍정적인 영향을 주기 위한 관점
             * - 회원들의 도메인·지역·가용 기여 자원 식별 (StakeholderIdentificationConcern)
             * - 회원별 요구사항(What), 근거(Why), 검증 기준(Validation) 충족 (ValueRationaleValidationConcern)
             * - 개인 및 소속 기업의 정보보안 제약 조건(SecurityRules) 준수 (RiskSecurityConcern)
             */
        }
    }

    viewpoint 'incose alignment viewpoint' {
        frame concern boundaryDependency : BoundaryDependencyConcern;

        require constraint {
            doc
            /* 3. INCOSE 자체와 연결을 위한 관점
             * - INCOSE Asia-Oceania Sector 보고 체계 확립,
             * - Technical Operations의 SE Handbook 등 글로벌 표준 산출물 도입 및
             * - 툴 벤더 등 외부 환경 의존성 관리 및 얼라인먼트를 다룸 (BoundaryDependencyConcern)
             */
        }
    }

    viewpoint 'peer society connection viewpoint' {
        frame concern capabilityValue : CapabilityValueConcern;

        require constraint {
            doc
            /* 4. 기존 시스템 엔지니어링 모임(KCOSE, KOSSE 등)과의 연계 관점
             * - 국내 타 학회와의 상호 보완적 역할, 챕터 대 챕터 차원의 정보 교환,
             * - 조직 레벨에서의 벤치마킹 및 차별화된 시스템 엔지니어링 생태계 고유 역량 제공 (CapabilityValueConcern)
             */
        }
    }
} // package Viewpoints
