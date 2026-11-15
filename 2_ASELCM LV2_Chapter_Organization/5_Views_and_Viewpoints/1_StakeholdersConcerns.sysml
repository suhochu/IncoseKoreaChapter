package StakeholdersConcerns {
    doc
    /* [이해관계자 관심사(Concerns) 정의]
     * Stakeholders, ActorAndInterfaces, SystemContext 구조를 기반으로
     * 핵심 관심사를 정의하고, 이를 Viewpoints에 빈틈없이 프레임(frame)한다.
     * 공통 subject(theChapter)와 stakeholder(member)는 KoreanChapterConcern에 한 번만 두고,
     * 파생 Concern에는 추가되는 stakeholder만 남긴다.
     *
     * 1. 'administrative operations viewpoint' 매핑 관심사:
     *    - OperationalFlowConcern (운영 흐름 및 정기 보고)
     *    - KnowledgeAssetConcern (지식 저장소 및 참조모델/아티팩트 형상 관리)
     *    - LifecycleEvolutionConcern (챕터 성장 단계 전환 및 핵심 MoE 관리)
     * 2. 'member value viewpoint' 매핑 관심사:
     *    - StakeholderIdentificationConcern (회원 도메인·전문성·기여 자원 식별)
     *    - ValueRationaleValidationConcern (회원 핵심 가치 What, 도출 근거 Why, 검증 기준 Validation)
     *    - RiskSecurityConcern (기업 IP 보호 및 데이터 익명화 보안 규칙)
     * 3. 'incose alignment viewpoint' 매핑 관심사:
     *    - BoundaryDependencyConcern (INCOSE 본부/섹터/TechOps 및 툴 벤더 외부 의존성)
     * 4. 'peer society connection viewpoint' 매핑 관심사:
     *    - CapabilityValueConcern (국내 타 학회 KOSSE/KCOSE 대비 고유 역량 및 상호보완성)
     * 5. 'governance and quality viewpoint' 매핑 관심사:
     *    - GovernanceQualityConcern (LV3 거버넌스 규약, 품질 게이트 및 승인 상태)
     */

    private import StakeholderDefinitions::*;
    private import ExternalActorsAndInterfaces::*;
    private import ChapterSystemContext::*;
    private import GovernanceSystemAndTooling::GovernanceSystem::*;

    concern def KoreanChapterConcern {
        subject theChapter : KoreaChapter;
        stakeholder member : Member;
    }

    // -------------------------------------------------------------------------
    // [Group 1] Member Value Viewpoint 매핑 관심사
    // -------------------------------------------------------------------------
    concern def StakeholderIdentificationConcern :> KoreanChapterConcern {
        require constraint {
            doc
            /* 시스템(챕터)과 직접 상호작용하는 회원 액터들의 소속, 도메인, 지역, 가용 기여 자원 식별. */
        }
    }

    concern def ValueRationaleValidationConcern :> KoreanChapterConcern {
        require constraint {
            doc
            /* 시스템이 이해관계자에게 제공해야 할 핵심 가치(What), 도출
             * 근거(Why), 타당성 확인 기준(Validation), 상충 시 조정
             * 근거(Priority).
             */
        }
    }

    concern def RiskSecurityConcern :> KoreanChapterConcern {
        require constraint {
            doc
            /* 회원들이 소속 기업의 지적 재산(IP)이나 민감한 기술 정보를
             * 침해하지 않으면서도 지식을 교류할 수 있는 안전한 환경
             * (Boundary) 및 보안 규칙(SecurityRule)은 어떻게 구축하는가.
             */
        }
    }

    // -------------------------------------------------------------------------
    // [Group 2] Administrative Operations Viewpoint 매핑 관심사
    // -------------------------------------------------------------------------
    concern def OperationalFlowConcern :> KoreanChapterConcern {
        subject :>> theChapter; // Syside: stakeholder를 추가하는 Concern은 subject 재선언이 첫 파라미터여야 함
        stakeholder sector : ContextINCOSESector;
        require constraint {
            doc
            /* 시스템이 요구사항을 충족하기 위해 운영 기간 동안 어떻게
             * 동작(스프린트, 과제 수행, 세미나)하고 정보를 교환하는가.
             */
        }
    }

    concern def KnowledgeAssetConcern :> KoreanChapterConcern {
        require constraint {
            doc
            /* 챕터 내에서 생성되는 지식(회의록, 가이드, LV1 참조모델 코드)은 어떤 구조를
             * 가지며, 단일 진실 공급원(KnowledgeRepository)에 어떻게 저장되고 추적되는가.
             */
        }
    }

    concern def LifecycleEvolutionConcern :> KoreanChapterConcern {
        require constraint {
            doc
            /* 시스템(챕터)이 시간에 따라 어떻게 상태(Phase 1 -> Phase 2 -> Phase 3)가 변하고
             * 핵심 성과 지표(Core MoEs)를 통해 진화하는가.
             */
        }
    }

    // -------------------------------------------------------------------------
    // [Group 3] INCOSE Alignment Viewpoint 매핑 관심사
    // -------------------------------------------------------------------------
    concern def BoundaryDependencyConcern :> KoreanChapterConcern {
        subject :>> theChapter;
        stakeholder vendor : ContextToolVendor;
        stakeholder techOps : ContextTechnicalOperations;
        require constraint {
            doc
            /* 시스템의 경계(Boundary), 외부 의존성(Dependencies), 가용
             * 툴 라이선스 및 INCOSE 글로벌 리소스(SE Handbook 등) 연계 한계.
             */
        }
    }

    // -------------------------------------------------------------------------
    // [Group 4] Peer Society Connection Viewpoint 매핑 관심사
    // -------------------------------------------------------------------------
    concern def CapabilityValueConcern :> KoreanChapterConcern {
        subject :>> theChapter;
        stakeholder peerMember : PeerSocietyMember;
        stakeholder peerOrg : ContextPeerSocietyOrganization;
        require constraint {
            doc
            /* 이 시스템이 궁극적으로 한국의 시스템 엔지니어링 생태계
             * (상위 시스템)에 타 학회(KOSSE/KCOSE) 대비 어떤 고유한 역량(Capability)을 제공하는가.
             */
        }
    }

    // -------------------------------------------------------------------------
    // [Group 5] Governance and Quality Viewpoint 매핑 관심사
    // -------------------------------------------------------------------------
    concern def GovernanceQualityConcern :> KoreanChapterConcern {
        subject :>> theChapter;
        stakeholder governance : GovernanceSystemContext;
        require constraint {
            doc
            /* LV3 거버넌스가 하달하는 모델링 규약과 품질 게이트(학술자문단 피드백, 가이드 Gate)를
             * 워킹그룹 제출물이 충족하는지, 그리고 승인 상태(status)가 게이트 판정 결과와
             * 모순되지 않는지를 어떻게 추적하는가.
             */
        }
    }
} // package StakeholdersConcerns
