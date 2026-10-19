package StakeholderDefinitions {
    private import ScalarValues::*;

    doc
    /* SoI 내부 구성요소로서의 회원 및 기타 이해관계자 정의 */

    enum def GiveResourceKind {
        knowledgeSharing; // 지식/경험 공유
        operationsSupport; // 운영/행정 지원
        toolExpertise; // 툴/실습 역량
        networking; // 네트워크/섭외
        other;
    }

    enum def PeerSocietyKind {
        kosse;
        kcose;
        other;
    }

    // ---- 내부 이해관계자 간 교환 아이템 및 포트 ----
    item def NeedRequestItem {
        doc
        /* Member → Chapter */
        attribute needText : String;
    }

    item def GiveResourceItem {
        doc
        /* Chapter → Member */
        attribute resourceType : GiveResourceKind;
        attribute detail : String [0..1];
    }

    port def NeedPort { out item needRequestOut : NeedRequestItem; }
    port def GivePort { out item giveResourceOut : GiveResourceItem; }

    // ---- 이해관계자 (내부 구성요소) ----
    part def Member {
        // [설문1] 기본 인적 사항 및 소속

        // ---- Enum 정의: 주요 산업 도메인 ----
        enum def DomainKind {
            defenseAndAerospace; // 방위산업 / 항공우주
            automotiveAndMobility; // 모빌리티 / 자동차 / 자율주행
            railInfrastructureAndEnergy; // 철도 / 인프라 / 플랜트
            biomedicalAndHealthcare; // 의료기기 / 헬스케어
            itAndSoftware; // IT / 소프트웨어 시스템
            academiaAndResearch; // 학계 / 연구소
            other; // 기타
        }

        // ---- Enum 정의: 거주 및 주요 활동 지역 ----
        enum def RegionKind {
            seoul; // 서울
            gyeonggiIncheon; // 경기 / 인천
            daejeonSejongChungcheong; // 대전 / 세종 / 충청
            daeguGyeongbuk; // 대구 / 경북
            busanUlsanGyeongnam; // 부산 / 울산 / 경남
            gwangjuJeolla; // 광주 / 전라
            gangwon; // 강원
            jeju; // 제주
            other; // 기타
        }

        attribute name : String;
        attribute email : String [0..*];
        attribute affiliation : String [0..1];
        attribute position : String [0..1];
        attribute phoneNumber : String [0..1];
        attribute region : RegionKind [0..*];
        attribute domain : DomainKind [0..*];
        attribute domainOther : String [0..1];
        attribute preferredActivity : String [0..*];
        attribute expectation : String [0..1];
    }

    part def PeerSociety {
        doc
        /* 국내 타 학회. KOSSE/KCOSE 등. */
        attribute peerSocietyKind : PeerSocietyKind;
    }

    part def PeerSocietyMember :> Member {
        doc
        /* KOSSE/KCOSE 등 국내 타 학회 회원. 역량 뷰포인트 비교 대상. */
        attribute affiliatedSociety : String;
    }

    // ---- Enum 정의: 설문 2 요구사항 관련 ----

    enum def OnlineExchangeKind {
        seminar; // 세미나/특강형
        caseStudy; // 케이스 스터디형
        projectLab; // 프로젝트 실습형
        literatureReading; // 문헌 리딩형
        other;
    }

    enum def ITPlatformKind {
        notion; // Notion
        slackDiscord; // Slack / Discord
        googleWorkspace; // Google Workspace
        other;
    }

    enum def SecurityRuleKind {
        anonymizeData; // 가상값 치환
        noCompanyProjectNames; // 회사명/프로젝트명 비언급
        internalOnly; // 챕터 내부 공유 한정
        noRecording; // 녹화/캡처 금지
        none; // 특별히 필요 없음
        other;
    }

    // ---- Member Part Def (설문 1 + 설문 2 GtWR 특성 기반 업데이트) ----
    part def IncoseKoreaChapterMember :> Member {
        // [설문2] GtWR C2 - Appropriate (적절성)
        attribute interestKeyword : String [0..3];

        // [설문2] GtWR C1, C3, C5, C9 - What (기능적 요구사항)
        attribute coreValueWhat : String [0..*];

        // [설문2] GtWR C8 - Correct (요구사항 근거/Rationale)
        attribute rationale : String [0..*];

        // [설문2] GtWR C7 - Verifiable (검증가능성/Validation)
        attribute validationCriterion : String [0..*];

        // [설문2] 우선순위 (Priority)
        attribute priority : String [0..*];

        // [설문2] GtWR C6 - Feasible (실현가능성/가용 자원)
        attribute giveResource : GiveResourceKind [0..*];
        attribute giveDetail : String [0..1];

        // [설문2] GtWR C4 - Complete (완전성/운영 제약조건)
        attribute operationalConstraint : String [0..*];

        // [설문2] 생태계 통합 및 운영 개념
        attribute externalDependency : String [0..1]; // Interfaces
        attribute preferredOnlineExchange : OnlineExchangeKind [0..*]; // ConOps
        attribute preferredITPlatform : ITPlatformKind [0..*]; // IT 인프라
        attribute lifecycleTransitionCondition : String [0..1]; // Lifecycle
        attribute securityRule : SecurityRuleKind [0..*]; // Risk & Security
        attribute securityRuleOther : String [0..1];

        // [설문2] GtWR C1 - Necessary (고유 가치/Capability)
        attribute uniqueCapability : String [0..1];
    }
} // package StakeholderDefinitions
