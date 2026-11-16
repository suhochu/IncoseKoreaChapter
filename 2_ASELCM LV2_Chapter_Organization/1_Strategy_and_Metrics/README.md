#### [2-1] 전략 및 핵심 지표 (`1_Strategy_and_Metrics/`)

##### 파일 6. `2_ASELCM LV2_Chapter_Organization/1_Strategy_and_Metrics/1_ChapterObjectives.sysml`

- **패키지명**: `ChapterObjectives`
- **역할 및 목적**: INCOSE Korea Chapter가 존재하는 근본적인 이유(Goal Viewpoint)를 **목적(`ChapterObjective`) - 문제 정의(`ChapterProblemStatement`) - 시스템 아이디어(`ChapterSystemIdea`)**의 3대 최상위 요구사항으로 정의하고, 챕터 인스턴스가 이를 만족(`satisfy`)함을 선언합니다.
- **주요 정의 및 구성요소**:
  - `requirement def Objective`: `subject chapter : KoreaChapter`를 공통 주체로 갖는 최상위 요구사항 타입.
  - `requirement def ChapterObjective :> Objective`:
    - 이론 중심 싱크탱크(Think-Tank)를 넘어 실제 산출물을 도출하는 **'Do-Tank'**로 조직을 재활성화하고, 산업계 실무자가 즉시 활용 가능한 도메인별(자동차, 우주 등) 레퍼런스 모델을 공동 개발하며, 선택적으로 요구사항부터 Simulink 오토코드 생성까지 End-to-End 추적성을 구현하는 목적을 정의합니다.
    - `attribute targetReferenceModelCount : Integer = phase1To2Thresholds.refModels;` (LV3 임계값 `3`을 그대로 참조) 및 `require constraint referenceModelsDelivered { chapter.completedReferenceModelsCount >= targetReferenceModelCount }`로 정형화되어 있습니다.
  - `requirement def ChapterProblemStatement`: 국내 SE 전문 인력 감소, 실무 효과 체감 부족 및 실용적 레퍼런스 부재, 현업의 국제 표준(ISO 26262, ASPICE 등) 대응이 '보여주기식 요식 행위'로 전락해 기술 부채가 누적되는 구조적 문제를 정의합니다. ISO 15288 원칙에 따라 해결책을 포함하지 않음을 `require constraint problemSpaceSeparated { isSolutionFree }`로 명시합니다.
  - `requirement def ChapterSystemIdea :> Objective`: "현장의 문제를 직접 해결하는 시스템 엔지니어링 실전 랩(Lab), INCOSE Korea 'Do-Tank' 챕터"라는 엘리베이터 피치와 상향식(Bottom-up) 확산 전략을 정의합니다 (`coversOperationalRequirementToCodeGeneration`).
  - `satisfy chapterObjective by incoseKoreaChapterContext.chapter;`: 베이스라인 챕터 인스턴스가 최상위 목적을 충족함을 연결합니다.

---

##### 파일 7. `2_ASELCM LV2_Chapter_Organization/1_Strategy_and_Metrics/2_ChapterMetricsAndGuards.sysml`

- **패키지명**: `ChapterMetricsAndGuards`
- **역할 및 목적**: 외부 변수(기업 스폰서 등)를 배제하고 챕터 내부 산출물과 인적 역량만으로 성장을 측정하는 **5대 핵심 성과 지표(Core MoEs)** 홀더(`ChapterMoEsHolder`)를 정의하고, 이를 LV3의 Phase 전환 게이트 제약식에 연결하여 상태머신 Guard용 파생 Boolean을 산출합니다.
- **주요 정의 및 구성요소**:
  - `part def ChapterMoEsHolder` (`KoreaChapter`의 상위 부모 정의):
    - **5대 핵심 MoE 속성**:
      1. `accumulatedPresentationsCount : Integer` (누적 발표/사례 자료 수 — 수동 입력)
      2. `completedReferenceModelsCount : Integer` (완성된 도메인 참조모델 수 — `KoreaChapter`에서 저장소 컬렉션 크기로 자동 파생)
      3. `developedAISkillsCount : Integer` (개발된 단계별 AI Skills 수 — `KoreaChapter`에서 저장소 컬렉션 크기로 자동 파생)
      4. `regularActiveMembersCount : Integer` (고정 활동 인원 수 — 수동 입력)
      5. `sepCertifiedMembersCount : Integer` (SEP 자격 보유자 수 — 수동 입력)
    - **LV3 게이트 제약 바인딩**: `phase1To2GateCheck : Phase1ToPhase2GateConstraint` 및 `phase2To3GateCheck : Phase2ToPhase3GateConstraint`의 입력 파라미터에 위 5개 지표를 매핑합니다.
    - **상태 전이 Guard 속성**: `isPhase1To2Ready : Boolean = phase1To2GateCheck.result;` 및 `isPhase2To3Ready : Boolean = phase2To3GateCheck.result;`를 통해 상태머신(`ChapterLifecycle`)이 전이 가능 여부를 판단하도록 합니다.

---
