package Stakeholders {
    private import ScalarValues::*;

    doc
    /* SoI 내부 구성요소로서의 회원 및 기타 이해관계자 정의 */

    enum def GiveResourceKind {
        knowledgeSharing; // 지식/경험 공유
        operationsSupport; // 운영/행정 지원
        toolExpertise; // 툴/실습 역량
        networking; // 네트워크/섭외
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
        doc
        /* INCOSE Korea Chapter 회원. 
         * External Actor가 아닌 이 시스템의 내부 구성요소(Internal Part)로 취급됨.
         */
        attribute name : String;
        attribute email : String;
        attribute affiliation : String;
        attribute position : String;
        attribute phoneNumber : String [0..1];
        attribute domain : String;
        attribute interestKeyword : String [0..3];
        attribute giveResource : GiveResourceKind [0..*];
        attribute giveDetail : String [0..1];
        attribute operationalConstraint : String [0..*];

        port needPort : NeedPort;
        port givePort : GivePort;
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
} // package Stakeholders
