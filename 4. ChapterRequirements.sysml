package ChapterRequirements {
    doc
    /* Chapter Requirements — 섹션3·5(문항18) 응답이 귀속되는 요구사항 세트 */

    private import ChapterStructure::*;
    private import ChapterStructure::Stakeholders::*;
    private import ScalarValues::*;

    package MemberNeeds {
        requirement def MemberNeedRequirement {
            doc
            /* 문항7 "얻고 싶은 것 하나" 작성 템플릿을 옮기는
             * 요구사항 정의. subject는 SoI(Chapter), actor는
             * 니즈를 제기한 Member. GtWR C1,C3,C5,C9 확인 대상.
             */
            subject chapter : Chapter;
            actor member : Member;
            attribute rationale : String; // 문항8 (C8)
            attribute validationCriterion : String; // 문항9 (C7)
            attribute priority : Natural [0..1]; // 문항10 (세트 조율용, GtWR 해당없음)
        }

        part exampleMember1 : Member {
            doc
            /* 예시 인스턴스 — 실제 회원 데이터 아님 */
            attribute :>> domain = "사내 MBSE 툴 전환 기획 담당";
            attribute :>> interestKeyword = ("MBSE 실무 적용", "요구사항 추적성 관리");
        }

        requirement exampleMbseMigrationReferenceNeed : MemberNeedRequirement {
            doc
            /* 문항7 실무자 예시 응답의 형식적 변환 예시 */
            subject chapter = ChapterStructure::theChapter;
            actor member = exampleMember1;
            attribute :>> rationale =
                "타 도메인 마이그레이션 레퍼런스 부재로 사내 MBSE 도입이 정체되어 있음";
            attribute :>> validationCriterion =
                "실무에 바로 적용 가능한 SysML 모델 템플릿 1종 확보";
            attribute :>> priority = 1;
        }
    } // package MemberNeeds

    package SecurityRules {
        requirement def KnowledgeSharingSecurityRequirement {
            doc
            /* 문항18 체크박스 응답 — 지식공유 시 준수할 최소 규칙.
             * 리스크/보안 뷰포인트의 모델 규칙(Rule)으로 직접 채택.
             */
            subject chapter : ChapterStructure::Chapter;
            attribute maskRealData : Boolean; // 가상값(A,B,C 등) 치환
            attribute omitCompanyName : Boolean; // 회사명/프로젝트명 비언급
            attribute internalShareOnly : Boolean; // 내부 공유 한정
            attribute noRecording : Boolean; // 녹화/캡처 금지
        }
    } // package SecurityRules
} // package ChapterRequirements
