package StakeholdersConcerns {
    doc
    /* Concerns — 통합된 Stakeholders, ActorAndInterfaces, SystemContext 
     * 구조를 기반으로 각 뷰포인트별 1:1 매핑되는 관심사 정의
     */

    // 앞서 통합한 Comprehensive 패키지 요소들을 import
    private import Stakeholders::*;
    private import ActorAndInterfaces::*;
    private import SystemContext::*;

    concern def KoreanChapterConcern;

    concern def ValueRationaleValidationConcern :> KoreanChapterConcern {
        subject theChapter : KoreaChapter;
        stakeholder member : Member;
        require constraint {
            doc
            /* 시스템이 이해관계자에게 제공해야 할 핵심 가치(What), 도출
             * 근거(Why), 타당성 확인 기준(Validation), 상충 시 조정
             * 근거(Priority).
             */
        }
    }

    concern def BoundaryDependencyConcern :> KoreanChapterConcern {
        subject theChapter : KoreaChapter;
        stakeholder member : Member;
        stakeholder vendor : ContextToolVendor; // 외부 인터페이스 액터로 매핑 업데이트
        stakeholder techOps : ContextTechnicalOperations; // 신규: SE Handbook 등 문서 리딩의 원천이 되는 의존성 추가
        require constraint {
            doc
            /* 시스템의 경계(Boundary), 외부 의존성(Dependencies), 가용
             * 리소스 및 물리적/보안적 한계.
             */
        }
    }

    concern def OperationalFlowConcern :> KoreanChapterConcern {
        subject theChapter : KoreaChapter;
        stakeholder member : Member;
        stakeholder sector : ContextINCOSESector; // 외부 인터페이스 액터로 매핑 업데이트
        require constraint {
            doc
            /* 시스템이 요구사항을 충족하기 위해 운영 기간 동안 어떻게
             * 동작하고 정보를 교환하는가. (활동 보고 및 운영 흐름)
             */
        }
    }

    concern def LifecycleEvolutionConcern :> KoreanChapterConcern {
        subject theChapter : KoreaChapter;
        stakeholder member : Member;
        require constraint {
            doc
            /* 시스템(챕터)이 시간에 따라 어떻게 상태(State)가 변하고
             * 진화하는가. (Phase 1 -> Phase 2 전환 등)
             */
        }
    }

    concern def KnowledgeAssetConcern :> KoreanChapterConcern {
        subject theChapter : KoreaChapter;
        stakeholder member : Member;
        require constraint {
            doc
            /* 챕터 내에서 생성되는 지식(데이터, 모델, 문서)은 어떤 구조를
             * 가지며, 어디에 저장되고 어떻게 추적되는가.
             */
        }
    }

    concern def RiskSecurityConcern :> KoreanChapterConcern {
        subject theChapter : KoreaChapter;
        stakeholder member : Member;
        require constraint {
            doc
            /* 회원들이 소속 기업의 지적 재산(IP)이나 민감한 기술 정보를
             * 침해하지 않으면서도 지식을 교류할 수 있는 안전한 환경
             * (Boundary)은 어떻게 구축하는가.
             */
        }
    }

    concern def CapabilityValueConcern :> KoreanChapterConcern {
        subject theChapter : KoreaChapter;
        stakeholder member : Member;
        stakeholder peerMember : PeerSocietyMember;
        stakeholder peerOrg : ContextPeerSocietyOrganization; // 신규: 개별 회원을 넘어선 조직 단위 타 학회(KOSSE/KCOSE) 비교 대상 편입
        require constraint {
            doc
            /* 이 시스템이 궁극적으로 한국의 시스템 엔지니어링 생태계
             * (상위 시스템)에 어떤 고유한 역량(Capability)을 제공하는가.
             */
        }
    }

    concern def StakeholderIdentificationConcern :> KoreanChapterConcern {
        subject theChapter : KoreaChapter;
        stakeholder member : Member;
        require constraint {
            doc
            /* 시스템(챕터)과 직접 상호작용하는 액터들의 속성, 도메인, 전문성 레벨 식별. */
        }
    }
} // package StakeholdersConcerns
