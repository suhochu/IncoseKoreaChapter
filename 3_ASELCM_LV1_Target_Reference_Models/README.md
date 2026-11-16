### [계층 3] ASELCM LV1: 도메인 참조모델 공통 스캐폴드 (`3_ASELCM_LV1_Target_Reference_Models/0_Common_Foundation/`)

LV1 계층의 `0_Common_Foundation/` 폴더는 4대 워킹그룹(항공우주, 자동차, IT/로봇, 반도체 장비)이 각자의 2035년 대상 시스템(SoI)을 모델링할 때 **반드시 상속(`:>`)하여 구현해야 하는 3단계(Stage 2 ~ Stage 4) 추상 메타모델 스캐폴드**입니다. 이 스캐폴드를 상속하면 LV3의 학술자문단 피드백 1~3과 실무 가이드 Gate 1~6을 구조적으로 준수하게 됩니다.

---

#### 파일 22. `3_ASELCM_LV1_Target_Reference_Models/0_Common_Foundation/1_Operational_BlackBox_Scaffold.sysml`

- **패키지명**: `LV1_BlackBox_ConOps_Scaffold`
- **역할 및 목적**: **Stage 2 (블랙박스 정의 및 ConOps)** 단계의 핵심 스캐폴드로, 임무 및 정량적 MOE 구조체, 운용 시점 인프라 가정 및 ODD 3단계 장소 그룹핑, Solution-Free 블랙박스 SoI와 3대 외부 환경 액터/포트 대칭성, 그리고 5-Tuple 기반 End-to-End 운용 시나리오와 워킹그룹용 복사 템플릿까지 5개 하위 패키지를 제공합니다.
- **주요 정의 및 구성요소**:
  1. **`package MissionAndMOEScaffold` (임무 Triad 및 정량적 MOE 스캐폴드 — Feedback 1, 2 대응)**:
     - `enum def EvaluationDirectionKind`: 지표 평가 방향 (`minimize` 하향 지표 vs `maximize` 상향 지표).
     - `attribute def MOEMetric`: `metricId`, `metricName`, `unit`, `direction`, `thresholdValue`(한계값), `targetValue`(목표값), `evaluationCondition`, `evaluatedValue`를 갖춘 표준 구조체.
     - `constraint def MOEAchievementConstraint`: `direction`에 따라 `evaluatedValue >= thresholdValue` 또는 `<= thresholdValue`를 자동 판정하는 제약식.
     - `abstract requirement def BaseMissionObjective`: `whatCoreMission`(What), `whyBusinessObjective`(Why), `moeMetrics : MOEMetric [1..*]`(Validation)의 Mission Triad 추상 요구사항.
  2. **`package TimeframeAndODDScaffold` (운용 시점 4대 가정 및 3대 장소 그룹핑 — Feedback 3, Gate 3, Gate 4 대응)**:
     - `abstract constraint def BaseTimeframeInfrastructureAssumption`: 목표 시점(`targetTimeframe`)과 4대 전제 속성(`externalInfraMaturity`, `regulatoryEnvironment`, `threatAndDisturbanceLevel`, `lifecycleEvolutionTrait`).
     - `enum def ODDStressGroupKind` 및 `part def OperationalLocationGroup`: 물리적·기능적 부하 동질성에 따른 3단계 공간 추상화 — `GroupA_Nominal`(공칭/정규), `GroupB_ComplexHighStress`(복합/고부하), `GroupC_ExtremeDegraded`(극한/기능저하, MRC 전이 구역).
  3. **`package BlackBoxContextScaffold` (블랙박스 SoI 및 3대 외부 상호작용 환경 — Gate 1, 2, 5 대응)**:
     - **경계면 교환 아이템 (`BaseBoundaryExchangeItem` 하위)**:
       - 외부 조직용: `OrganizationalCommandItem` (`Org -> SoI`), `OrganizationalReportItem` (`SoI -> Org`).
       - 외부 물리 인프라용: `PhysicalInfraInputItem` (`Infra -> SoI`), `PhysicalInfraOutputItem` (`SoI -> Infra`).
       - 외부 자연 환경용: `EnvironmentalDisturbanceItem` (`Nature -> SoI`, 외란 범주·파라미터명·크기·단위를 정형화하여 문학적 묘사 배제).
     - **표준 경계 포트 및 켤레 포트 대칭성**:
       - SoI 기준 포트 3종(`SoI_OrganizationBoundaryPort`, `SoI_PhysicalInfraBoundaryPort`, `SoI_NaturalEnvBoundaryPort`)과 `~` 켤레 포트를 가진 추상 외부 액터 3종(`BaseExternalOrganization`, `BaseExternalPhysicalSystem`, `BaseExternalNaturalEnvironment`).
     - `abstract part def BaseBlackBoxSoI`: 내부 하위 파트를 일절 갖지 않고 오직 3종의 외부 경계 포트만 노출하는 순수 블랙박스 SoI.
     - `abstract part def BaseBlackBoxOperationalContext`: 시점 전제(`timeframeReq`), ODD Group A/B/C, `targetSoI`, 그리고 각각 최소 2개 이상(`[2..*]`)의 외부 조직·외부 물리 시스템·외부 자연 환경을 강제하는 통합 컨텍스트 템플릿.
  4. **`package BlackBoxConOpsScaffold` (5-Tuple 블랙박스 운용 시나리오 — Feedback 1, 3 & Gate 6 대응)**:
     - `enum def MissionStateKind`: 5대 표준 임무 상태 (`StandbyAndInitialized`, `NominalMissionExecuting`, `DisturbanceAdapting`, `MinimalRiskCondition_MRC`, `MissionObjectiveAchieved`).
     - `abstract action def BaseScenarioStep_5Tuple`: 모든 시나리오 스텝에 강제되는 **5-Tuple 구조** — ① 스텝 번호 및 장소 그룹(`stepNumber`, `activeODDGroup`), ② 상호작용 외부 액터 참조(`interactingOrg`, `interactingPhysical`, `interactingNature`), ③ 경계면 입출력 아이템(`inboundToSoI`, `outboundFromSoI`), ④ 내부 구현을 배제한 블랙박스 반응 기술(`soiBlackBoxReaction`), ⑤ 임무 상태 전이 결과(`transitionedState`).
     - `abstract action def BaseBlackBoxConOpsScenario`: 공칭 개시(`step1_NominalInitiation`, Group A) -> 복합 인프라 상호작용(`step2_ComplexInfraInteraction`, Group B) -> 자연 외란 적응(`step3_NaturalDisturbanceAdaptation`, Group B) -> 극한 환경 최소위험상태 폴백(`step4_ExtremeDegradedMRCFallback`, Group C) -> 임무 완수 및 MOE 보고(`step5_MissionCompletionAndMOEReport`, Group A)의 5단계 시계열 표준 플로우.
  5. **`package DomainWG_Template_Skeleton` (워킹그룹용 실전 상속 템플릿)**:
     - 각 워킹그룹이 복사하여 `<...>` 플레이스홀더만 채우면 Step A(`DomainMissionObjective`) -> Step B(`DomainTimeframeAssumption`) -> Step C(`DomainBlackBoxSoI`, `DomainConOpsScenario`) -> Step D(`DomainOperationalContext` 및 `satisfy domainMission by targetSoI / conOpsScenario`)까지 즉시 완성할 수 있는 가이드 스켈레톤입니다.

---

#### 파일 23. `3_ASELCM_LV1_Target_Reference_Models/0_Common_Foundation/2_Logical_WhiteBox_Scaffold.sysml`

- **패키지명**: `LV1_Logical_WhiteBox_Scaffold`
- **역할 및 목적**: **Stage 3 (화이트박스 논리 아키텍처)** 단계의 공통 스캐폴드로, Stage 2에서 정의한 블랙박스 SoI(`BaseBlackBoxSoI`)의 외부 경계 포트를 그대로 보존한 채 내부를 **논리 기능(`Logical Function`)**과 **논리 서브시스템(`Logical Subsystem`)**으로 분해(Decomposition)하고 상호 할당(`allocate`)하는 추상 메타모델입니다.
- **주요 정의 및 구성요소**:
  - `abstract action def BaseLogicalFunctionAction`:
    - 블랙박스 ConOps 시나리오의 시스템 반응을 내부 기능 단위로 구체화하는 추상 액션 정의(`functionName`, `functionDescription`, `in item functionInput : BaseBoundaryExchangeItem [0..*]`, `out item functionOutput : BaseBoundaryExchangeItem [0..*]`).
  - `abstract part def BaseLogicalSubsystem`:
    - 특정 물리적 HW/SW 기술을 가정하지 않는(Solution-Free) 역할 중심의 논리적 서브시스템 추상 파트 정의(`subsystemName`, `logicalResponsibility`).
  - `abstract part def BaseWhiteBoxLogicalSoI :> BaseBlackBoxSoI`:
    - `BaseBlackBoxSoI`를 상속받아 외부 경계 포트를 유지하면서, 내부에 `part logicalSubsystems : BaseLogicalSubsystem [1..*]`와 `perform action logicalFunctions : BaseLogicalFunctionAction [1..*]`를 포함합니다.
    - `allocate logicalFunctions to logicalSubsystems;`를 통해 모든 논리 기능이 최소 1개 이상의 논리 서브시스템에 할당되도록 기능-구조 추적성을 강제합니다.

---

#### 파일 24. `3_ASELCM_LV1_Target_Reference_Models/0_Common_Foundation/3_Physical_and_VnV_Scaffold.sysml`

- **패키지명**: `LV1_Physical_and_VnV_Scaffold`
- **역할 및 목적**: **Stage 4 (물리 아키텍처 및 시뮬레이션 검증 V&V)** 단계의 공통 스캐폴드로, Stage 3의 논리 화이트박스 SoI(`BaseWhiteBoxLogicalSoI`)를 실제 물리 컴포넌트(`Physical Component`)로 실체화(`allocate`)하고, 시스템 검증 케이스(`Verification Case`)를 통해 최상위 임무 요구사항 및 정량적 MOE 달성 여부를 검증(`verify`)하는 추상 메타모델입니다.
- **주요 정의 및 구성요소**:
  - `abstract part def BasePhysicalComponent`:
    - 논리 서브시스템이 실체화되는 구체적인 HW, SW, 조직, 설비 등의 물리 구성요소 추상 정의(`componentName`, `physicalSpecification`).
  - `abstract part def BasePhysicalSoI :> BaseWhiteBoxLogicalSoI`:
    - 논리 SoI를 상속받아 `part physicalComponents : BasePhysicalComponent [1..*]`를 추가하고, `allocate logicalSubsystems to physicalComponents;`를 통해 **논리 서브시스템 -> 물리 컴포넌트 간 할당 추적성**을 완성합니다.
  - `abstract verification def BaseSystemVerificationCase`:
    - 검증 대상 시스템(`subject systemUnderTest : BasePhysicalSoI`)과 검증 대상 지표(`in attribute moeUnderTest : MOEMetric`)를 입력받습니다.
    - 내부 제약 `constraint moeCheck : MOEAchievementConstraint { in :>> moe = moeUnderTest; }`를 통해 시뮬레이션/시험 평가값(`evaluatedValue`)이 한계값(`thresholdValue`)을 충족하는지 판정합니다.
    - `objective moeVerificationObjective { verify requirement missionRequirement : BaseMissionObjective; }`를 통해 Stage 2에서 출발한 최상위 임무 요구사항(`BaseMissionObjective`)부터 Stage 4의 물리 시스템 검증까지 **V-사이클의 좌측과 우측을 잇는 End-to-End 추적성 고리**를 완성합니다.

---
