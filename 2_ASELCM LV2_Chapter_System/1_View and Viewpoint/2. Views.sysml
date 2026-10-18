package Views {
    private import Viewpoints::*;
    private import Viewpoints::*;
    private import SysideViews::*;
    private import SysideViews::TableViewDefinitions::*;
    private import SysideViews::MatrixViewDefinitions::*;

    view AdministrativeOperationsView {
        doc
        /* 행정/운영 흐름, 플랫폼(KnowledgeRepository) 스키마 및 제약 조건 노출 */
        satisfy 'administrative operations viewpoint';
        expose SystemContext::KnowledgeRepository;
        expose SystemContext::OperationalConstraintCheck;
        // expose ChapterBehavior::ConOps::*; (추후 행위 모델 구현 시 노출)
    }

    view MemberValueView {
        doc
        /* 회원 속성(도메인, 관심사), 제공 자원 및 회원 가치 검증 세트 노출 */
        satisfy 'member value viewpoint';
        expose ChapterMembers::IncoseKoreaChapterMember;
        expose ChapterMembers::IncoseKoreaChapterMember::giveResource;
        // expose ChapterRequirements::MemberNeeds::*; (추후 요구사항 구현 시 노출)
    }

    view IncoseAlignmentView {
        doc
        /* 외부 액터 중 INCOSESector, TechnicalOperations와의 인터페이스 연결 및 아이템 흐름 노출 */
        satisfy 'incose alignment viewpoint';
        expose ActorAndInterfaces::ContextINCOSESector;
        expose ActorAndInterfaces::ContextTechnicalOperations;
        expose ActorAndInterfaces::SectorActivityReportItem;
        expose ActorAndInterfaces::HandbookResourceItem;
    }

    view PeerSocietyConnectionView {
        doc
        /* KOSSE, KCOSE 등 외부 학회 액터(PeerSocietyOrganization)와의 인터페이스 및 역량(Capability) 노출 */
        satisfy 'peer society connection viewpoint';
        expose ActorAndInterfaces::ContextPeerSocietyOrganization;
        expose ActorAndInterfaces::PeerBenchmarkItem;
        expose Stakeholders::PeerSociety;
        // expose ChapterCapabilities::*; (추후 역량 모델 구현 시 노출)
    }

    // SysideViews::TableView를 활용한 회원별 GtWR 요구사항 일람표 뷰
    view MemberNeedsGtWRTableView : TableView {
        satisfy 'member value viewpoint';
        expose StakeholdersNeeds::ChapterMembers_Needs::*;

        view col_id :>> columnViews {
            attribute :>> featureToRender = ColumnType::declaredName;
            attribute :>> columnWidth = 180;
        }
        view col_what :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attribute attributeName = "coreValueWhat";
            }
            attribute :>> columnWidth = 350;
        }
        view col_why :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attribute attributeName = "rationale";
            }
            attribute :>> columnWidth = 300;
        }
        view col_validation :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attribute attributeName = "validationCriterion";
            }
            attribute :>> columnWidth = 300;
        }
    }

    view ChapterCoreMoEsTableView : SysideViews::TableViewDefinitions::TableView {
        doc
        /* 챕터의 5대 핵심 성과 지표(Core MoEs) 현황을 모니터링하는 테이블 뷰 */
        satisfy 'administrative operations viewpoint';
        expose SystemContext::incoseKoreaChapterContext::chapter;

        view col_name :>> columnViews {
            attribute :>> featureToRender = SysideViews::ColumnType::declaredName;
        }
        view col_presentations :>> columnViews {
            attribute :>> featureToRender = SysideViews::ColumnType::attributeValue {
                attribute attributeName = "accumulatedPresentationsCount";
            }
        }
        view col_refModels :>> columnViews {
            attribute :>> featureToRender = SysideViews::ColumnType::attributeValue {
                attribute attributeName = "completedReferenceModelsCount";
            }
        }
        view col_aiSkills :>> columnViews {
            attribute :>> featureToRender = SysideViews::ColumnType::attributeValue {
                attribute attributeName = "developedAISkillsCount";
            }
        }
        view col_activeMembers :>> columnViews {
            attribute :>> featureToRender = SysideViews::ColumnType::attributeValue {
                attribute attributeName = "regularActiveMembersCount";
            }
        }
        view col_sepMembers :>> columnViews {
            attribute :>> featureToRender = SysideViews::ColumnType::attributeValue {
                attribute attributeName = "sepCertifiedMembersCount";
            }
        }
    } // package Views
} // package Views
