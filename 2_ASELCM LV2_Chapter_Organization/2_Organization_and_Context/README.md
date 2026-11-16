#### [2-2] 조직 및 시스템 컨텍스트 (`2_Organization_and_Context/`)

##### 파일 8. `2_ASELCM LV2_Chapter_Organization/2_Organization_and_Context/1_ExternalActorsAndInterfaces.sysml`

- **패키지명**: `ExternalActorsAndInterfaces`
- **역할 및 목적**: 챕터 외부 환경(Context)에 존재하는 5대 외부 액터와 교환 아이템, 그리고 챕터 기준 경계 포트를 정의합니다.
- **주요 정의 및 구성요소**:

| 외부 액터 (`part def`)                 | 역할 설명                                    | 기준 포트 (`Chapter` 측)      | 액터 포트 (`~` 켤레 포트)      | 교환 아이템 (`item def`) 및 방향 (`Chapter` 기준)     |    Phase 1 연결 상태    |
| :------------------------------------- | :------------------------------------------- | :---------------------------- | :----------------------------- | :---------------------------------------------------- | :---------------------: |
| **`ContextToolVendor`**                | Cameo 등 MBSE 상용 툴 벤더                   | `ChapterToolInterfacePort`    | `~ChapterToolInterfacePort`    | `in ToolLicenseInfoItem` (툴명, 라이선스 상태)        |      **활성 연결**      |
| **`ContextINCOSESector`**              | INCOSE Asia-Oceania Sector (Sector III)      | `ChapterSectorInterfacePort`  | `~ChapterSectorInterfacePort`  | `out SectorActivityReportItem` (기간, 활동 요약 보고) |      **활성 연결**      |
| **`ContextTechnicalOperations`**       | INCOSE TechOps (WG 총괄 및 SE Handbook 배포) | `ChapterTechOpsInterfacePort` | `~ChapterTechOpsInterfacePort` | `in HandbookResourceItem` (출판물 제목, 버전)         |      **활성 연결**      |
| **`ContextChapterAffiliationSponsor`** | 계약 기반 후원 기업/조직 (CAS)               | `ChapterSponsorInterfacePort` | `~ChapterSponsorInterfacePort` | `in SponsorshipItem` (후원사명, 지원 유형)            | Phase 2 보류 (`[0..1]`) |
| **`ContextPeerSocietyOrganization`**   | 국내 타 SE 학회 (KOSSE, KCOSE 등)            | `ChapterPeerInterfacePort`    | `~ChapterPeerInterfacePort`    | `in/out PeerBenchmarkItem` (주제, 비교 노트)          | Phase 2 보류 (`[0..1]`) |

---

##### 파일 9. `2_ASELCM LV2_Chapter_Organization/2_Organization_and_Context/2_StakeholderDefinitions.sysml`

- **패키지명**: `StakeholderDefinitions`
- **역할 및 목적**: 챕터 내부 구성원인 회원(`Member`, `IncoseKoreaChapterMember`)과 타 학회 회원(`PeerSocietyMember`)의 데이터 스키마 및 분류용 열거형(`enum def`)을 정의합니다. 특히 2차 설문 문항을 **INCOSE GtWR v4(Guide to Writing Requirements)의 요구사항 품질 특성(C1~C9)**에 1:1로 매핑해 설계한 점이 핵심입니다.
- **주요 정의 및 구성요소**:
  - **분류 열거형 (`enum def`)**:
    - `GiveResourceKind`: 회원이 기여 가능한 자원 (`knowledgeSharing`, `operationsSupport`, `toolExpertise`, `networking`, `other`).
    - `PeerSocietyKind`: 국내 타 학회 구분 (`kosse`, `kcose`, `other`).
    - `DomainKind`: 8대 산업 도메인 (`defenseAndAerospace`, `automotiveAndMobility`, `railInfrastructureAndEnergy`, `biomedicalAndHealthcare`, `itAndSoftware`, `semiconductor`, `academiaAndResearch`, `other`).
    - `RegionKind`: 9대 거주/활동 권역 (`seoul`, `gyeonggiIncheon`, `daejeonSejongChungcheong`, `daeguGyeongbuk`, `busanUlsanGyeongnam` 등).
    - `OnlineExchangeKind`: 선호 온라인 교류 방식 (`seminar`, `caseStudy`, `projectLab`, `onlineReview`, `literatureReading`, `other`).
    - `ITPlatformKind`: 협업 플랫폼 (`notion`, `slackDiscord`, `googleWorkspace`, `github`, `seLabsAI`, `other`).
    - `SecurityRuleKind`: 기업 정보보안 규칙 (`anonymizeData`, `noCompanyProjectNames`, `internalOnly`, `noRecording`, `none`, `other`).
  - **회원 파트 정의 (`part def`)**:
    - `Member`: 설문 1 기본 인적 사항(`affiliation`, `position`, `region`, `domain`, `preferredActivity`, `expectation`). 개인정보 보호를 위해 이메일과 전화번호는 모델에서 제외되었습니다.
    - `PeerSocietyMember :> Member`: 타 학회 소속 회원 (`affiliatedSociety : PeerSocietyKind`).
    - `IncoseKoreaChapterMember :> Member`: 설문 2의 응답을 GtWR 특성에 맞춰 구조화한 핵심 엔티티입니다:
      - **GtWR C2 (Appropriate)**: `interestKeyword` (관심 키워드 최대 3개)
      - **GtWR C1, C3, C5, C9 (What)**: `coreValueWhat` (챕터에서 얻고 싶은 기능적 요구사항)
      - **GtWR C8 (Correct - Rationale)**: `rationale` (요구사항 도출 배경 및 이유)
      - **GtWR C7 (Verifiable - Validation)**: `validationCriterion` (달성 여부 확인 기준)
      - **Priority**: `priority` (우선순위)
      - **GtWR C6 (Feasible)**: `giveResource`, `giveDetail` (기여 가능한 가용 자원)
      - **GtWR C4 (Complete)**: `operationalConstraint` (개인 운영 제약조건)
      - **생태계/운영 속성**: `externalDependency`, `preferredOnlineExchange`, `preferredITPlatform`, `lifecycleTransitionCondition`, `securityRule`, `securityRuleOther`
      - **GtWR C1 (Necessary)**: `uniqueCapability` (챕터만의 고유 가치)

---

##### 파일 10. `2_ASELCM LV2_Chapter_Organization/2_Organization_and_Context/3_ChapterSystemContext.sysml`

- **패키지명**: `ChapterSystemContext`
- **역할 및 목적**: 실제 Google Drive 및 GitHub 저장소의 폴더 트리를 그대로 모델링한 단일 진실 공급원(`KnowledgeRepository`), 대상 시스템인 `KoreaChapter` 및 컨텍스트 포트가 결합된 `ChapterInContext`, 그리고 킥오프 베이스라인 시스템 컨텍스트 인스턴스(`incoseKoreaChapterContext`)를 정의합니다.
- **주요 정의 및 구성요소**:
  - **지식 저장소 및 아티팩트 체계 (`3.2 Knowledge Repository`)**:
    - `enum def ArtifactCategoryKind`: 회의록(`meetingMinutes`), 회원설문(`memberSurveyRecord`), 참조모델 코드(`referenceModelCode`), 과제 가이드(`assignmentGuide`), AI 스킬(`aiSkillPromptAndWorkflow`) 등 11종 분류.
    - `part def DirectoryFolder`: `folderName`과 상위 폴더의 `relativePath`를 문자열 연결(`+ "/" +`)로 조합해 전체 상대경로를 자동 파생합니다.
    - `item def ChapterArtifact` 및 하위 특수 아티팩트:
      - `ReferenceModelArtifact :> ChapterArtifact`: 워킹그룹 제출 도메인 참조모델 메타데이터(`domain`, `targetSoIName`, `modelVersion`, `modelFilePath`, `inheritsCommonScaffold`, `isSecurityCleared`, `isGateApproved`).
      - `AISkillArtifact :> ChapterArtifact`: `'6. Projects/3. AI Skills'` 폴더에 저장되는 AI 프롬프트 및 자동화 워크플로우 자산.
    - `part def KnowledgeRepository`: 실제 챕터 저장소의 7대 루트 폴더(`1. Meeting` ~ `7. Source`)와 `6. Projects` 하위 트리(`1. Domains` -> `1. Aerospace`, `2. Automotive`, `3. IT`, `4. Semiconductor`, `2. references`, `3. AI Skills`)를 정확히 미러링합니다.
  - **대상 시스템 (`KoreaChapter` & `ChapterInContext`)**:
    - `part def KoreaChapter :> ChapterMoEsHolder`:
      - 회원 목록(`ref part member`), 저장소(`part repository : KnowledgeRepository`), 고유 역량(`part capabilities : ChapterCapability [0..*]`)을 포함합니다.
      - **MoE 자동 계산**: `completedReferenceModelsCount = size(repository.approvedReferenceModels)` 및 `developedAISkillsCount = size(repository.registeredAISkills)`를 통해 저장소에 등록된 아이템 개수로 지표를 자동 파생합니다.
    - `part def ChapterInContext :> KoreaChapter`:
      - 5개 외부 액터 포트와 LV3 거버넌스 켤레 포트(`port governanceInterface : ~GovernanceInterfacePort`)를 추가합니다.
      - 3대 고유 역량 인스턴스를 내장합니다: ① `globalStandardFastAdoption`(글로벌 SE 표준 빠른 도입), ② `handsOnToolPractice`(Cameo/SysML v2 실습 채널), ③ `domainReferenceModelCreation`(Do-Tank 도메인 참조모델 자체 개발).
  - **통합 컨텍스트 베이스라인 (`part incoseKoreaChapterContext`)**:
    - `part chapter : ChapterInContext`: 회원 로스터(`chapterMemberRoster`)를 바인딩하고, 초기 실측 MoE 값(`accumulatedPresentationsCount = 1`, `regularActiveMembersCount = 12`, `sepCertifiedMembersCount = 1`)을 설정합니다.
    - Phase 1 활성 외부 액터 3개(`cameoVendor`, `incoseSector`, `technicalOperations`)와 `connect` 문으로 포트를 연결하며, `sponsor`와 `peerSociety` 연결은 Phase 2 이후로 보류(주석 처리)되어 있습니다.

---

##### 파일 11. `2_ASELCM LV2_Chapter_Organization/2_Organization_and_Context/4_WorkingGroupsAndRoles.sysml`

- **패키지명**: `WorkingGroupsAndRoles`
- **역할 및 목적**: 챕터의 논리적 운영 조직(`ChapterLogicalOrganization`)과 역할(`ChapterRole`), 워킹그룹(`WorkingGroup`) 스키마를 정의하고, 현재 운영 중인 리더십 및 4대 도메인 워킹그룹 인스턴스(`chapterOrganization`)를 구체화합니다.
- **주요 정의 및 구성요소**:
  - `part def ChapterRole`: 직책명(`roleTitle`), 담당 회원 참조(`ref assignee`), 책임 목록(`responsibilities`).
  - `part def WorkingGroup`: 워킹그룹명(`wgName`), 대상 시스템 범위(`targetSystemScope`), 도메인(`domain`), 저장소 매핑 폴더(`ref targetFolder`), LV1 패키지 경로(`targetSysmlPackagePath = lv1RootPath + "/" + lv1PackageFolderName`), 리더(`part lead`), 참여 회원(`ref participants`).
  - `part chapterOrganization : ChapterLogicalOrganization` (실제 조직 인스턴스):

| 구분       | 조직/역할명                            | 담당자 / 리드 (`assignee` / `lead`) | 참여 회원 (`participants`)                     | 대상 시스템 범위 (`targetSystemScope`) 및 매핑 폴더                                                      |
| :--------- | :------------------------------------- | :---------------------------------- | :--------------------------------------------- | :------------------------------------------------------------------------------------------------------- |
| **리더십** | **Chapter Representative (챕터 대표)** | `'이중윤'`                          | -                                              | Do-Tank 비전 수립, 운영 총괄, KOSSE/KCOSE 및 INCOSE 대외 협력 대표                                       |
| **리더십** | **General Secretary (총무/운영)**      | `'추수호'`                          | -                                              | 격주 웹 스프린트/분기 모임 운영, 저장소 형상 관리 및 보안 승인, Sector 정기 보고                         |
| **자문단** | **Academic Advisors (학술자문단)**     | `'이중윤'`, `'서은석'`              | -                                              | 모델링 방법론 지도 및 피드백 검증 (`ModelReviewProcess::reviewByAcademicAdvisors`)                       |
| **WG 1**   | **1. Aerospace Working Group**         | `'이수'`                            | `'이수'`, `'박승훈'`, `'김다운'`, `'박홍석'`   | 2035 다목적 쿼드콥터 드론 시스템 (감시정찰/공격/보급 임무 체계 전체) (`dom1_Aerospace`)                  |
| **WG 2**   | **2. Automotive Working Group**        | `'추수호'`                          | `'추수호'`, `'최성열'`, `'이의범'`             | 2035 소프트웨어 중심 자동차(SDV) 및 섀시를 포함한 Vehicle 전체 시스템 (`dom2_Automotive`)                |
| **WG 3**   | **3. IT & Robotics Working Group**     | `'박홍석'`                          | `'심정환'`, `'박홍석'`, `'최지원'`, `'구정모'` | 2035 재난 탐색 및 구조 지원 로봇 시스템 전체 (`dom3_IT`)                                                 |
| **WG 4**   | **4. Semiconductor Working Group**     | `'김희재'`                          | `'김희재'`                                     | 2035 EUV 제니스 반도체 장비 시스템 (Level 0 공정 컨텍스트 및 Fab 베리에이션 포함) (`dom4_Semiconductor`) |

---
