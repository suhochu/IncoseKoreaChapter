package ChapterViews {
    private import ChapterViewpoints::*; // [개선] 중복 import 제거
    private import SysideViews::*;
    private import SysideViews::TableViewDefinitions::*;
    private import SysideViews::MatrixViewDefinitions::*;

    // =========================================================================
    // 1. 4대 기본 아키텍처 뷰 (8대 Concern 대상 모델 요소 전체 노출)
    // =========================================================================
    view AdministrativeOperationsView {
        doc
        /* [매핑 관심사: OperationalFlowConcern, KnowledgeAssetConcern, LifecycleEvolutionConcern]
         * 행정/운영 흐름(ConOps), 지식저장소(KnowledgeRepository), 스프린트 과제,
         * 워킹그룹 조직 및 수명주기(Lifecycle & 5대 MoE 게이트) 노출
         */
        satisfy 'administrative operations viewpoint';
        expose ChapterSystemContext::KnowledgeRepository;
        expose ChapterSystemContext::ReferenceModelArtifact;
        expose ChapterSystemContext::OperationalConstraintCheck;
        expose ChapterConOpsAndLifecycle::ConOps::*;
        expose ChapterConOpsAndLifecycle::Lifecycle::*;
        expose ChapterSprint::*;
        expose WorkingGroupsAndRoles::*;
        expose ChapterMetricsAndGuards::*;
        expose ActivityLogs_2026_Q4::*;
    }

    view MemberValueView {
        doc
        /* [매핑 관심사: StakeholderIdentificationConcern, ValueRationaleValidationConcern, RiskSecurityConcern]
         * 회원 속성(도메인, 관심사, 제공 자원), 회원별 가치 요구사항(Needs) 및 기업 보안 규칙(SecurityRules) 노출
         */
        satisfy 'member value viewpoint';
        expose ChapterMembersDirectory::*;
        expose MemberNeedsAndSecurityRules::ChapterMembers_Needs::*;
        expose MemberNeedsAndSecurityRules::SecurityRules::*;
    }

    view IncoseAlignmentView {
        doc
        /* [매핑 관심사: BoundaryDependencyConcern]
         * 외부 액터 중 INCOSESector, TechnicalOperations, ToolVendor와의 인터페이스 및 교환 아이템 노출
         */
        satisfy 'incose alignment viewpoint';
        expose ExternalActorsAndInterfaces::ContextToolVendor;
        expose ExternalActorsAndInterfaces::ContextINCOSESector;
        expose ExternalActorsAndInterfaces::ContextTechnicalOperations;
        expose ExternalActorsAndInterfaces::ToolLicenseInfoItem;
        expose ExternalActorsAndInterfaces::SectorActivityReportItem;
        expose ExternalActorsAndInterfaces::HandbookResourceItem;
    }

    view PeerSocietyConnectionView {
        doc
        /* [매핑 관심사: CapabilityValueConcern]
         * KOSSE, KCOSE 등 외부 학회 액터와의 인터페이스 및 챕터 고유 역량(ChapterCapability) 노출
         */
        satisfy 'peer society connection viewpoint';
        expose ExternalActorsAndInterfaces::ContextPeerSocietyOrganization;
        expose ExternalActorsAndInterfaces::PeerBenchmarkItem;
        expose StakeholderDefinitions::PeerSociety;
        expose ChapterSystemContext::ChapterCapability;
        expose ChapterSystemContext::ChapterInContext::globalStandardFastAdoption;
        expose ChapterSystemContext::ChapterInContext::handsOnToolPractice;
        expose ChapterSystemContext::ChapterInContext::domainReferenceModelCreation;
    }

    // =========================================================================
    // 2. SysideViews::TableView 기반 정형 데이터 모니터링 테이블 뷰
    // =========================================================================

    // (1) 회원별 GtWR 요구사항(What/Why/Validation) 일람표 뷰
    view MemberNeedsGtWRTableView : TableView {
        doc
        /* ValueRationaleValidationConcern 대응 테이블 뷰 */
        satisfy 'member value viewpoint';
        attribute :>> exposeFeaturesAndHeritage = true;
        expose MemberNeedsAndSecurityRules::ChapterMembers_Needs::*;

        view col_id :>> columnViews {
            attribute :>> featureToRender = ColumnType::declaredName;
            attribute :>> columnWidth = 180;
        }
        view col_what :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "coreValueWhat"; // [개선] ':>>' 재정의 문법 적용
            }
            attribute :>> columnWidth = 350;
        }
        view col_why :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "rationale";
            }
            attribute :>> columnWidth = 300;
        }
        view col_validation :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "validationCriterion";
            }
            attribute :>> columnWidth = 300;
        }
    }

    // (2) 챕터 5대 핵심 성과 지표(Core MoEs) 현황 모니터링 테이블 뷰
    view ChapterCoreMoEsTableView : TableView {
        doc
        /* LifecycleEvolutionConcern 대응: 챕터의 5대 핵심 성과 지표(Core MoEs) 현황 테이블 뷰.
         * [개선 포인트]
         * 1) exposeFeaturesAndHeritage = true 설정을 통해 상위 ChapterMoEsHolder로부터 상속받은
         *    5대 MoE 속성이 테이블 셀에 정상 렌더링되도록 보장함.
         * 2) expose 경로에서 incoseKoreaChapterContext 내의 chapter 파트를 노출하고,
         *    ColumnType::attributeValue 내부의 attributeName을 ':>>'로 정확히 재정의함.
         */
        satisfy 'administrative operations viewpoint';
        attribute :>> exposeFeaturesAndHeritage = true;
        expose ChapterSystemContext::incoseKoreaChapterContext::chapter;

        view col_name :>> columnViews {
            attribute :>> featureToRender = ColumnType::declaredName;
            attribute :>> columnWidth = 180;
        }
        view col_presentations :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "accumulatedPresentationsCount";
            }
            attribute :>> columnWidth = 160;
        }
        view col_refModels :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "completedReferenceModelsCount";
            }
            attribute :>> columnWidth = 160;
        }
        view col_aiSkills :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "developedAISkillsCount";
            }
            attribute :>> columnWidth = 160;
        }
        view col_activeMembers :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "regularActiveMembersCount";
            }
            attribute :>> columnWidth = 160;
        }
        view col_sepMembers :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "sepCertifiedMembersCount";
            }
            attribute :>> columnWidth = 160;
        }
    }

    // (3) KnowledgeAssetConcern 대응: 워킹그룹별 과제 제출물 및 게이트 통과 현황 테이블 뷰
    view AssignmentSubmissionStatusTableView : TableView {
        doc
        /* 워킹그룹별 과제 제출 상태 및 교수님 피드백·6대 Gate 통과 여부 모니터링 테이블 뷰 */
        satisfy 'administrative operations viewpoint';
        attribute :>> exposeFeaturesAndHeritage = true;
        expose ActivityLogs_2026_Q4::*;

        view col_submissionId :>> columnViews {
            attribute :>> featureToRender = ColumnType::declaredName;
            attribute :>> columnWidth = 220;
        }
        view col_wgName :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "workingGroupName";
            }
            attribute :>> columnWidth = 220;
        }
        view col_status :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "status";
            }
            attribute :>> columnWidth = 150;
        }
    }
} // package ChapterViews
