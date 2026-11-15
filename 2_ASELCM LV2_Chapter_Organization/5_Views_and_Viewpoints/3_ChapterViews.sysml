package ChapterViews {
    private import ChapterViewpoints::*;
    private import SysideViews::*;
    private import SysideViews::TableViewDefinitions::*;
    private import SysideViews::MatrixViewDefinitions::*;

    // TODO(확인 필요): 아래 TableView 열 정의는 'ColumnType::attributeValue { attributeName = "..."; }' 형태를 쓴다.
    //   ':>> attributeName = "..."' 로 바꾸면 Syside 0.10.x 에서 reference-error('No Feature named attributeName')가 발생하므로
    //   현재 표기를 유지한다. 다만 'syside table export' 결과의 셀 값이 비어 있는 것은 변경 전 모델에서도 동일했다
    //   (표기 문제인지 export 기능 한계인지 UI에서 확인 필요).

    // =========================================================================
    // 1. 기본 아키텍처 뷰 (Concern 대상 모델 요소 노출)
    // =========================================================================
    view AdministrativeOperationsView {
        doc
        /* [매핑 관심사: OperationalFlowConcern, KnowledgeAssetConcern, LifecycleEvolutionConcern]
         * 행정/운영 흐름(ConOps), 지식저장소(KnowledgeRepository), 스프린트 과제,
         * 워킹그룹 조직 및 수명주기(Lifecycle & MoE 게이트) 노출
         */
        satisfy 'administrative operations viewpoint';
        expose ChapterSystemContext::KnowledgeRepository;
        expose ChapterSystemContext::ReferenceModelArtifact;
        expose ChapterSystemContext::AISkillArtifact;
        expose ChapterSystemContext::OperationalConstraintCheck;
        expose ChapterConOpsAndLifecycle::ConOps::*;
        expose ChapterConOpsAndLifecycle::Lifecycle::*;
        expose ChapterSprint::*;
        expose WorkingGroupsAndRoles::*;
        expose ChapterMetricsAndGuards::*;
        expose SprintMeetings_2026_Q4::*;
        expose ModelingAssignments_and_Feedbacks::*;
        expose WG_Submissions_Tracker::*;
    }

    view MemberValueView {
        doc
        /* [매핑 관심사: StakeholderIdentificationConcern, ValueRationaleValidationConcern, RiskSecurityConcern]
         * 회원 속성 정의, 회원 집합, 회원별 가치 요구사항(Needs) 및 기업 보안 규칙(SecurityRules) 노출.
         * 회원 디렉터리 패키지 전체(::*)는 개인별 usage까지 모두 펼쳐지므로 expose하지 않고 필요한 요소만 노출한다.
         * TODO(확인 필요): chapterMemberRoster 를 expose 했을 때 subset 된 개별 회원이 렌더링되는지 확인.
         */
        satisfy 'member value viewpoint';
        expose StakeholderDefinitions::IncoseKoreaChapterMember;
        expose ChapterMembersDirectory::chapterMemberRoster;
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
        expose StakeholderDefinitions::PeerSocietyMember;
        expose ChapterSystemContext::ChapterCapability;
        expose ChapterSystemContext::ChapterInContext::globalStandardFastAdoption;
        expose ChapterSystemContext::ChapterInContext::handsOnToolPractice;
        expose ChapterSystemContext::ChapterInContext::domainReferenceModelCreation;
    }

    view GovernanceQualityView {
        doc
        /* [매핑 관심사: GovernanceQualityConcern]
         * LV3 거버넌스 시스템, 품질 게이트(Feedback/Gate/Maturity), 모델링 규약과 정책,
         * 그리고 워킹그룹 제출 스키마 및 제출 현황 노출
         */
        satisfy 'governance and quality viewpoint';
        expose GovernanceSystemAndTooling::GovernanceSystem::*;
        expose QualityGatesAndReviewProcess::*;
        expose ModelingConventionsAndPolicies::ModelingConventions::*;
        expose ModelingConventionsAndPolicies::PolicyAndDirectives::*;
        expose ChapterSprint::AssignmentSubmission;
        expose WG_Submissions_Tracker::*;
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
                attributeName = "coreValueWhat";
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

    // (2) 챕터 핵심 성과 지표(Core MoEs) 현황 모니터링 테이블 뷰
    view ChapterCoreMoEsTableView : TableView {
        doc
        /* LifecycleEvolutionConcern 대응: 챕터의 핵심 성과 지표(Core MoEs) 현황 테이블 뷰.
         * 1) exposeFeaturesAndHeritage = true 설정을 통해 상위 ChapterMoEsHolder로부터 상속받은
         *    MoE 속성이 테이블 셀에 렌더링되도록 한다.
         * 2) expose 경로에서 incoseKoreaChapterContext 내의 chapter 파트를 노출하고,
         *    ColumnType::attributeValue 내부의 attributeName을 지정한다.
         * TODO(확인 필요): 참조모델 수(completedReferenceModelsCount)와 AI Skills 수(developedAISkillsCount)는
         *   repository 크기에서 파생되므로 UI에서 직접 편집할 수 없다. 수동 입력이 필요하면 KoreaChapter에서
         *   '수동 입력 + 일치 여부 assert' 방식으로 되돌린다.
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

    // (3) KnowledgeAssetConcern 대응: 워킹그룹별 과제 제출물 및 제출 상태 테이블 뷰
    view AssignmentSubmissionStatusTableView : TableView {
        doc
        /* WG_Submissions_Tracker 패키지만 단독으로 expose하여
         * 워킹그룹별 제출 usage를 행으로 표시한다. 새 WG 제출 usage를 추가하면 행이 자동으로 늘어난다.
         * TODO(확인 필요): workingGroup 은 attribute가 아닌 ref 이므로 namedFeatureValue 열로 표시했다.
         *   값이 보이지 않으면 WorkingGroup.wgName 을 표시하는 파생 attribute 추가를 검토한다.
         */
        satisfy 'administrative operations viewpoint';
        attribute :>> exposeFeaturesAndHeritage = true;
        expose WG_Submissions_Tracker::*;

        view col_submissionId :>> columnViews {
            attribute :>> featureToRender = ColumnType::declaredName;
            attribute :>> columnWidth = 220;
        }
        view col_workingGroup :>> columnViews {
            attribute :>> featureToRender = ColumnType::namedFeatureValue {
                featureName = "workingGroup";
            }
            attribute :>> columnWidth = 240;
        }
        view col_status :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "status";
            }
            attribute :>> columnWidth = 150;
        }
    }

    // (4) GovernanceQualityConcern 대응: 제출물별 게이트 현황 테이블 뷰
    view AssignmentGateStatusTableView : TableView {
        doc
        /* 워킹그룹 제출물의 통합 게이트 판정 결과(isGatePassed)와 제출 상태(status)를 함께 보여 준다.
         * 상태와 게이트 결과의 모순은 AssignmentSubmission.statusGateConsistency 가 검사한다.
         *
         * TODO(확인 필요): checklist 는 중첩 속성(AssignmentGateChecklist)이라 Syside TableView에서
         *   개별 항목(예: checklist.isIndependentWholeSystem)을 열로 표시할 수 있는지 확인되지 않았다.
         *   표시할 수 없으면 대안:
         *   1) AssignmentSubmission에 필요한 항목만 파생 attribute로 노출(예: isGatePassed 처럼 한 줄 파생),
         *   2) AssignmentGateChecklist 인스턴스를 별도 행(expose)으로 두고 열을 속성 이름으로 구성,
         *   3) MatrixView로 제출물(행) x Gate constraint(열) 매트릭스를 구성.
         */
        satisfy 'governance and quality viewpoint';
        attribute :>> exposeFeaturesAndHeritage = true;
        expose WG_Submissions_Tracker::*;

        view col_submissionId :>> columnViews {
            attribute :>> featureToRender = ColumnType::declaredName;
            attribute :>> columnWidth = 220;
        }
        view col_status :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "status";
            }
            attribute :>> columnWidth = 150;
        }
        view col_isGatePassed :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "isGatePassed";
            }
            attribute :>> columnWidth = 150;
        }
        view col_checklist :>> columnViews {
            attribute :>> featureToRender = ColumnType::attributeValue {
                attributeName = "checklist";
            }
            attribute :>> columnWidth = 300;
        }
    }
} // package ChapterViews
