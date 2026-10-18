package SystemContext {
    private import Stakeholders::*;
    private import ActorAndInterfaces::*;
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
        other;
    }
    enum def ArtifactCategoryKind {
        translatedArticle;
        sysmlDiagram;
        meetingMinutes;
        requirementRecord;
        referenceModelCode; // LV1 SysML v2 참조모델 코드
        assignmentGuide; // SE 과제 수행 실무 가이드
    }

    item def ChapterArtifact {
        attribute title : String;
        attribute category : ArtifactCategoryKind;
        attribute owner : String;
        attribute locationURL : String;
    }

    // LV1 참조모델 형상 및 보안 관리를 위한 전용 아티팩트 정의
    item def ReferenceModelArtifact :> ChapterArtifact {
        :>> category = ArtifactCategoryKind::referenceModelCode;
        attribute domainName : String; // 예: "Automotive SDV", "Space Mission"
        attribute modelVersion : String; // 예: "v0.2-BlackBox"
        attribute targetSoIName : String; // 예: "2035 도심 자율주행 PBV 셔틀 시스템"
        attribute isSecurityCleared : Boolean; // 사내 민감데이터 배제 및 가상값 치환 확인 여부
        attribute satisfiedMemberNeeds : String [0..*]; // 이 모델이 충족하는 회원 요구사항(MemberNeed)
    }

    part def KnowledgeRepository {
        doc
        /* Single Source of Truth. 플랫폼 확정 후 구체화 예정. */
        attribute platform : PlatformKind;
        part artifact : ChapterArtifact [0..*];
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

    part def KoreaChapter {
        doc
        /* SoI: INCOSE Korea Chapter. 
         * 내부에 회원(Member), 지식저장소(KnowledgeRepository) 뿐만 아니라
         * 타 학회와 차별화되는 고유 역량(capabilities)을 내재화하여 포함함.
         */
        attribute charterStatus : ChapterCharterStatusKind = ChapterCharterStatusKind::chartered;

        part member : Member [1..*];
        part repository : KnowledgeRepository;
        part capabilities : ChapterCapability [0..*];
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
        part globalStandardFastAdoption : ChapterCapability redefines capabilities {
            doc
            /* 예시 인스턴스 */
            attribute :>> descriptionText =
                "해외 SE 표준/트렌드의 빠른 국내 도입 및 영어 원문 해독 네트워크";
        }

        part handsOnToolPractice : ChapterCapability redefines capabilities {
            doc
            /* 예시 인스턴스 */
            attribute :>> descriptionText =
                "MBSE 툴(Cameo, SysML v2 등)을 직접 실습해볼 수 있는 유일한 채널";
        }
    }

    // ---- 3.4 통합 System Context Baseline ----
    part incoseKoreaChapterContext {
        doc
        /* 10월 킥오프 baseline 기준 System Context 인스턴스.
         * 3개는 활성 연결(Phase 1), 2개는 인스턴스 미생성 보류 상태(Phase 2).
         */
        part chapter : ChapterInContext;

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
} // package SystemContext
