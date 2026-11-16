### [계층 1] ASELCM LV3: 환경 및 거버넌스 시스템 (`1_ASELCM_LV3_Governance/`)

LV3 계층은 System 2(챕터 운영)와 System 1(워킹그룹별 도메인 참조모델)이 준수해야 할 **법칙, 표준, 품질 게이트, 검수 워크플로우, 성장 임계값**을 정의합니다.

#### 파일 3. `1_ASELCM_LV3_Governance/1_ModelingConventionsAndPolicies.sysml`

- **패키지명**: `ModelingConventionsAndPolicies`
- **역할 및 목적**: System-as-Code 기반의 협업 충돌 방지용 모델링 규약(`ModelingConventions`)과 글로벌 본부/섹터 지침, 국제 SE 표준, 기업 정보보안 규정(`PolicyAndDirectives`)을 정형 제약조건(`constraint def`)과 요구사항(`requirement def`)으로 정의합니다.
- **주요 정의 및 구성요소**:
  - **하위 패키지 1: `ModelingConventions` (모델링 규약 및 형상 관리 제약)**
    - `constraint def NamingConventionRule`:
      - Definition(`part def`, `action def` 등) 및 Package는 `PascalCase` (숫자/`_`는 구분자로만 허용).
      - Usage와 Attribute, Enum 리터럴은 `lowerCamelCase` (`_`는 순번/식별자/날짜 구분에만 허용).
      - 식별자(예: 회원 ID `<M001>`)는 별도 속성을 만들지 않고 SysML Short Name으로 부여하며, 한글 표시명(`'이수'`)은 인명과 Viewpoint에만 허용합니다.
    - `constraint def VersionControlPolicy`: 메인 브랜치 및 저장소 병합 전 3단계 승인 필수 조건 (`isWGLeadReviewed and isAcademicAdvisorApproved and isSecretaryMerged`).
    - `constraint def ScaffoldInheritanceRule`: 모든 LV1 도메인 모델이 공통 스캐폴드(`LV1_BlackBox_ConOps_Scaffold`)를 상속(`inheritsCommonScaffold`)하고 외부 액터 포트(`~`)와 SoI 포트 간 대칭성(`maintainsPortTypeSymmetry`)을 유지해야 하는 규칙입니다.
    - `constraint def EnterpriseSecurityRule`: 사내 실제 데이터 배제(`isInternalDataExcluded`) 및 회사/프로젝트 익명화(`isCompanyProjectAnonymized`) 제약입니다.
  - **하위 패키지 2: `PolicyAndDirectives` (글로벌 정책 및 국제 표준 준수 요구사항)**
    - `requirement def SectorComplianceRule`: INCOSE Asia-Oceania Sector(Sector III) 정기 보고 양식 및 주기 준수 요구사항.
    - `requirement def ToolLicensePolicy`: 상용 MBSE 툴(Cameo 등) 및 Syside 사용 시 참가자 전원 라이선스 보유 또는 Community Edition 범위 준수 규정.
    - `requirement def SEStandardAlignmentPolicy`: 3대 국제 표준 준거 요구사항 — ① **ISO/IEC/IEEE 15288**(문제 공간과 해결 공간 분리), ② **INCOSE GtWR v4**(What/Why/Validation 축), ③ **OMG SysML v2**(정형 문법).
    - `requirement def EnterpriseSecurityAndIPPolicy`: `EnterpriseSecurityRule` 제약을 `require constraint`로 강제하여 사내 수치 기재 금지 및 가상 치환 데이터(Anonymized Data) 사용을 의무화합니다.

---

#### 파일 4. `1_ASELCM_LV3_Governance/2_QualityGatesAndReviewProcess.sysml`

- **패키지명**: `QualityGatesAndReviewProcess`
- **역할 및 목적**: LV1 도메인 참조모델 과제의 무결성을 검증하는 **학술자문단 피드백 3대 원칙(Feedback 1~3)**과 **실무 가이드 6대 자체 감사 게이트(Gate 1~6)**, 이를 묶은 **통합 승인 게이트 및 검수 워크플로우(`ModelReviewProcess`)**, 그리고 LV2 챕터 조직의 **성장 단계 전환 조건(`Maturity Gate`)**을 단일 위치에서 정의합니다.
- **주요 정의 및 구성요소**:
  - **공통 타입 (3.0)**:
    - `enum def SEAssignmentStageKind`: 4단계 과제 구분 (`stage1_SoIAndQuestionSelection`, `stage2_BlackBoxAndConOps`, `stage3_LogicalArchitecture`, `stage4_PhysicalAndSimulation`).
    - `abstract constraint def AssignmentCheckpointRule`: 모든 피드백 및 게이트 규칙의 추상 상위 타입.
  - **학술자문단 핵심 모델링 검증 규칙 (3.1 Feedback 1~3)**:
    - `Feedback1_MissionAchievementConOpsRule`: 단순 기능 나열이 아닌 최상위 임무(Mission) 달성 중심의 End-to-End ConOps 시나리오 구성 여부.
    - `Feedback2_QuantitativeMOEStructureRule`: 모호한 형용사 배제, 최소 1개 이상의 정량적 MOE(목표값/한계값/단위) 및 MOP 계층화 여부.
    - `Feedback3_BlackBoxAndTimeframeInfraRule`: 내부 구현(White-Box) 유출 없는 블랙박스 순수성 유지 및 운용 시점(PESTEL-CTIMMRA) 인프라 가정과의 일관성 여부.
  - **과제 산출물 자체 감사 게이트 (3.2 Gate 1~6)**:
    - `Gate1_WholeSystemScopeRule`: 하위 부품/제어기가 아닌 독립 임무 완수가 가능한 최상위 전체 시스템(Whole-System) 선정 여부.
    - `Gate2_BlackBoxSolutionFreeRule`: 내부 MCU/ECU/SW 함수/통신 버스 규격을 배제하고 경계면 포트/아이템만 노출했는지 여부(Solution-Free).
    - `Gate3_TimeframeAssumptionLinkRule`: 운용 시점(예: 2035년)의 4대 전제(①외부 인프라 성숙도, ②법규/제도, ③위협/외란 수준, ④수명주기 진화 특성) 반영 여부.
    - `Gate4_ODDSpatialGroupingRule`: 개별 지명 나열 대신 물리적·기능적 부하(Stress) 동질성 기준의 3단계 장소 그룹핑(Group A 공칭, Group B 복합/고부하, Group C 극한/기능저하) 적용 여부.
    - `Gate5_ThreeExternalScopesCompletenessRule`: 외부 조직(Org), 외부 물리 시스템(Physical), 외부 자연 환경(Nature)을 각각 최소 2개(`minActorCountPerScope = 2`) 이상 식별하고 자연 외란을 `EnvironmentalDisturbanceItem`으로 정형화했는지 여부.
    - `Gate6_NoIsolatedActorTraceabilityRule`: 컨텍스트의 모든 외부 액터가 최종 5-Tuple 시나리오(공칭 + 외란 적응 + 비상 폴백/MRC)에 최소 1회 이상 등장하여 고립 액터가 없는지 여부.
  - **LV1 과제 통합 승인 게이트 (3.3)**:
    - `attribute def AssignmentGateChecklist`: Feedback 1~3 및 Gate 1~6의 모든 개별 판정 속성(16개 필드)을 손실 없이 담는 데이터 구조체.
    - `constraint def ReferenceModelAssignmentApprovalGate`: `checklist`를 입력받아 `fb1 and fb2 and fb3 and gate1 and gate2 and gate3 and gate4 and gate5 and gate6`를 통합 평가합니다.
  - **모델 검수 및 승인 프로세스 (3.4)**:
    - `action def ModelReviewProcess`: `submitModelUpdate` -> `checkAutomatedConventionsAndGates` -> `gateDecision`(통과 시 `reviewByWGLead`, 미통과 시 `reviseModel` 루프) -> `reviewByAcademicAdvisors` -> `advisorDecision`(승인 시 `reviewByChapterLeadership` -> `mergeAndDeploy`, 미승인 시 `reviseModel` 루프)의 제어 흐름을 정의합니다.
  - **챕터 성장 단계 전환 조건 (3.5 Maturity Gate)**:
    - `attribute def MaturityGateThresholds` 및 단일 임계값 인스턴스:

| 임계값 구분                              | 발표 자료 (`presentations`) | 참조모델 (`refModels`) | AI Skills (`aiSkills`) | 고정 활동 인원 (`activeMembers`) | SEP 보유자 (`sepMembers`) | 판정 논리식 요약                                                                                        |
| :--------------------------------------- | :-------------------------: | :--------------------: | :--------------------: | :------------------------------: | :-----------------------: | :------------------------------------------------------------------------------------------------------ |
| **`phase1To2Thresholds`** (Phase 1 -> 2) |             10              |           3            |           3            |          16 (15명 초과)          |             3             | `(presentations >= 10 or activeMembers >= 16) and refModels >= 3 and aiSkills >= 3 and sepMembers >= 3` |
| **`phase2To3Thresholds`** (Phase 2 -> 3) |         0 (미사용)          |           3            |           5            |                30                |            10             | `activeMembers >= 30 and sepMembers >= 10 and aiSkills >= 5 and refModels >= 3`                         |

---

#### 파일 5. `1_ASELCM_LV3_Governance/3_GovernanceSystemAndTooling.sysml`

- **패키지명**: `GovernanceSystemAndTooling`
- **역할 및 목적**: 모델이 작성·시각화·검증되는 IT 도구 생태계(`ToolingEcosystem`), LV3와 LV2/LV1 간 정책 하달 및 지표 수집 인터페이스(`GovernanceInterfaces`), 그리고 앞서 정의한 모든 LV3 규칙과 게이트를 보유한 System 3 실체(`GovernanceSystemContext`)를 정의합니다.
- **주요 정의 및 구성요소**:
  - **하위 패키지 1: `ToolingEcosystem` (IT 인프라 파트 정의)**
    - `ModelRepositoryServer`: GitHub 및 Google Workspace 기반 모델 호스팅/버전 관리 서버.
    - `VisualizationEngine`: Syside / Tom Sawyer 등 텍스트 모델을 다이어그램/테이블/매트릭스로 렌더링하는 엔진.
    - `SimulationAndCodeGenPipeline`: SysML v2 모델로부터 MILS/SILS/HILS 시뮬레이션 및 Simulink 오토코드 생성까지 End-to-End 추적성을 검증하는 파이프라인.
  - **하위 패키지 2: `GovernanceInterfaces` (교환 아이템 및 기준 포트)**
    - `item def GovernancePolicyDirectiveItem`: 정책 버전(`policyVersion`) 및 대상 과제 단계(`targetAssignmentStage`)를 담아 LV3 -> LV2/LV1로 하달하는 아이템.
    - `item def ChapterComplianceAndMetricsItem`: 제출 모델명, 게이트 통과 여부, 현재 승인된 모델 수를 담아 LV2/LV1 -> LV3로 보고하는 아이템.
    - `port def GovernanceInterfacePort`: `out item policyDirectives` 및 `in item chapterOperationalMetrics`를 갖는 System 3 기준 포트.
  - **하위 패키지 3: `GovernanceSystem` (System 3 최상위 컨텍스트)**
    - `part def GovernanceSystemContext`:
      - 규약 제약(`namingConventions`, `vcsPolicy`, `scaffoldRule`), 정책 요구사항(`sectorDirectives`, `standardPolicy`, `toolLicensePolicy`, `securityPolicy`), 품질 프로세스(`perform action qaProcess : ModelReviewProcess`), 게이트 제약(`lv1AssignmentGate`, `phase1To2Gate`, `phase2To3Gate`), 도구 인프라 파트(`repositoryServer`, `visualizer`, `simPipeline`), 그리고 `port governanceInterface : GovernanceInterfacePort`를 하나로 캡슐화합니다.

---
