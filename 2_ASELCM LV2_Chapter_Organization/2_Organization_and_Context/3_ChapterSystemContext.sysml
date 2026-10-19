package ChapterSystemContext {
    private import StakeholderDefinitions::*;
    private import ExternalActorsAndInterfaces::*;
    private import ScalarValues::*;

    // ---- 3.1 조직 제약사항 (Constraints) ----
    constraint def OperationalConstraintCheck {
        doc
        /* "개인 제약" 응답 취합용. C10(세트의 완전성) 근거자료. */
        attribute constraintText : String;
    }

    constraint def ExternalDependencyCheck {
        doc
        /* "외부 의존성/전제조건" 응답 취합용. */
        attribute dependencyText : String;
    }

    // ---- 3.2 지식 저장소 (Knowledge Repository) ----
    enum def PlatformKind {
        notion;
        slackOrDiscord;
        googleWorkspace;
        github;
        other;
    }
    enum def ArtifactCategoryKind {
        translatedArticle;
        sysmlDiagram;
        meetingMinutes;
        requirementRecord;
        referenceModelCode; // 3_ASELCM_LV1_Target_Reference_Models 참조모델 코드
        assignmentGuide; // SE 과제 수행 실무 가이드 문서
        advisoryFeedbackRecord; // 학술자문단(교수진) 모델 리뷰 및 피드백 기록
    }

    item def ChapterArtifact {
        attribute title : String;
        attribute category : ArtifactCategoryKind;
        attribute owner : String;
        attribute locationURL : String;
    }

    // LV1 참조모델 과제 산출물 및 버전·보안·게이트 승인 상태를 관리하는 전용 아티팩트
    item def ReferenceModelArtifact :> ChapterArtifact {
        doc
        /* 각 워킹그룹이 LV1 공통 스캐폴드(LV1_BlackBox_ConOps_Scaffold)를 
         * 상속받아 작성한 도메인 참조모델 산출물 메타데이터.
         */
        :>> category = ArtifactCategoryKind::referenceModelCode;

        attribute domainName : String; // 예: "Automotive SDV", "Space Mission System"
        attribute targetSoIName : String; // Whole-System 대상시스템(SoI) 명칭
        attribute modelVersion : String; // 예: "v0.1-Scaffold", "v0.2-BlackBox-ConOps"
        attribute modelFilePath : String [0..1]; // 3_ASELCM_LV1_Target_Reference_Models 내 경로

        // LV3 거버넌스(Governance.sysml) 정책 및 게이트 준수 상태 플래그
        attribute inheritsCommonScaffold : Boolean default true; // 공통 스캐폴드 상속 여부
        attribute isSecurityCleared : Boolean default false; // 사내 민감데이터 배제 및 가상값 치환 완료 여부
        attribute isGateApproved : Boolean default false; // 교수님 피드백 3종 + 6대 Gate 통과 여부
    }

    part def KnowledgeRepository {
        doc
        /* Single Source of Truth (Google Workspace & GitHub).
         * 일반 문헌/회의록뿐만 아니라 검증을 통과한 LV1 참조모델 Baseline을 통합 관리함.
         */
        attribute platform : PlatformKind [1..*];
        part artifact : ChapterArtifact [0..*];

        // 게이트 심사를 통과하여 정식 등록된 LV1 참조모델 목록 (Lifecycle 전환 평가 기준)
        part approvedReferenceModels : ReferenceModelArtifact [0..*] :> artifact;
    }

    // ---- 3.3 Chapter Capability (챕터 고유 역량) ----
    part def ChapterCapability {
        doc
        /* KOSSE/KCOSE 등 동위 시스템(Peer System) 대비 챕터 고유 역량 */
        attribute descriptionText : String;
    }

    // ---- 3.4 System of Interest 정의 ----
    enum def ChapterCharterStatusKind {
        emerging; // INCOSE Board 최소 요건 미충족
        chartered; // 인가된 상태
    }

    part def KoreaChapter :> ChapterMetricsAndGuards::ChapterMoEsHolder {
        doc
        /* SoI: INCOSE Korea Chapter. 
         * 내부에 회원(Member), 지식저장소(KnowledgeRepository) 뿐만 아니라
         * 타 학회와 차별화되는 고유 역량(capabilities)을 내재화하여 포함함.
         * ChapterMoEsHolder를 상속받아 5대 핵심 MoE를 내재화하고 Phase 전환 제약을 평가함.
         */
        attribute charterStatus : ChapterCharterStatusKind = ChapterCharterStatusKind::chartered;

        part member : Member [1..*];
        part repository : KnowledgeRepository;
        part capabilities : ChapterCapability [0..*];

        // Phase 1 -> Phase 2 전환 조건 수식 바인딩
        constraint phase1To2GateCheck : ChapterMetricsAndGuards::Phase1ToPhase2GateConstraint {
            in presentations = accumulatedPresentationsCount;
            in refModels = completedReferenceModelsCount;
            in aiSkills = developedAISkillsCount;
            in activeMembers = regularActiveMembersCount;
            in sepMembers = sepCertifiedMembersCount;
        }

        // Phase 2 -> Phase 3 전환 조건 수식 바인딩
        constraint phase2To3GateCheck : ChapterMetricsAndGuards::Phase2ToPhase3GateConstraint {
            in presentations = accumulatedPresentationsCount;
            in activeMembers = regularActiveMembersCount;
            in sepMembers = sepCertifiedMembersCount;
            in aiSkills = developedAISkillsCount;
            in refModels = completedReferenceModelsCount;
        }
    }

    part def ChapterInContext :> KoreaChapter {
        doc
        /* Base Architecture 단계에서 외부 컨텍스트 포트 5종이 추가된 Chapter */
        port toolInterface : ChapterToolInterfacePort;
        port sectorInterface : ChapterSectorInterfacePort;
        port techOpsInterface : ChapterTechOpsInterfacePort;
        port sponsorInterface : ChapterSponsorInterfacePort [0..1];
        port peerInterface : ChapterPeerInterfacePort [0..1];

        // 2) 역량 인스턴스 구체화 (ChapterCapabilities 파일 내용 병합)
        part globalStandardFastAdoption : ChapterCapability :> capabilities {
            doc
            /* 예시 인스턴스 */
            attribute :>> descriptionText =
                "해외 SE 표준/트렌드의 빠른 국내 도입 및 영어 원문 해독 네트워크";
        }

        part handsOnToolPractice : ChapterCapability :> capabilities {
            doc
            /* 예시 인스턴스 */
            attribute :>> descriptionText =
                "MBSE 툴(Cameo, SysML v2 등)을 직접 실습해볼 수 있는 유일한 채널";
        }

        part domainReferenceModelCreation : ChapterCapability :> capabilities {
            doc
            /* [추가] Do-Tank 핵심 역량: 도메인별 실무형 SysML v2 참조모델 자체 개발 */
            attribute :>> descriptionText =
                "운용개념(ConOps) 및 블랙박스 정의부터 아키텍처·시뮬레이션까지 이어지는 도메인 참조모델 공동 구축";
        }
    }

    // ---- 3.5 통합 System Context Baseline ----
    part incoseKoreaChapterContext {
        doc
        /* 10월 킥오프 baseline 기준 System Context 인스턴스.
         * 3개는 활성 연결(Phase 1), 2개는 인스턴스 미생성 보류 상태(Phase 2).
         */
        part chapter : ChapterInContext {
            doc
            /* [SysideViews::TableView 호환성 개선]
             * ChapterCoreMoEsTableView에서 ColumnType::attributeValue를 통해 현재 실측값을
             * 바로 표시하고 UI에서 편집할 수 있도록 5대 핵심 MoE 속성을 명시적으로 재정의(:>>)함.
             */
            attribute :>> accumulatedPresentationsCount = 1;
            attribute :>> completedReferenceModelsCount = 0;
            attribute :>> developedAISkillsCount = 0;
            attribute :>> regularActiveMembersCount = 12;
            attribute :>> sepCertifiedMembersCount = 1;
        }

        part cameoVendor : ContextToolVendor;
        part incoseSector : ContextINCOSESector;
        part technicalOperations : ContextTechnicalOperations;
        part sponsor : ContextChapterAffiliationSponsor [0..1];
        part peerSociety : ContextPeerSocietyOrganization [0..1];

        // Phase 1 (활성 연결)
        connect chapter.toolInterface to cameoVendor.vendorInterface;
        connect chapter.sectorInterface to incoseSector.sectorInterfaceOut;
        connect chapter.techOpsInterface to technicalOperations.techOpsInterfaceOut;

        // Phase 2 (보류 - [0..1] 인스턴스화 이후 연결)
        // connect chapter.sponsorInterface to sponsor.sponsorInterfaceOut;
        // connect chapter.peerInterface to peerSociety.peerOrgInterfaceOut;
    }
} // package ChapterSystemContext
