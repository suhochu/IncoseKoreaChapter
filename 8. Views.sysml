package Views {
    private import Viewpoints::*;

    view StakeholderView {
        doc
        /* 문항 5·6 응답 → Member part 및 domain/interestKeyword 속성으로 노출 */
        satisfy 'stakeholder viewpoint';
        expose ChapterStructure::Stakeholders::*;
    }

    view RequirementsView {
        doc
        /* 문항 7·8·9·10 응답 → MemberNeedRequirement 세트로 노출 */
        satisfy 'requirements viewpoint';
        expose ChapterRequirements::MemberNeeds::*;
    }

    view ContextConstraintsView {
        doc
        /* 문항 11~14 응답 → Member give-속성, constraint, 외부 인터페이스 노출 */
        satisfy 'context constraints viewpoint';
        expose ChapterStructure::Constraints::*;
        expose ChapterStructure::Stakeholders::Member::giveResource;
    }

    view SystemContextView {
        doc
        /* Base Architecture level System Context — Chapter(SoI)
         * 경계 및 외부 액터 5종(활성: ToolVendor, INCOSESector,
         * TechnicalOperations / 조건부-Phase 2: ChapterAffiliation
         * Sponsor, PeerSocietyOrganization)과의 포트/연결(connect)
         * 노출. 동일한 BoundaryDependencyConcern을 공유하므로 별도
         * 뷰포인트 신설 없이 ContextConstraintsViewpoint를 재사용.
         */
        satisfy 'context constraints viewpoint';
        expose SystemContext::*;
    }

    view OperationalView {
        doc
        /* 문항 15·16 응답 → ConOps 행위(Action)/아이템 흐름(Flow) 노출 */
        satisfy 'operational viewpoint';
        expose ChapterBehavior::ConOps::*;
    }

    view LifecycleEvolutionView {
        doc
        /* 문항 17 응답 → ChapterLifecycle 상태머신 노출 (Phase 2 정식화 예정) */
        satisfy 'lifecycle evolution viewpoint';
        expose ChapterBehavior::Lifecycle::*;
    }

    view KnowledgeAssetView {
        doc
        /* IT 플랫폼 선택 결과 → 정보흐름(ItemFlow) 및 저장 스키마 노출 */
        satisfy 'knowledge asset viewpoint';
        expose ChapterStructure::KnowledgeStore::*;
    }

    view RiskSecurityView {
        satisfy 'risk security viewpoint';
        doc
        /* 문항 18 응답 → 보안 규칙(Requirement) 세트 노출 */
        expose ChapterRequirements::SecurityRules::*;
    }

    view CapabilityValueView {
        doc
        /* 문항 19 응답 취합 결과 → Capability 정의 세트 노출 */
        satisfy 'capability Value Viewpoint';
        expose ChapterCapabilities::*;
    }
} // package Views
