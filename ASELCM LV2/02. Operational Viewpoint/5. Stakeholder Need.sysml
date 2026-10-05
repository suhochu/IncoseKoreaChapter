package Stakeholders_Needs {
    doc
    /* Chapter Requirements — 통합된 SystemContext 및 Stakeholders 모델을 
     * 기반으로 한 회원 요구사항(Member Needs) 및 보안 규칙(Security Rules) 정의 
     */

    private import ScalarValues::*;
    
    // 앞서 통합한 모듈에서 이해관계자와 시스템 대상을 가져옴
    private import Stakeholders::*;
    private import SystemContext::*;

    // ==========================================
    // 1. Member Needs (회원 요구사항)
    // ==========================================
    package MemberNeeds {
        doc /* 회원들의 핵심 니즈와 가치 도출 근거를 담은 요구사항 세트 */

        requirement def MemberNeedRequirement {
            doc
            /* 구글 폼 문항7 "얻고 싶은 것 하나" 작성 템플릿을 옮기는 요구사항 정의.
             * GtWR(Guide to Writing Requirements) C1,C3,C5,C9 확인 대상.
             */
            subject chapter : KoreaChapter; // 앞서 정의한 SoI
            actor member : Member;          // 앞서 정의한 내부 이해관계자
            
            attribute rationale : String;           // 문항8: 도출 근거 (Why, C8)
            attribute validationCriterion : String; // 문항9: 타당성 확인 기준 (Validation, C7)
            attribute priority : Natural [0..1];    // 문항10: 우선순위 (세트 조율용)
        }

        // ---- 예시 인스턴스 (취합 분석 전 가상 데이터) ----
        part exampleMember1 : Member {
            doc /* 실무자 예시 인스턴스 */
            attribute :>> domain = "사내 MBSE 툴 전환 기획 담당";
            attribute :>> interestKeyword = ("MBSE 실무 적용", "요구사항 추적성 관리");
        }

        requirement exampleMbseMigrationReferenceNeed : MemberNeedRequirement {
            doc /* 문항7 실무자 예시 응답의 형식적 변환 예시 */
            subject chapter = incoseKoreaChapterContext.chapter; 
            actor member = exampleMember1;
            
            attribute :>> rationale = "타 도메인 마이그레이션 레퍼런스 부재로 사내 MBSE 도입이 정체되어 있음";
            attribute :>> validationCriterion = "실무에 바로 적용 가능한 SysML 모델 템플릿 1종 확보";
            attribute :>> priority = 1;
        }
    }

    // ==========================================
    // 2. Security Rules (보안 및 리스크 규칙)
    // ==========================================
    package SecurityRules {
        doc /* 리스크/보안 뷰포인트의 모델 규칙(Rule)으로 직접 채택되는 제약사항 세트 */

        requirement def KnowledgeSharingSecurityRequirement {
            doc
            /* 문항18 체크박스 응답 — 지식공유 시 준수할 최소 규칙.
             * 소속 기업의 지적 재산(IP)이나 민감 정보를 보호하기 위한 안전 장치.
             */
            subject chapter : KoreaChapter;
            
            attribute maskRealData : Boolean;       // 가상값(A,B,C 등) 치환
            attribute omitCompanyName : Boolean;    // 회사명/프로젝트명 비언급
            attribute internalShareOnly : Boolean;  // 내부 공유 한정
            attribute noRecording : Boolean;        // 녹화/캡처 금지
        }
    }
}