package ChapterStructure {
    doc
    /* Chapter Structure — SoI(Chapter) 및 Stakeholder를 뒷받침하는 Part */

    private import ScalarValues::*;

    enum def ChapterCharterStatusKind {
        emerging; // INCOSE Board 기준 최소 회원수 등 요건 미충족 상태
        chartered; // INCOSE Board 승인 완료, 정식 Chapter로 인가된 상태
    }

    part def Chapter {
        doc
        /* System of Interest: INCOSE Korea Chapter 그 자체.
         * 회원(Member)은 External Actor가 아닌 이 시스템의 내부
         * 구성요소(Internal Part)로 취급됨. charterStatus는 INCOSE
         * Board of Directors가 관장하는 공식 인가 상태(출처: INCOSE
         * Board Operations Manual — "emerging" 지위는 최소 회원수 등
         * 기준 미충족 시 부여, 기준 충족 후 Board 승인으로 정식
         * "chartered" Chapter가 됨). 현재는 emerging 상태로 가정.
         */
        attribute charterStatus : ChapterCharterStatusKind = ChapterCharterStatusKind::emerging;
        part member : Stakeholders::Member [1..*];
    }

    package Stakeholders {
        enum def GiveResourceKind {
            knowledgeSharing; // 지식/경험 공유 (아티클 번역, 실패담 등)
            operationsSupport; // 운영/행정 지원 (회의록, 플랫폼 관리 등)
            toolExpertise; // 툴/실습 역량 (Cameo, SysML v2 실습 리드)
            networking; // 네트워크/섭외 (발표자 섭외, 장소 협조)
        }

        item def NeedRequestItem {
            doc
            /* 문항7·8·9 응답이 흐르는 아이템: Member → Chapter */
            attribute needText : String;
        }

        item def GiveResourceItem {
            doc
            /* 문항11·12 응답이 흐르는 아이템: Member → Chapter */
            attribute resourceType : GiveResourceKind;
            attribute detail : String [0..1];
        }

        port def NeedPort {
            out item needRequestOut : NeedRequestItem;
        }

        port def GivePort {
            out item giveResourceOut : GiveResourceItem;
        }

        part def Member {
            doc
            /* INCOSE Korea Chapter 회원. 구글 폼 섹션 2·4 응답이
             * 이 part의 속성/포트로 귀속됨.
             */
            attribute name : String; // 문항2
            attribute email : String; // 문항3
            attribute affiliation : String; // 문항4
            attribute position : String; // 문항4-1 (소속 내 직위)
            attribute phoneNumber : String [0..1]; // 문항4-2 (소속 내 직위)
            attribute domain : String; // 문항5
            attribute interestKeyword : String [0..3]; // 문항6
            attribute giveResource : GiveResourceKind [0..*]; // 문항11
            attribute giveDetail : String [0..1]; // 문항12
            attribute operationalConstraint : String [0..*]; // 문항13

            port needPort : NeedPort;
            port givePort : GivePort;
        }

        enum def PeerSocietyKind {
            kosse;
            kcose;
            other;
        }

        part def PeerSociety {
            doc
            /* 국내 타 학회. KOSSE/KCOSE 등. */
            attribute peerSocietyKind : PeerSocietyKind;
        }

        part def PeerSocietyMember :> Member {
            doc
            /* KOSSE/KCOSE 등 국내 타 학회 회원. 회원 자격은 챕터와
             * 독립적이나, 8번(역량) 뷰포인트에서 비교 대상으로 참조됨.
             */
            attribute affiliatedSociety : String;
        }

        part def ToolVendor {
            doc
            /* Cameo 등 MBSE 툴 벤더. 컨텍스트 뷰포인트의 외부
             * 의존성 액터 (문항14).
             */
            attribute toolName : String;
            attribute licenseRequired : Boolean;
        }

        part def INCOSESector {
            doc
            /* INCOSE Asia-Oceania Sector (Sector III). 챕터의
             * 직속 상위 시스템(Supersystem)이며 운용 뷰포인트에서
             * 보고 대상이 됨. Sector 자체는 INCOSE Board of
             * Directors 산하(Director, Asia-Oceania Sector III)에
             * 있으나, 이는 본 SoI 경계 밖의 정보로 간주하여 Chapter가
             * 직접 연결하지는 않음. (출처: incose.org 조직/리더십 페이지)
             */
        }

        part def INCOSE;
    } // package Stakeholders

    package Constraints {
        private import Stakeholders::*;

        constraint def OperationalConstraintCheck {
            doc
            /* 문항13 "개인 제약" 응답 취합용. 개별 완전성(C4)이
             * 아니라 세트 차원에서 빠진 경계 조건을 채우는 것이므로
             * C10(세트의 완전성) 근거자료로 취급.
             */
            attribute constraintText : String;
        }

        constraint def ExternalDependencyCheck {
            doc
            /* 문항14 "외부 의존성/전제조건" 응답 취합용. */
            attribute dependencyText : String;
        }
    } // package Constraints

    package KnowledgeStore {
        doc
        /* 문항16 IT 플랫폼 응답에 기반한 지식 저장 구조. IT 플랫폼
         * 확정 이후(킥오프 직후) 별도 워크숍에서 폴더/스키마를
         * 구체화하는 것이 현실적이며, 폼만으로는 완전히 채워지지 않음.
         */

        enum def PlatformKind {
            notion;
            slackOrDiscord;
            googleWorkspace;
            other;
        }

        enum def ArtifactCategoryKind {
            translatedArticle; // 번역 아티클
            sysmlDiagram; // SysML 다이어그램
            meetingMinutes; // 회의록
            requirementRecord; // 요구사항 기록
        }

        item def ChapterArtifact {
            attribute title : String;
            attribute category : ArtifactCategoryKind;
            attribute owner : String;
        }

        part def KnowledgeRepository {
            doc
            /* Single Source of Truth. */
            attribute platform : PlatformKind;
            part artifact : ChapterArtifact [0..*];
        }
    } // package KnowledgeStore

    part theChapter : Chapter;
} // package ChapterStructure
