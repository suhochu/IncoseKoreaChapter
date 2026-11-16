# 0_ASELCM_Integration

LV3(거버넌스)와 LV2(챕터 조직)를 함께 묶는 통합 패키지입니다.

- `ASELCM_SystemOfSystems.sysml`: `GovernanceSystemContext`와 `incoseKoreaChapterContext`를 포함하는 상위 part,
  `GovernanceInterfacePort` ↔ 켤레 포트 연결, `chapter`의 `perform action` / `exhibit state` 연결.
- 의존 방향: 이 패키지 → LV3, LV2. LV3는 LV2를 import하지 않고, LV2는 이 패키지를 import하지 않습니다(순환 금지).
- LV2와 LV3를 함께 참조해야 하는 요소는 이 폴더에만 추가합니다.

# 의존 구조도

0_ASELCM_Integration ASELCM_SystemOfSystems ──► LV3 GovernanceSystemAndTooling, LV2 ChapterSystemContext, ChapterConOpsAndLifecycle

LV2 → LV3 (단방향)
StakeholdersConcerns ──► GovernanceSystemAndTooling, ChapterSystemContext, ExternalActors, StakeholderDefinitions
WG_Submissions_Tracker ──► ModelingAssignments ──► SprintMeetings_2026_Q4 ──► ChapterSprint
ChapterSprint ──► WorkingGroupsAndRoles ──► ChapterSystemContext ──► ChapterMetricsAndGuards
ChapterSystemContext ──► ChapterMembersDirectory ──► StakeholderDefinitions
ChapterSystemContext, ChapterMetricsAndGuards, ChapterConOps, ChapterSprint, ChapterObjectives ──► QualityGatesAndReviewProcess, GovernanceInterfaces (LV3)

LV3: GovernanceSystemAndTooling ──► ModelingConventionsAndPolicies, QualityGatesAndReviewProcess (LV2 import 없음)

# `0_ASELCM_Integration/ASELCM_SystemOfSystems.sysml` 설명

- **패키지명**: `ASELCM_SystemOfSystems`
- **역할 및 목적**: LV3(거버넌스 시스템)와 LV2(INCOSE Korea Chapter 조직 시스템)를 하나의 상위 복합체계(System of Systems)로 묶고, 정적 구조(`chapter`)에 동적 행위(`Action`)와 수명주기 상태머신(`State`)을 결합하는 **유일한 최상위 통합 파일**입니다.
- **주요 정의 및 구성요소**:
  - `part def AselcmSystemOfSystems`:
    - `part governance : GovernanceSystemContext` (System 3 인스턴스 포함)
    - `part chapterContext :> incoseKoreaChapterContext`: LV2에서 정의된 구조 베이스라인(`incoseKoreaChapterContext`)을 부분집합(`:>`)으로 상속받아 내부 `part :>> chapter`를 재정의합니다.
    - **행위-구조 바인딩 (`perform action`)**:
      - `sectorReporting : SectorReporting` (아시아-오세아니아 섹터 정기 보고)
      - `referenceModelDevelopment : ReferenceModelDevelopmentProcess` (Do-Tank 참조모델 개발 및 품질 게이트)
      - `knowledgeExchange : KnowledgeExchangeSession` (온라인 세미나/리뷰 등 지식 교환)
    - **수명주기-구조 바인딩 (`exhibit state`)**:
      - `lifecycle : ChapterLifecycle { in ref :>> metrics = chapter; }`: 상태머신의 전이 조건 평가 입력(`metrics`)으로 `ChapterMoEsHolder`를 상속받은 `chapter` 자신을 바인딩합니다.
    - **거버넌스-챕터 포트 연결**:
      - `connect governance.governanceInterface to chapterContext.chapter.governanceInterface;`를 통해 LV3의 정책 하달(`out`)/지표 수집(`in`) 포트와 LV2의 켤레 포트(`~GovernanceInterfacePort`)를 연결합니다.
  - `part aselcmSystemOfSystems : AselcmSystemOfSystems`: 최상위 SoS 인스턴스 Usage입니다.
- **모델 이해 및 검토 포인트 (`TODO`)**:
  - 패키지 수준 Part Usage인 `incoseKoreaChapterContext`를 `:>`로 subset하고 내부 `chapter`를 `:>>`로 재정의하는 패턴을 사용 중이며, 각 Action의 `in/out` 파라미터(`internalData` 등)와 `chapter.repository` 간 세부 플로우 바인딩이 향후 확장 포인트로 남아 있습니다.
