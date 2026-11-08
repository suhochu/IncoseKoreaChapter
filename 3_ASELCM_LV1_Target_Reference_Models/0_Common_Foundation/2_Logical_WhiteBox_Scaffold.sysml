package LV1_Logical_WhiteBox_Scaffold {
    doc
    /* [InKC LV1 공통 스캐폴드 패키지 - Stage 3: 논리 화이트박스]
     * Stage 2(블랙박스/ConOps)에서 정의한 대상시스템(SoI)을 상속받아
     * 내부 논리 서브시스템과 논리 기능으로 분해(Decomposition)하고,
     * 논리 기능을 논리 서브시스템에 할당(allocate)하는 추상 메타모델.
     *
     * [설계 원칙]
     * 1. 블랙박스 경계(포트)는 BaseBlackBoxSoI로부터 그대로 상속하여 외부 인터페이스를 보존함.
     * 2. 논리 계층은 Solution-Free: 구체적 HW/SW 구현 대신 역할 중심의 논리 요소만 정의함.
     * 3. 모든 논리 기능은 최소 1개 논리 서브시스템에 할당되어야 함 (기능-구조 추적성).
     */

    private import ScalarValues::*;
    private import LV1_BlackBox_ConOps_Scaffold::*;
    private import LV1_BlackBox_ConOps_Scaffold::BlackBoxContextScaffold::*;

    // ---- 1. 논리 기능 (Logical Function) ----
    abstract action def BaseLogicalFunctionAction {
        doc
        /* 대상시스템 내부에서 수행되는 논리 기능의 추상 정의.
         * 블랙박스 ConOps 시나리오 스텝의 SoI 반응을 내부 기능 수준으로 구체화함.
         */
        attribute functionName : String;
        attribute functionDescription : String [0..1];
        in item functionInput : BaseBoundaryExchangeItem [0..*];
        out item functionOutput : BaseBoundaryExchangeItem [0..*];
    }

    // ---- 2. 논리 서브시스템 (Logical Subsystem) ----
    abstract part def BaseLogicalSubsystem {
        doc
        /* 대상시스템을 구성하는 논리적 서브시스템(역할 단위)의 추상 정의.
         * 물리적 구현 기술을 가정하지 않으며, 물리 요소로의 할당은 Stage 4에서 수행함.
         */
        attribute subsystemName : String;
        attribute logicalResponsibility : String [0..1];
    }

    // ---- 3. 화이트박스 논리 대상시스템 ----
    abstract part def BaseWhiteBoxLogicalSoI :> BaseBlackBoxSoI {
        doc
        /* 블랙박스 SoI의 경계 포트를 유지한 채 내부를 논리 서브시스템과 논리 기능으로 분해한 화이트박스 SoI.
         * 하위 도메인은 logicalSubsystems / logicalFunctions를 구체 타입으로 재정의(:>>)하고
         * 기능-서브시스템 할당을 구체화함.
         */
        part logicalSubsystems : BaseLogicalSubsystem [1..*];
        perform action logicalFunctions : BaseLogicalFunctionAction [1..*];

        // 논리 기능 -> 논리 서브시스템 할당 (도메인에서 개별 기능/서브시스템 쌍으로 세분화)
        allocate logicalFunctions to logicalSubsystems;
    }
} // package LV1_Logical_WhiteBox_Scaffold
