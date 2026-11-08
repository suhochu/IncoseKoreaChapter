package ExternalActorsAndInterfaces {
    doc
    /* 외부 환경(Context)의 액터 정의 및 교환 인터페이스 */
    private import ScalarValues::*;

    // ---- 2.1 교환 아이템 (External Items) ----
    item def ToolLicenseInfoItem {
        doc
        /* Cameo 툴 라이선스 보유 전제 */
        attribute toolName : String;
        attribute licenseStatus : String;
    }

    item def SectorActivityReportItem {
        doc
        /* INCOSE Asia-Oceania Sector로의 활동 보고 (활동 결과 반영) */
        attribute periodLabel : String;
        attribute summary : String;
    }

    item def HandbookResourceItem {
        doc
        /* Technical Operations 산하 Working Group 표준 산출물 (SE Handbook 등) */
        attribute publicationTitle : String;
        attribute version : String;
    }

    item def SponsorshipItem {
        doc
        /* CAS(Chapter Affiliation Sponsor)가 제공하는 후원 자원 */
        attribute sponsorName : String;
        attribute supportType : String;
    }

    item def PeerBenchmarkItem {
        doc
        /* 타 학회 대비 차별점 비교를 위한 조직 레벨 정보 교환 */
        attribute topic : String;
        attribute note : String;
    }

    // ---- 2.2 Chapter 측 경계 포트 (기준 포트) ----
    // 외부 액터 측은 별도 포트를 중복 정의하지 않고 켤레 포트(~)로 대칭성을 보장한다.
    port def ChapterToolInterfacePort { in item toolLicenseInfoIn : ToolLicenseInfoItem; }
    port def ChapterSectorInterfacePort { out item activityReportOut : SectorActivityReportItem; }
    port def ChapterTechOpsInterfacePort { in item handbookResourceIn : HandbookResourceItem; }
    port def ChapterSponsorInterfacePort { in item sponsorshipIn : SponsorshipItem; }
    port def ChapterPeerInterfacePort {
        out item peerBenchmarkOut : PeerBenchmarkItem;
        in item peerBenchmarkIn : PeerBenchmarkItem;
    }

    // ---- 2.3 경계 외부 액터 (Context Actors) ----
    part def ContextToolVendor {
        doc
        /* Cameo 등 MBSE 툴 벤더 (외부 의존성 액터). 기존 ToolVendor 속성 통합. */
        attribute toolName : String;
        attribute licenseRequired : Boolean;
        port vendorInterface : ~ChapterToolInterfacePort;
    }

    part def ContextINCOSESector {
        doc
        /* INCOSE Asia-Oceania Sector (Sector III). 운용 뷰포인트 보고 대상. */
        port sectorInterfaceOut : ~ChapterSectorInterfacePort;
    }

    part def ContextTechnicalOperations {
        doc
        /* 50개 이상의 WG 총괄 및 SE Handbook 배포. 문헌 리딩형 활동의 원천. */
        port techOpsInterfaceOut : ~ChapterTechOpsInterfacePort;
    }

    part def ContextChapterAffiliationSponsor {
        doc
        /* 계약 기반 후원 조직(CAS). Phase 1에서는 미고려(조건부). */
        port sponsorInterfaceOut : ~ChapterSponsorInterfacePort;
    }

    part def ContextPeerSocietyOrganization {
        doc
        /* KOSSE/KCOSE 등 조직 대 조직 인터페이스. Phase 1 비활성. */
        port peerOrgInterfaceOut : ~ChapterPeerInterfacePort;
    }
} // package ExternalActorsAndInterfaces
