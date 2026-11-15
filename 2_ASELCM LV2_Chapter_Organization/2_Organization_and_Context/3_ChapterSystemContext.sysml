package ChapterSystemContext {
    private import ScalarValues::*;
    private import SequenceFunctions::*;
    private import StakeholderDefinitions::*;
    private import ExternalActorsAndInterfaces::*;
    private import ChapterMetricsAndGuards::*;
    private import ChapterMembersDirectory::*;
    private import GovernanceSystemAndTooling::GovernanceInterfaces::*;

    // ---- 3.1 조직 제약사항 (응답 취합용 데이터 구조) ----
    attribute def OperationalConstraintCheck {
        doc
        /* "개인 제약" 응답 취합용. C10(세트의 완전성) 근거자료. */
        attribute constraintText : String;
    }

    attribute def ExternalDependencyCheck {
        doc
        /* "외부 의존성/전제조건" 응답 취합용. */
        attribute dependencyText : String;
    }

    // ---- 3.2 지식 저장소 (Knowledge Repository) ----
    enum def ArtifactCategoryKind {
        translatedArticle;
        sysmlDiagram;
        meetingMinutes; // 1. Meeting
        memberSurveyRecord; // 2. Member Info
        memoryArchiveRecord; // 3. Memory Archive
        toolGuideAndConfig; // 4. Tools
        methodologyReference; // 5. Architecture Methodologies & 7. Source
        referenceModelCode; // 6. Projects/1. Domains
        assignmentGuide; // 6. Projects/2. references
        aiSkillPromptAndWorkflow; // 6. Projects/3. AI Skills
        advisoryFeedbackRecord;
    }

    // 실제 Google Drive / GitHub 폴더 구조를 표현하는 디렉터리 정의
    part def DirectoryFolder {
        doc
        /* relativePath는 literal로 직접 입력하지 않고 folderName 과 상위 폴더의 relativePath 에서 파생한다.
         * 최상위 폴더는 기본값(folderName)을 그대로 쓰고,
         * 하위 폴더 usage는 ':> subFolders' 와 함께 ':>> relativePath = <상위 폴더>.relativePath + "/" + folderName' 로 재정의한다.
         * 검증: 문자열 연결('+')은 Syside check 와 정적 평가(Python Compiler.evaluate_feature) 모두에서 동작한다
         *   (예: dom1_Aerospace.relativePath == "6. Projects/1. Domains/1. Aerospace").
         * TODO(확인 필요): 하위 폴더 usage에서 상위 폴더 참조(<상위>.relativePath)를 빠뜨려도 오류가 나지 않으므로,
         *   폴더를 추가할 때 relativePath 재정의 누락을 리뷰에서 확인해야 한다.
         */
        attribute folderName : String;
        attribute relativePath : String default folderName;
        part subFolders : DirectoryFolder [0..*];
    }

    item def ChapterArtifact {
        attribute title : String;
        attribute category : ArtifactCategoryKind;
        ref owner : IncoseKoreaChapterMember [0..*];
        attribute locationURL : String [0..1]; // 외부 URL(Drive 링크 등). 저장소 내 경로는 folder.relativePath 를 사용
        ref folder : DirectoryFolder [0..1]; // 저장 폴더. 경로 문자열은 folder.relativePath 에서만 얻는다.
    }

    // LV1 참조모델 과제 산출물 및 버전·보안·게이트 승인 상태를 관리하는 전용 아티팩트
    item def ReferenceModelArtifact :> ChapterArtifact {
        doc
        /* 각 워킹그룹이 LV1 공통 스캐폴드(LV1_BlackBox_ConOps_Scaffold)를
         * 상속받아 작성한 도메인 참조모델 산출물 메타데이터.
         * domain, targetSoIName, folder, owner 는 제출 건(AssignmentSubmission)이 WorkingGroup에서 파생해 채운다.
         */
        :>> category = ArtifactCategoryKind::referenceModelCode;

        attribute domain : DomainKind [0..*]; // WorkingGroup.domain 에서 파생
        attribute targetSoIName : String; // Whole-System 대상시스템(SoI) 명칭. WorkingGroup.targetSystemScope 에서 파생
        attribute modelVersion : String; // 예: "v0.1-Scaffold", "v0.2-BlackBox-ConOps"
        attribute modelFilePath : String [0..1]; // LV1 참조모델 패키지 경로. WorkingGroup.targetSysmlPackagePath 에서 파생

        // LV3 거버넌스 정책 및 게이트 준수 상태
        attribute inheritsCommonScaffold : Boolean default true; // 공통 스캐폴드 상속 여부
        attribute isSecurityCleared : Boolean default false; // 사내 민감데이터 배제 및 가상값 치환 완료 여부
        attribute isGateApproved : Boolean; // 직접 입력 금지: AssignmentSubmission.gateCheck 결과에서 파생
    }

    // [6. Projects/3. AI Skills] AI 아키텍팅 프롬프트 및 워크플로우 아티팩트 (MoE와 직결)
    item def AISkillArtifact :> ChapterArtifact {
        doc
        /* '6. Projects/3. AI Skills' 폴더에 축적되는 단계별 AI 프롬프트 및 자동화 스킬 자산.
         * KoreaChapter의 developedAISkillsCount 는 KnowledgeRepository.registeredAISkills 크기로 산출된다.
         */
        :>> category = ArtifactCategoryKind::aiSkillPromptAndWorkflow;

        attribute targetSEPhase : String; // 예: "PESTEL-CTIMMRA 분석", "DoDAF OV-1/OV-5b 생성", "SysML v2 변환"
        attribute targetToolOrLLM : String [0..1]; // 예: "Gemini / Claude / SE-Labs AI"
    }

    part def KnowledgeRepository {
        doc
        /* Single Source of Truth (Google Workspace & GitHub).
         * 실제 챕터 저장소의 루트 폴더 및 하위 프로젝트/도메인 폴더 트리를 그대로 반영함.
         */
        attribute platform : ITPlatformKind [1..*] = (
            ITPlatformKind::googleWorkspace, ITPlatformKind::github, ITPlatformKind::seLabsAI,
        );

        // ---- 실제 Repo 디렉터리 트리 구조화 (relativePath는 folderName 및 상위 폴더 경로에서 파생) ----
        part folder1_Meeting : DirectoryFolder {
            :>> folderName = "1. Meeting";
        }
        part folder2_MemberInfo : DirectoryFolder {
            :>> folderName = "2. Member Info";
        }
        part folder3_MemoryArchive : DirectoryFolder {
            :>> folderName = "3. Memory Archive";
        }
        part folder4_Tools : DirectoryFolder {
            :>> folderName = "4. Tools";
        }
        part folder5_ArchitectureMethodologies : DirectoryFolder {
            :>> folderName = "5. Architecture Methodologies";
        }
        part folder6_Projects : DirectoryFolder {
            :>> folderName = "6. Projects";

            part sub1_Domains : DirectoryFolder :> subFolders {
                :>> folderName = "1. Domains";
                :>> relativePath = folder6_Projects.relativePath + "/" + folderName;

                part dom1_Aerospace : DirectoryFolder :> subFolders {
                    :>> folderName = "1. Aerospace";
                    :>> relativePath = sub1_Domains.relativePath + "/" + folderName;
                }
                part dom2_Automotive : DirectoryFolder :> subFolders {
                    :>> folderName = "2. Automotive";
                    :>> relativePath = sub1_Domains.relativePath + "/" + folderName;
                }
                part dom3_IT : DirectoryFolder :> subFolders {
                    :>> folderName = "3. IT";
                    :>> relativePath = sub1_Domains.relativePath + "/" + folderName;
                }
                part dom4_Semiconductor : DirectoryFolder :> subFolders {
                    :>> folderName = "4. Semiconductor";
                    :>> relativePath = sub1_Domains.relativePath + "/" + folderName;
                }
            }
            part sub2_References : DirectoryFolder :> subFolders {
                :>> folderName = "2. references";
                :>> relativePath = folder6_Projects.relativePath + "/" + folderName;
            }
            part sub3_AISkills : DirectoryFolder :> subFolders {
                :>> folderName = "3. AI Skills";
                :>> relativePath = folder6_Projects.relativePath + "/" + folderName;
            }
        }
        part folder7_Source : DirectoryFolder {
            :>> folderName = "7. Source";
        }

        // ---- 저장소 관리 아티팩트 컬렉션 ----
        item artifact : ChapterArtifact [0..*];
        item approvedReferenceModels : ReferenceModelArtifact [0..*] :> artifact;
        item registeredAISkills : AISkillArtifact [0..*] :> artifact {
            ref :>> folder = folder6_Projects.sub3_AISkills;
        }
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

    part def KoreaChapter :> ChapterMoEsHolder {
        doc
        /* SoI: INCOSE Korea Chapter.
         * 내부에 회원(Member), 지식저장소(KnowledgeRepository) 뿐만 아니라
         * 타 학회와 차별화되는 고유 역량(capabilities)을 내재화하여 포함함.
         * ChapterMoEsHolder를 상속받아 핵심 MoE를 내재화하고 Phase 전환 제약을 평가함.
         */
        // TODO(확인 필요): Phase 1(온라인 스터디 단계)에서 charterStatus가 chartered가 맞는지 확인.
        //   INCOSE Board 최소 요건을 충족하기 전이라면 emerging이어야 한다.
        attribute charterStatus : ChapterCharterStatusKind = ChapterCharterStatusKind::chartered;

        ref part member : Member [1..*]; // 구체 회원 목록은 context usage에서 바인딩
        part repository : KnowledgeRepository;
        part capabilities : ChapterCapability [0..*];

        // MoE 자동 산출: 저장소 컬렉션의 크기에서 파생 (수동 입력 금지)
        // TODO(확인 필요): SequenceFunctions::size 는 Syside check 를 통과한다(import SequenceFunctions::*).
        //   다만 Syside 정적 평가(Python Compiler.evaluate_feature)는 컬렉션 feature 참조를 값 1개로 세어
        //   빈 컬렉션도 1로 평가한다. 인스턴스를 가진 실행/시뮬레이션 수준에서만 정확한 개수가 나온다.
        //   TableView에서 값을 직접 편집하는 방식과 충돌하거나 정적 평가값이 문제가 되면,
        //   수동 입력 + 'size(...) == count' 일치 여부 assert 로 대체한다.
        attribute :>> completedReferenceModelsCount = size(repository.approvedReferenceModels);
        attribute :>> developedAISkillsCount = size(repository.registeredAISkills);
    }

    part def ChapterInContext :> KoreaChapter {
        doc
        /* Base Architecture 단계에서 외부 컨텍스트 포트가 추가된 Chapter */
        port toolInterface : ChapterToolInterfacePort;
        port sectorInterface : ChapterSectorInterfacePort;
        port techOpsInterface : ChapterTechOpsInterfacePort;
        port sponsorInterface : ChapterSponsorInterfacePort [0..1];
        port peerInterface : ChapterPeerInterfacePort [0..1];
        port governanceInterface : ~GovernanceInterfacePort; // LV3 거버넌스 시스템과의 켤레 포트

        // 역량 인스턴스 구체화
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
            /* Do-Tank 핵심 역량: 도메인별 실무형 SysML v2 참조모델 자체 개발 */
            attribute :>> descriptionText =
                "운용개념(ConOps) 및 블랙박스 정의부터 아키텍처·시뮬레이션까지 이어지는 도메인 참조모델 공동 구축";
        }
    }

    // ---- 3.5 통합 System Context Baseline ----
    part incoseKoreaChapterContext {
        doc
        /* 킥오프 baseline 기준 System Context 인스턴스.
         * Phase 1에서 활성 연결되는 외부 액터와, 인스턴스 연결이 보류된 외부 액터(Phase 2 이후)로 구성된다.
         */
        part chapter : ChapterInContext {
            doc
            /* [SysideViews::TableView 호환성]
             * ChapterCoreMoEsTableView에서 ColumnType::attributeValue를 통해 현재 실측값을
             * 바로 표시하고 UI에서 편집할 수 있도록 수동 입력 MoE 속성을 명시적으로 재정의(:>>)함.
             * 참조모델 수와 AI Skills 수는 KoreaChapter에서 repository 크기로 파생되므로 여기서 다시 입력하지 않는다.
             */
            ref :>> member = chapterMemberRoster;

            attribute :>> accumulatedPresentationsCount = 1;
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

        // Phase 2 이후 (보류 - [0..1] 인스턴스화 이후 연결)
        // connect chapter.sponsorInterface to sponsor.sponsorInterfaceOut;
        // connect chapter.peerInterface to peerSociety.peerOrgInterfaceOut;
    }
} // package ChapterSystemContext

