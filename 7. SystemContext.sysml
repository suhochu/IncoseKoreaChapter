package SystemContext {
    private import ChapterStructure::*;
    private import ChapterStructure::Stakeholders::*;
    private import ScalarValues::*;

    doc
    /* Base Architecture 단계의 System Context(시스템 경계) 정의 — v3.
     * 웹 조사(incose.org 조직/리더십, Board/Operations Manual) 및
     * 이중윤 교수님 코멘트(2026)를 반영해 외부 액터를 5종으로 확장.
     *
     * 경계 내부(Internal): Member, KnowledgeRepository — 이미
     * ChapterStructure에서 Chapter의 part로 선언되어 있음.
     *
     * 경계 외부(External Context) — 활성(Phase 1, 현재 연결):
     *   1) ToolVendor — Cameo 등 MBSE 툴 라이선스 (문항14)
     *   2) INCOSESector (Asia-Oceania, Sector III) — 활동 보고.
     *      교수님 지침: "챕터 자체 IT 플랫폼 사용은 무방하나 활동
     *      결과는 INCOSE Korea 챕터 활동으로 반영 필요" → 기존
     *      activityReport 인터페이스가 정확히 이 요구를 형식화함.
     *   3) TechnicalOperations (Working Groups) — SE Handbook 등
     *      표준 산출물 배포. 섹션5 ConOps "문헌 리딩형" 활동의
     *      실제 원천(source)이 되는 외부 의존성으로, 기존 모델에서
     *      누락되어 있었음.
     *
     * 경계 외부(External Context) — 조건부(Phase 2 이후, 현재 미연결):
     *   4) ChapterAffiliationSponsor(CAS) — INCOSE 공식 용어. 교수님
     *      지침: "스폰서가 있으면 좋겠으나 현재는 특별히 고려하지
     *      않음" → [0..1]로 선언만 하고 connect는 보류.
     *      ChapterLifecycle의 Phase1→Phase2 전환 조건과 연동.
     *   5) PeerSocietyOrganization(KOSSE/KCOSE, 조직 레벨) — 교수님
     *      지침: "회원 개개인의 가치 구현이 먼저, 학회/협회로의
     *      확산 방법은 그 다음" → 개별 회원 차원의
     *      Stakeholders::PeerSocietyMember(기존 유지)와는 별개로,
     *      조직 대 조직 인터페이스이므로 [0..1]로 선언만 하고
     *      connect는 보류.
     *
     * 참고(비연결, 정보 제공용): 이사회(Board of Directors)는
     * Sectors/Chapters, Technical Operations, CAB(Corporate
     * Advisory Board — 산업계 및 학계 조직이 함께 참여하는 자문
     * 기구, "Voice of the Customer") 세 기능 축을 총괄함. CAB는
     * 현재 Chapter가 직접 인터페이스하지 않으나, 8번(역량) 뷰포인트가
     * 성숙해 산업/학계 협력이 필요해지면 후보 경로가 됨. Board 자체도
     * 본 SoI 경계 밖이므로 별도 part로 연결하지 않음.
     */

    // ---- 외부 컨텍스트 교환 아이템 ----
    item def ToolLicenseInfoItem {
        doc
        /* 문항14 "Cameo 툴 라이선스 보유 전제" 응답에 대응 */
        attribute toolName : String;
        attribute licenseStatus : String;
    }

    item def SectorActivityReportItem {
        doc
        /* 운용 뷰포인트의 External Item Flow에 대응 —
         * INCOSE Asia-Oceania Sector로의 활동 보고. 교수님 지침
         * "활동 결과는 INCOSE Korea 챕터 활동으로 반영 필요"의
         * 형식적 반영.
         */
        attribute periodLabel : String;
        attribute summary : String;
    }

    item def HandbookResourceItem {
        doc
        /* INCOSE Technical Operations 산하 Working Group이 생산하는
         * SE Handbook 등 표준 산출물. 섹션5 "문헌 리딩형" 활동의
         * 원천. (출처: incose.org/communities — "Working Groups are
         * the engines of INCOSE's technical output")
         */
        attribute publicationTitle : String;
        attribute version : String;
    }

    item def SponsorshipItem {
        doc
        /* Chapter Affiliation Sponsor(CAS)가 제공하는 후원 자원.
         * (출처: INCOSE Operations Manual — CAS는 계약 기반 후원
         * 조직) 교수님 지침에 따라 현재는 비활성.
         */
        attribute sponsorName : String;
        attribute supportType : String;
    }

    item def PeerBenchmarkItem {
        doc
        /* 역량 뷰포인트(문항19) "타 학회 대비 차별점" 비교를 위한
         * 조직 레벨 정보 교환 아이템. 교수님 지침에 따라 현재는
         * 비활성(회원 가치 구현이 선행 과제).
         */
        attribute topic : String;
        attribute note : String;
    }

    // ---- Chapter 측 경계 포트 ----
    port def ChapterToolInterfacePort {
        in item toolLicenseInfoIn : ToolLicenseInfoItem;
    }

    port def ChapterSectorInterfacePort {
        out item activityReportOut : SectorActivityReportItem;
    }

    port def ChapterTechOpsInterfacePort {
        in item handbookResourceIn : HandbookResourceItem;
    }

    port def ChapterSponsorInterfacePort {
        in item sponsorshipIn : SponsorshipItem;
    }

    port def ChapterPeerInterfacePort {
        out item peerBenchmarkOut : PeerBenchmarkItem;
        in item peerBenchmarkIn : PeerBenchmarkItem;
    }

    // ---- 외부 시스템 측 대응 포트 ----
    port def VendorChapterInterfacePort {
        out item toolLicenseInfoOut : ToolLicenseInfoItem;
    }

    port def SectorChapterInterfacePort {
        in item activityReportIn : SectorActivityReportItem;
    }

    port def TechOpsChapterInterfacePort {
        out item handbookResourceOut : HandbookResourceItem;
    }

    port def SponsorChapterInterfacePort {
        out item sponsorshipOut : SponsorshipItem;
    }

    port def PeerChapterInterfacePort {
        in item peerBenchmarkIn : PeerBenchmarkItem;
        out item peerBenchmarkOut : PeerBenchmarkItem;
    }

    // ---- Base Architecture 경계 포트가 추가된 Chapter (SoI) ----
    part def ChapterInContext :> KoreaChapter {
        doc
        /* Base Architecture 단계에서 외부 컨텍스트 포트 5종이
         * 추가된 Chapter 정의. Member는 여전히 내부 part로 유지됨
         * (경계 내부). sponsorInterface·peerInterface는 [0..1]로
         * 선언되어 있으나 Phase 1(현재)에는 인스턴스가 없음.
         */
        port toolInterface : ChapterToolInterfacePort;
        port sectorInterface : ChapterSectorInterfacePort;
        port techOpsInterface : ChapterTechOpsInterfacePort;
        port sponsorInterface : ChapterSponsorInterfacePort [0..1];
        port peerInterface : ChapterPeerInterfacePort [0..1];
    }

    // ---- 경계 외부 액터 (Context 요소) — 활성(Phase 1) ----
    part def ContextToolVendor :> ToolVendor {
        port vendorInterface : VendorChapterInterfacePort;
    }

    part def ContextINCOSESector :> INCOSESector {
        port sectorInterfaceOut : SectorChapterInterfacePort;
    }

    part def ContextTechnicalOperations {
        doc
        /* INCOSE Technical Operations. 50개 이상의 Working Group을
         * 총괄하며 SE Handbook 등 표준 산출물을 배포. (출처:
         * incose.org/communities) Board of Directors 산하의 별도
         * 기능 축(Director, Technical Operations)으로, Sector와는
         * 독립적인 경로.
         */
        port techOpsInterfaceOut : TechOpsChapterInterfacePort;
    }

    // ---- 경계 외부 액터 (Context 요소) — 조건부(Phase 2 이후) ----
    part def ContextChapterAffiliationSponsor {
        doc
        /* INCOSE 공식 용어 "Chapter Affiliation Sponsor(CAS)":
         * 계약 기반으로 챕터를 후원하는 조직. (출처: INCOSE
         * Operations Manual) 교수님 지침에 따라 Phase 1(현재)에는
         * 고려하지 않으며, ChapterLifecycle의 Phase1→Phase2 전환과
         * 연동되는 조건부 액터.
         */
        port sponsorInterfaceOut : SponsorChapterInterfacePort;
    }

    part def ContextPeerSocietyOrganization {
        doc
        /* KOSSE/KCOSE를 개별 회원(Stakeholders::PeerSocietyMember)이
         * 아닌 "조직 대 조직" 레벨로 표현. 교수님 지침: 회원 가치
         * 구현이 선행 과제이며, 학회/협회로의 확산 인터페이스는
         * 그 이후 논의 대상이므로 Phase 1에는 비활성.
         */
        port peerOrgInterfaceOut : PeerChapterInterfacePort;
    }

    // ---- Base Architecture Baseline: System Context 구성 ----
    part incoseKoreaChapterContext {
        doc
        /* 10월 킥오프 baseline 기준 System Context 인스턴스.
         * cameoVendor·incoseSector·technicalOperations는 활성
         * 연결(Phase 1). sponsor·peerSociety는 [0..1]로 선언만
         * 하고 connect는 보류 — Phase 2 진입(ChapterLifecycle
         * 전환) 후 인스턴스화 및 connect 추가 예정.
         */
        part chapter : ChapterInContext;
        part cameoVendor : ContextToolVendor;
        part incoseSector : ContextINCOSESector;
        part technicalOperations : ContextTechnicalOperations;
        part sponsor : ContextChapterAffiliationSponsor [0..1];
        part peerSociety : ContextPeerSocietyOrganization [0..1];

        connect chapter.toolInterface to cameoVendor.vendorInterface;
        connect chapter.sectorInterface to incoseSector.sectorInterfaceOut;
        connect chapter.techOpsInterface to technicalOperations.techOpsInterfaceOut;
        // 아래 두 연결은 Phase 2 진입 후 sponsor/peerSociety 인스턴스가
        // 생기면 추가한다 (현재는 [0..1] = 0개 상태, connect 없음):
        //   connect chapter.sponsorInterface to sponsor.sponsorInterfaceOut;
        //   connect chapter.peerInterface to peerSociety.peerOrgInterfaceOut;
    }
} // package SystemContext
