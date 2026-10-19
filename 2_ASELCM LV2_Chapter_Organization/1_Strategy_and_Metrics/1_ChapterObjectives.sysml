package ChapterObjectives {
    doc
    /* [목표(Goal) 뷰포인트]
     * INCOSE Korea Chapter 프로젝트가 존재하는 근본적인 이유를 정의한다.
     * 어떤 문제(Problem Statement)를 풀기 위해 어떤 시스템 아이디어(System Idea)를 
     * 제안하는지를 최상위 요구사항 계층으로 표현한다.
     */

    requirement def Objective {
        doc
        /* 프로젝트의 근본적인 문제 정의(Problem Statement), 
         * 시스템 아이디어(System Idea), 
         * 그리고 비즈니스 목표를 모델링하는 최상위 요구사항 타입
         */
    }

    // ==========================================
    // 1. Objective (목적)
    // ==========================================
    requirement def ChapterObjective :> Objective {
        doc
        /* 1. INCOSE Korea Chapter는 단순한 이론적 스터디(싱크탱크)를 넘어, 실질적인 산출물을 직접 도출하는 'Do-Tank' 방식으로 조직을 재활성화하여 시스템 엔지니어링(SE)의 현장 적용을 극대화하는 것을 목적으로 한다.
         * 2. 산업계 실무자들이 현업에 즉시 적용하고 활용할 수 있는 구체적이고 실용적인 도메인별(자동차, 우주 등) 시스템 엔지니어링 레퍼런스 모델(창조 모델)을 공동으로 개발한다.
         * 3. (선택적 목표) SysML v2에 관심이 있는 회원들의 경우, SysML v2의 Formal Language 특성을 활용해 요구사항 설계부터 시뮬링크(Simulink) 등을 통한 오토코드 제너레이션까지 이어지는 End-to-End 추적성을 구현하고, 이를 통해 SE의 실효성을 리더십과 경영진에게 시각적으로 입증하는 것을 세부 목표로 삼는다.
         */
    }

    // ==========================================
    // 2. Problem Statement (문제 정의)
    // ==========================================
    requirement def ChapterProblemStatement :> Objective {
        doc
        /* 1. 전 세계적으로 시스템 엔지니어링의 중요성과 관련 인구가 증가하는 추세와 달리, 국내 SE 전문 인력은 지속적으로 감소하는 구조적인 역행을 겪고 있다.
         * 2. 국내 인력 감소와 SE 적용 실패의 근본적인 원인은 교육을 이수하더라도 "실무에서 직접적인 효과를 체감하지 못한다"는 점과, 업무에 적용하려 해도 참고할 만한 '구체적이고 실용적인 레퍼런스'가 철저히 부재하다는 데 있다.
         * 3. 실제 자동차 전장 및 에어 서스펜션 등 현업에서는 다수의 국제 표준(ISO 26262, ASPICE, 사이버시큐리티 등) 준수를 위해 SE 방법론이 강제되나, 아키텍처 및 요구사항 문서가 최종 제품의 품질 향상과 연결되지 못하고 '보여주기식 요식 행위'로 전락하여 프로젝트마다 기술적 부채가 누적되는 악순환이 반복되고 있다.
         */
    }

    // ================================================
    // 3. System Idea / Elevator Pitch (시스템 아이디어)
    // ================================================
    requirement def ChapterSystemIdea :> ChapterProblemStatement {
        doc
        /* 1. "현장의 문제를 직접 해결하는 시스템 엔지니어링 실전 랩(Lab), INCOSE Korea 'Do-Tank' 챕터".
         * 2. 자동차 도메인의 SDV(Software Defined Vehicle) 전체 관점과 우주 도메인의 미션 시스템 전체를 대상으로 삼아, 운영자 요구사항(Operational Stakeholder Requirement)부터 소프트웨어 코드 자동 생성까지 완벽하게 이어지는 SysML v2 기반의 엔드투엔드(End-to-End) 레퍼런스 모델을 직접 구축한다.
         * 3. 완성된 이 '모범 사례(Best Practice)'를 통해 리더십과 경영진을 설득하고, 성공 사례를 직접 경험한 실무진들이 주변으로 지식을 전파하는 상향식(Bottom-up) 확산을 통해 대한민국이 시스템 엔지니어링 분야의 패스트 무버(Fast Mover)로 도약하는 핵심 엔진 역할을 수행한다.
         */
    }
} // package ChapterObjectives
