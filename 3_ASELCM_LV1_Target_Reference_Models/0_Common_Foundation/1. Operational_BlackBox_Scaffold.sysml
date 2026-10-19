package LV1_BlackBox_ConOps_Scaffold {
    doc
    /* [InKC LV1 공통 스캐폴드 패키지]
     * 각 도메인 워킹그룹(자동차, 우주, 스마트팩토리, 반도체장비 등)이 상속(:>)하여
     * 대상시스템(SoI)의 블랙박스 정의와 운용개념(ConOps)을 일관되게 구축하기 위한 추상 메타모델.
     *
     * [핵심 설계 원칙]
     * 1. 존재 목적 달성 표현 (피드백 1): ConOps 시나리오가 임무/사업 목표(MissionRequirement)를 satisfy함.
     * 2. 정량적 MOE 구조화 (피드백 2): 임무 달성 여부를 판정하는 MOE에 목표값/한계값/단위를 강제함.
     * 3. 운용 시점 인프라 가정 & 블랙박스 상호작용 (피드백 3): 외부 환경(특히 외부 물리/조직 시스템)은
     *    운용 시점의 인프라 가정에 기반하며, SoI는 내부 구조를 숨긴 채 경계 포트 입출력으로만 상호작용함.
     */

    private import ScalarValues::*;

    // =========================================================================
    // 1. 임무 정의(Mission Triad) 및 운용효과성측정지표(MOE) 스캐폴드
    //    (교수님 피드백 1, 2 & 가이드 2장 반영)
    // =========================================================================
    package MissionAndMOEScaffold {
        doc
        /* 대상시스템의 존재 목적(What/Why)과 성공 판정 기준(MOE)을 정의하는 추상 계층 */

        // [교수님 피드백 2] 목표값(Target), 한계값(Threshold), 단위(Unit)를 갖춘 MOE 구조체
        attribute def MOEMetric {
            doc
            /* 운용효과성측정지표(Measure of Effectiveness) 표준 템플릿.
             * 수치 자체의 엄밀성보다 '목표값/한계값/단위'의 정형화된 구조 정의가 핵심임.
             */
            attribute metricId : String; // 지표 식별자 (예: "MOE-01")
            attribute metricName : String; // 지표 명칭
            attribute unit : String; // 측정 단위 (예: "%", "분", "건/년", "m")
            attribute thresholdValue : Real; // 한계값 (Threshold: 임무 성공 최소 허용 기준)
            attribute targetValue : Real; // 목표값 (Objective/Target: 지향하는 이상적 기준)
            attribute evaluationCondition : String; // 측정 조건 (예: "ODD 전 구간 운용 기준")
            attribute evaluatedValue : Real [0..1]; // 시나리오/시뮬레이션 수행 후 평가값
        }

        // MOE 달성 여부 판정 제약식 (필요 시 하위 도메인에서 부등호 방향 재정의 가능)
        constraint def MOEAchievementConstraint {
            in moe : MOEMetric;
            moe.evaluatedValue >= moe.thresholdValue
        }

        // [교수님 피드백 1, 2 & 가이드 2장] Mission Triad (What / Why / Validation) 추상 요구사항
        abstract requirement def BaseMissionObjective {
            doc
            /* 모든 도메인의 최상위 임무/사업 목표 요구사항이 상속받아야 할 스캐폴드.
             * 하위 도메인에서 ':>>' (redefines)를 통해 구체적인 텍스트와 MOE를 채워 넣음.
             */
            attribute whatCoreMission : String; // [WHAT] 핵심 임무 선언 (누구를 위해 무엇을 완수하는가)
            attribute whyBusinessObjective : String; // [WHY] 존재 이유 및 사업 목표 (Pain Point 극복 및 창출 효용)
            attribute moeMetrics : MOEMetric [1..*]; // [VALIDATION] 정량적 운용효과성측정지표(MOE) 목록
        }
    } // package MissionAndMOEScaffold

    // =========================================================================
    // 2. 운용 시점(Timeframe) 인프라 가정 및 운용 장소(ODD) 그룹핑 스캐폴드
    //    (교수님 피드백 3 & 가이드 3장, 4장 반영)
    // =========================================================================
    package TimeframeAndODDScaffold {
        doc
        /* [교수님 피드백 3] 블랙박스 SoI가 상호작용할 외부 환경에 대한 가정은
         * 곧 '운용 시점의 인프라·법규·외란에 대한 가정'임을 명시하는 스캐폴드.
         */

        // [가이드 3장 & 피드백 3] 운용 시점 및 4대 기술·제도·인프라 전제 조건
        abstract constraint def BaseTimeframeInfrastructureAssumption {
            doc
            /* 각 워킹그룹이 합의한 운용 시점(예: 2030~2040년)의 4대 외부 환경 전제 조건.
             * 여기서 가정한 인프라와 법규가 3장(BlackBoxContextScaffold)의 외부 액터로 실체화됨.
             */
            attribute targetTimeframe : String; // 운용 시점 (단순 연도가 아닌 기술/제도 앵커)
            attribute externalInfraMaturity : String [1..*]; // ① 외부 인프라 성숙도 (통신/전력/관제 설비 전제)
            attribute regulatoryEnvironment : String [1..*]; // ② 법규 및 제도 환경 (인허가, 무인화 법적 책임 기준)
            attribute threatAndDisturbanceLevel : String [1..*]; // ③ 위협 및 외란 수준 (물리적·전자기적·기상 위협)
            attribute lifecycleEvolutionTrait : String [1..*]; // ④ 수명주기 진화 특성 (배포 후 업그레이드/유지보수 체계)
        }

        // [가이드 4장 & Gate 4] 물리적·기능적 부하(Stress) 동질성 기반 3대 장소 그룹핑
        enum def ODDStressGroupKind {
            GroupA_Nominal; // 그룹 A (공칭/정규 환경): 외부 인프라 완비, 불확실성이 통제된 기본 환경
            GroupB_ComplexHighStress; // 그룹 B (복합/고부하 환경): 이종 객체 혼재 및 시스템 판단 부하 극대화 구역
            GroupC_ExtremeDegraded; // 그룹 C (극한/기능저하 환경): 인프라 음영·극한 외란으로 최소위험상태(MRC) 전이 요구 구역
        }

        part def OperationalLocationGroup {
            attribute groupKind : ODDStressGroupKind;
            attribute representativeLocations : String [1..*]; // 해당 그룹을 대표하는 추상화된 공간 예시
            attribute stressCharacteristics : String; // 시스템에 가해지는 물리적·기능적 부하 특성
        }
    } // package TimeframeAndODDScaffold

    // =========================================================================
    // 3. 블랙박스 대상시스템(SoI) 및 3대 외부 상호작용 환경 스캐폴드
    //    (교수님 피드백 3 & 가이드 1장, 5장, Gate 1·2·5 반영)
    // =========================================================================
    package BlackBoxContextScaffold {
        private import TimeframeAndODDScaffold::*;

        doc
        /* [원칙 1: Solution-Free & Gate 2: Black-Box]
         * 대상시스템(SoI) 내부의 HW/SW 컴포넌트, 제어기, 내부 버스, 알고리즘을 일절 정의하지 않고,
         * 경계면의 포트(Port)와 입출력 교환 아이템(Item)만 정의하는 스캐폴드.
         */

        // ---- 3.1 경계면 입출력 교환 아이템 (Exchange Items) 추상 계층 ----
        abstract item def BaseBoundaryExchangeItem {
            attribute itemDescription : String [0..1];
        }

        // (1) 외부 조직 ↔ SoI 교환 아이템
        item def OrganizationalCommandItem :> BaseBoundaryExchangeItem {
            doc
            /* 외부 조직 -> SoI: 임무 지령, 운용 허가 토큰, 비상 통제 명령 등 */
        }
        item def OrganizationalReportItem :> BaseBoundaryExchangeItem {
            doc
            /* SoI -> 외부 조직: 운용 상태 보고, 임무 결과 로그, 긴급 구난(eCall 등) 요청 */
        }

        // (2) 외부 물리 시스템(인프라) ↔ SoI 교환 아이템
        item def PhysicalInfraInputItem :> BaseBoundaryExchangeItem {
            doc
            /* 외부 물리 인프라 -> SoI: 외부 신호/통신 패킷, 측위 보정, 충전 전력/에너지, 물리적 도킹 등 */
        }
        item def PhysicalInfraOutputItem :> BaseBoundaryExchangeItem {
            doc
            /* SoI -> 외부 물리 인프라: 상태 브로드캐스트 패킷, 인프라 요청 신호, 물리적 작업 출력 등 */
        }

        // (3) 외부 자연 환경 → SoI 외란 아이템 [가이드 5장: 외란 아이템화 규칙]
        item def EnvironmentalDisturbanceItem :> BaseBoundaryExchangeItem {
            doc
            /* 자연 환경과의 상호작용을 문학적 묘사가 아닌 정형 데이터/물리 타입으로 모델링하기 위한 아이템.
             * 외부 자연 환경의 출력 타입과 SoI의 입력 타입 간 대칭성(Type Symmetry)을 보장함.
             */
            attribute disturbanceCategory : String; // 예: "노면 마찰 저하", "폭우 센서 감쇠", "태양풍 방사선"
            attribute parameterName : String; // 예: "마찰계수(mu)", "감쇠율", "열하중"
            attribute parameterValue : Real [0..1]; // 외란 크기(선택)
            attribute parameterUnit : String [0..1]; // 외란 단위(선택)
        }

        // ---- 3.2 포트 대칭성(Port & Type Symmetry)을 보장하는 표준 경계 포트 ----
        // SoI 측 포트 정의 (외부 액터는 '~' 켤레 포트(Conjugated Port)를 사용하여 완벽한 대칭성 유지)
        port def SoI_OrganizationBoundaryPort {
            in item commandIn : OrganizationalCommandItem [0..*];
            out item reportOut : OrganizationalReportItem [0..*];
        }

        port def SoI_PhysicalInfraBoundaryPort {
            in item infraIn : PhysicalInfraInputItem [0..*];
            out item infraOut : PhysicalInfraOutputItem [0..*];
        }

        port def SoI_NaturalEnvBoundaryPort {
            in item disturbanceIn : EnvironmentalDisturbanceItem [0..*];
        }

        // ---- 3.3 3대 외부 상호작용 액터 추상 정의 (조직 / 물리 인프라 / 자연 환경) ----
        abstract part def BaseExternalOrganization {
            doc
            /* ① 외부 조직 (Org): 관제, 법규/인증, 소방/구난 등 인간·사회적 조직 엔티티 */
            attribute orgRole : String;
            // '~' (Conjugation)를 통해 SoI_OrganizationBoundaryPort와 입출력 방향이 정확히 대칭됨
            port orgPort : ~SoI_OrganizationBoundaryPort;
        }

        abstract part def BaseExternalPhysicalSystem {
            doc
            /* ② 외부 물리 시스템 (Physical): [교수님 피드백 3] 운용 시점의 인프라 가정이 실체화된
             * 외부 통신망, 기지국, 충전/보급 설비, 타 시스템 등 인공 물리 엔티티.
             */
            attribute infraSystemRole : String;
            port physicalPort : ~SoI_PhysicalInfraBoundaryPort;
        }

        abstract part def BaseExternalNaturalEnvironment {
            doc
            /* ③ 외부 자연 환경 (Nature): 통제 불가능하며 시스템에 물리적·환경적 외란을 유입하는 자연계 */
            attribute environmentFactor : String;
            port naturePort : ~SoI_NaturalEnvBoundaryPort;
        }

        // ---- 3.4 블랙박스 대상시스템 (Target SoI: Whole-System & Black-Box) ----
        abstract part def BaseBlackBoxSoI {
            doc
            /* [Gate 1: Whole-System & Gate 2: Black-Box]
             * 독립적으로 임무를 완수하는 최상위 전체 시스템이며, 내부 구성요소(Part)를 갖지 않고
             * 오직 3대 외부 환경과 상호작용하는 경계 포트(Port)만 노출함.
             */
            attribute soiName : String;
            port orgBoundaryPort : SoI_OrganizationBoundaryPort [1..*];
            port physicalBoundaryPort : SoI_PhysicalInfraBoundaryPort [1..*];
            port natureBoundaryPort : SoI_NaturalEnvBoundaryPort [1..*];
        }

        // ---- 3.5 블랙박스 운용 컨텍스트 스캐폴드 (Gate 3, 4, 5 내장) ----
        abstract part def BaseBlackBoxOperationalContext {
            doc
            /* 운용 시점 전제 조건, 3대 ODD 장소 그룹, 블랙박스 SoI, 그리고
             * 각 2개 이상의 3대 외부 환경 액터(Gate 5)를 통합하는 컨텍스트 템플릿.
             */
            // [Gate 3] 운용 시점의 인프라·법규·외란 전제 조건 강제
            requirement timefrqme {
                assume constraint timeframeAssumption : BaseTimeframeInfrastructureAssumption;
            }

            // [Gate 4] 3개 대표 장소 그룹(Group A, B, C) 포함
            part oddGroupA : OperationalLocationGroup {
                :>> groupKind = ODDStressGroupKind::GroupA_Nominal;
            }
            part oddGroupB : OperationalLocationGroup {
                :>> groupKind = ODDStressGroupKind::GroupB_ComplexHighStress;
            }
            part oddGroupC : OperationalLocationGroup {
                :>> groupKind = ODDStressGroupKind::GroupC_ExtremeDegraded;
            }

            // [Gate 1 & 2] 블랙박스 대상시스템(SoI)
            part targetSoI : BaseBlackBoxSoI;

            // [Gate 5: 3대 범위 완전성] 외부 조직, 외부 물리 시스템, 외부 자연 환경 각 2개 이상 식별 강제 ([2..*])
            part externalOrganizations : BaseExternalOrganization [2..*];
            part externalPhysicalSystems : BaseExternalPhysicalSystem [2..*];
            part externalNaturalEnvironments : BaseExternalNaturalEnvironment [2..*];
        }
    } // package BlackBoxContextScaffold

    // =========================================================================
    // 4. 블랙박스 운용 시나리오(ConOps) 및 5-Tuple 명세 스캐폴드
    //    (교수님 피드백 1, 3 & 가이드 6장, Gate 6 반영)
    // =========================================================================
    package BlackBoxConOpsScaffold {
        private import MissionAndMOEScaffold::*;
        private import TimeframeAndODDScaffold::*;
        private import BlackBoxContextScaffold::*;

        doc
        /* [교수님 피드백 1 & 3]
         * 블랙박스 대상시스템이 외부 환경(조직/물리/자연)과 상호작용하며
         * 공칭 운용 -> 외란 적응 -> 비상 폴백(MRC)을 거쳐 존재 목적(임무/MOE)을 달성하는 동적 시나리오 스캐폴드.
         */

        // 대상시스템의 임무 상태 전이(Mission State Transition) 표준 상태 정의
        enum def MissionStateKind {
            StandbyAndInitialized; // 임무 대기 및 초기 인가 상태
            NominalMissionExecuting; // 공칭(Group A) 및 복합(Group B) 환경 정상 임무 수행 상태
            DisturbanceAdapting; // 자연 외란 유입에 적응하여 성능을 유지/조정하는 상태
            MinimalRiskCondition_MRC; // 극한 환경(Group C) 또는 한계 초과 시 최소위험상태(MRC) 안전 폴백 상태
            MissionObjectiveAchieved; // 최종 임무 완수 및 사업 목표(MOE) 달성 상태
        }

        // [가이드 6장] 표준 5-Tuple 시나리오 스텝 추상 액션 정의
        abstract action def BaseScenarioStep_5Tuple {
            doc
            /* 모든 시나리오 스텝은 아래 5-Tuple 요소를 반드시 포함해야 함:
             * 1. [Step N | 장소 그룹] : stepNumber, activeODDGroup
             * 2. [상호작용 액터 (분류)] : interactingOrg / interactingPhysical / interactingNature (Gate 6 추적성)
             * 3. [교환 아이템 (방향)] : inboundItem (Actor -> SoI), outboundItem (SoI -> Actor)
             * 4. [SoI 블랙박스 반응] : soiBlackBoxReaction (내부 구현 배제, 시스템 레벨 의사결정)
             * 5. [임무 상태 전이] : transitionedState (달성된 시스템 임무 상태)
             */
            attribute stepNumber : Integer;
            attribute activeODDGroup : ODDStressGroupKind; // 1. 장소 그룹 (A/B/C)

            // 2. 상호작용 외부 액터 참조 (정의된 모든 액터가 최소 1회 이상 참조되어야 함 - Gate 6)
            ref interactingOrg : BaseExternalOrganization [0..*];
            ref interactingPhysical : BaseExternalPhysicalSystem [0..*];
            ref interactingNature : BaseExternalNaturalEnvironment [0..*];

            // 3. 경계면 교환 아이템 (방향성 명시)
            in item inboundToSoI : BaseBoundaryExchangeItem [0..*]; // [외부 환경 -> SoI] 입력/외란
            out item outboundFromSoI : BaseBoundaryExchangeItem [0..*]; // [SoI -> 외부 환경] 출력/보고

            // 4. SoI 블랙박스 반응 (Solution-Free: 내부 제어기/SW 언급 없이 경계면 반응 기술)
            attribute soiBlackBoxReaction : String;

            // 5. 임무 상태 전이 결과
            attribute transitionedState : MissionStateKind;
        }

        // [가이드 6장 & 피드백 1] 전 과정 블랙박스 운용 시나리오 (ConOps) 추상 액션
        abstract action def BaseBlackBoxConOpsScenario {
            doc
            /* 해피 패스(공칭)뿐 아니라 복합 환경 상호작용, 자연 외란 적응, 비상 폴백(MRC),
             * 그리고 최종 임무/MOE 달성 확인 국면을 시간 순서(Time-ordered sequence)로 통합한 스캐폴드.
             */
            // 국면 1: 공칭 환경(Group A) 임무 개시 및 외부 조직/인프라 상호작용
            action step1_NominalInitiation : BaseScenarioStep_5Tuple {
                :>> activeODDGroup = ODDStressGroupKind::GroupA_Nominal;
                :>> transitionedState = MissionStateKind::NominalMissionExecuting;
            }

            // 국면 2: 복합/고부하 환경(Group B) 외부 물리 인프라 상호작용
            action step2_ComplexInfraInteraction : BaseScenarioStep_5Tuple {
                :>> activeODDGroup = ODDStressGroupKind::GroupB_ComplexHighStress;
                :>> transitionedState = MissionStateKind::NominalMissionExecuting;
            }

            // 국면 3: 외부 자연 환경 외란(Disturbance) 유입 및 블랙박스 적응 제어
            action step3_NaturalDisturbanceAdaptation : BaseScenarioStep_5Tuple {
                :>> activeODDGroup = ODDStressGroupKind::GroupB_ComplexHighStress;
                :>> transitionedState = MissionStateKind::DisturbanceAdapting;
            }

            // 국면 4: 극한/기능저하 환경(Group C) 진입 시 최소위험상태(MRC) 비상 폴백 및 조직 보고
            action step4_ExtremeDegradedMRCFallback : BaseScenarioStep_5Tuple {
                :>> activeODDGroup = ODDStressGroupKind::GroupC_ExtremeDegraded;
                :>> transitionedState = MissionStateKind::MinimalRiskCondition_MRC;
            }

            // 국면 5: 임무 완수 보고 및 존재 목적(임무/사업 목표 및 MOE) 달성 완료
            action step5_MissionCompletionAndMOEReport : BaseScenarioStep_5Tuple {
                :>> activeODDGroup = ODDStressGroupKind::GroupA_Nominal;
                :>> transitionedState = MissionStateKind::MissionObjectiveAchieved;
            }

            // 시계열 제어 흐름 (하위 도메인에서 세부 스텝 추가/분기 가능)
            first step1_NominalInitiation;
            then step2_ComplexInfraInteraction;
            then step3_NaturalDisturbanceAdaptation;
            then step4_ExtremeDegradedMRCFallback;
            then step5_MissionCompletionAndMOEReport;
        }
    } // package BlackBoxConOpsScaffold

    // =========================================================================
    // 5. [사용 가이드] 각 도메인 워킹그룹용 상속(Specialization) 스켈레톤 템플릿
    // =========================================================================
    package DomainWG_Template_Skeleton {
        doc
        /* 각 워킹그룹은 본 패키지를 복사하여 패키지명과 '<...>' 부분만 도메인에 맞게 채워 넣으면
         * 교수님 피드백 3가지와 6대 품질 게이트(Gate 1~6)를 자동으로 준수할 수 있음.
         */
        private import MissionAndMOEScaffold::*;
        private import TimeframeAndODDScaffold::*;
        private import BlackBoxContextScaffold::*;
        private import BlackBoxConOpsScaffold::*;

        // [Step A] 도메인 임무/사업목표 및 MOE 정의 (BaseMissionObjective 상속)
        requirement def DomainMissionObjective :> BaseMissionObjective {
            :>> whatCoreMission = "<누구를 위해 무엇을 완수하는지 단일 선언문 작성>";
            :>> whyBusinessObjective =
                "<극복할 기존 한계(Pain Point) 및 창출할 사업적/사회적 가치 작성>";

            attribute primaryMOE : MOEMetric :> moeMetrics {
                :>> metricId = "MOE-01";
                :>> metricName = "<운용효과성측정지표 명칭>";
                :>> unit = "<단위: %, 분, 건/년 등>";
                :>> thresholdValue = 0.0; // <한계값 입력>
                :>> targetValue = 0.0; // <목표값 입력>
                :>> evaluationCondition = "<ODD 내 측정 조건 입력>";
            }
        }

        // [Step B] 운용 시점의 외부 환경/인프라 4대 가정 정의 (BaseTimeframeInfrastructureAssumption 상속)
        constraint def DomainTimeframeAssumption :> BaseTimeframeInfrastructureAssumption {
            :>> targetTimeframe = "<운용 목표 연도 및 시점 정의>";
            :>> externalInfraMaturity =
                "<운용 시점에 구축되어 있을 외부 통신/전력/설비 인프라 가정>";
            :>> regulatoryEnvironment = "<운용 시점의 인허가/법규/책임 기준 가정>";
            :>> threatAndDisturbanceLevel = "<운용 시점의 주요 물리적/환경적/사이버 위협 가정>";
            :>> lifecycleEvolutionTrait = "<배포 후 수명주기 동안의 진화/유지보수 가정>";
        }

        // [Step C] 블랙박스 SoI 및 3대 외부 액터(각 2개 이상) 정의
        part def DomainBlackBoxSoI :> BaseBlackBoxSoI {
            :>> soiName =
                "<하위 부품이 아닌 독립 임무 완결형 최상위 대상시스템(Whole-System) 명칭>";
            satisfy requirement : DomainMissionObjective;
        }

        part def DomainOperationalContext :> BaseBlackBoxOperationalContext {
            :>> targetSoI : DomainBlackBoxSoI;
            // externalOrganizations, externalPhysicalSystems, externalNaturalEnvironments를
            // 각 2개 이상 구체화하고 connect 문으로 targetSoI의 경계 포트와 연결
        }

        // [Step D] 블랙박스 ConOps 시나리오 정의 및 임무 만족(satisfy) 연결
        action def DomainConOpsScenario :> BaseBlackBoxConOpsScenario {
            // step1 ~ step5의 5-Tuple 속성을 도메인 상호작용에 맞게 재정의(:>>)
        }
    } // package DomainWG_Template_Skeleton
} // package LV1_BlackBox_ConOps_Scaffold
