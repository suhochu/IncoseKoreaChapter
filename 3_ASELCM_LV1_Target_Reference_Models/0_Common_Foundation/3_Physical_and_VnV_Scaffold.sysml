package LV1_Physical_and_VnV_Scaffold {
    doc
    /* [InKC LV1 공통 스캐폴드 패키지 - Stage 4: 물리 아키텍처 및 검증(V&V)]
     * Stage 3의 논리 화이트박스 SoI를 물리 컴포넌트로 실체화(allocate)하고,
     * 시스템 검증 케이스로 임무 요구사항 및 MOE 달성 여부를 검증(verify)하는 추상 메타모델.
     *
     * [설계 원칙]
     * 1. 논리 서브시스템은 최소 1개 물리 컴포넌트에 할당되어야 함 (논리-물리 추적성).
     * 2. 시스템 검증 케이스는 임무 요구사항(BaseMissionObjective)을 verify하고
     *    MOE의 평가값이 판정 제약(MOEAchievementConstraint)을 만족하는지 확인함.
     */

    private import ScalarValues::*;
    private import LV1_Logical_WhiteBox_Scaffold::*;
    private import LV1_BlackBox_ConOps_Scaffold::MissionAndMOEScaffold::*;

    // ---- 1. 물리 컴포넌트 (Physical Component) ----
    abstract part def BasePhysicalComponent {
        doc
        /* 논리 서브시스템이 실체화되는 물리 구성요소(HW/SW/조직/설비 등)의 추상 정의 */
        attribute componentName : String;
        attribute physicalSpecification : String [0..1];
    }

    // ---- 2. 물리 대상시스템 (논리 -> 물리 할당) ----
    abstract part def BasePhysicalSoI :> BaseWhiteBoxLogicalSoI {
        doc
        /* 논리 화이트박스 SoI를 물리 컴포넌트로 실체화한 SoI.
         * 하위 도메인은 physicalComponents를 구체 타입으로 재정의하고 할당을 세분화함.
         */
        part physicalComponents : BasePhysicalComponent [1..*];

        // 논리 서브시스템 -> 물리 컴포넌트 할당 (도메인에서 개별 쌍으로 세분화)
        allocate logicalSubsystems to physicalComponents;
    }

    // ---- 3. 시스템 검증 케이스 (System Verification Case) ----
    abstract verification def BaseSystemVerificationCase {
        doc
        /* 물리 SoI가 임무 요구사항을 달성하는지 MOE 기준으로 검증하는 표준 검증 케이스.
         * 하위 도메인은 검증 대상 MOE(moeUnderTest)와 평가 방법을 구체화함.
         */
        subject systemUnderTest : BasePhysicalSoI;

        // 검증 대상 MOE 및 판정 제약 (방향성은 MOEMetric.direction에 따라 결정됨)
        in attribute moeUnderTest : MOEMetric;
        constraint moeCheck : MOEAchievementConstraint {
            in :>> moe = moeUnderTest;
        }

        objective moeVerificationObjective {
            doc
            /* 임무 요구사항의 MOE가 한계값 기준을 만족함을 검증 */
            verify requirement missionRequirement : BaseMissionObjective;
        }
    }
} // package LV1_Physical_and_VnV_Scaffold
