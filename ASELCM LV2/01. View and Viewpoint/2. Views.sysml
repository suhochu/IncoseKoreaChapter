package Views {
    private import Viewpoints::*;

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
} // package Views
