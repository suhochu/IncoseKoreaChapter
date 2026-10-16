package StakeholdersNeeds {
    doc
    /* Chapter Requirements — 통합된 SystemContext 및 Stakeholders 모델을 
     * 기반으로 한 회원 요구사항(Member Needs) 및 보안 규칙(Security Rules) 정의
     */

    private import ScalarValues::*;
    private import Stakeholders::*;
    private import SystemContext::*;

    // ==========================================
    // 1. Member Needs (회원 요구사항)
    // ==========================================
    package ChapterMembers_Needs {
        private import ChapterMembers::*;

        doc
        /* 회원들의 핵심 니즈와 가치 도출 근거를 담은 요구사항 세트 */

        requirement def MemberNeedRequirement :> IncoseKoreaChapter_Objectives::ChapterSystemIdea {
            doc
            /* 구글 폼 문항7 "얻고 싶은 것 하나" 작성 템플릿을 옮기는 요구사항 정의.
             * GtWR(Guide to Writing Requirements) C1,C3,C5,C9 확인 대상.
             */
            subject chapter;
            actor member : IncoseKoreaChapterMember;

            attribute coreValueWhat : String [0..*]; // [추가] 문항7: 구체적인 요구사항 핵심 가치 (What)
            attribute rationale : String [0..*]; // 문항8: 도출 근거 (Why, C8)
            attribute validationCriterion : String [0..*]; // 문항9: 타당성 확인 기준 (Validation, C7)
            attribute priority : String [0..*]; // 문항10: 우선순위 (세트 조율용)
        }

        // --- 개별 회원 요구사항 Usage ---

        requirement lee_su_need : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'이수';
            attribute :>> coreValueWhat = ChapterMembers::'이수'.coreValueWhat;
            attribute :>> rationale = ChapterMembers::'이수'.rationale;
            attribute :>> validationCriterion = ChapterMembers::'이수'.validationCriterion;
            attribute :>> priority = ChapterMembers::'이수'.priority;
        }

        requirement park_sh_need : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'박승훈';
            attribute :>> coreValueWhat = ChapterMembers::'박승훈'.coreValueWhat;
            attribute :>> rationale = ChapterMembers::'박승훈'.rationale;
            attribute :>> validationCriterion = ChapterMembers::'박승훈'.validationCriterion;
            attribute :>> priority = ChapterMembers::'박승훈'.priority;
        }

        requirement lee_jy_need : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'이중윤';
            attribute :>> coreValueWhat = ChapterMembers::'이중윤'.coreValueWhat;
            attribute :>> rationale = ChapterMembers::'이중윤'.rationale;
            attribute :>> validationCriterion = ChapterMembers::'이중윤'.validationCriterion;
            attribute :>> priority = ChapterMembers::'이중윤'.priority;
        }

        requirement suh_es_need : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'서은석';
            attribute :>> coreValueWhat = ChapterMembers::'서은석'.coreValueWhat;
            attribute :>> rationale = ChapterMembers::'서은석'.rationale;
            attribute :>> validationCriterion = ChapterMembers::'서은석'.validationCriterion;
            attribute :>> priority = ChapterMembers::'서은석'.priority;
        }

        requirement chu_sh_need : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'추수호';
            attribute :>> coreValueWhat = ChapterMembers::'추수호'.coreValueWhat;
            attribute :>> rationale = ChapterMembers::'추수호'.rationale;
            attribute :>> validationCriterion = ChapterMembers::'추수호'.validationCriterion;
            attribute :>> priority = ChapterMembers::'추수호'.priority;
        }

        requirement ku_jm_need : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'구정모';
            attribute :>> coreValueWhat = ChapterMembers::'구정모'.coreValueWhat;
            attribute :>> rationale = ChapterMembers::'구정모'.rationale;
            attribute :>> validationCriterion = ChapterMembers::'구정모'.validationCriterion;
            attribute :>> priority = ChapterMembers::'구정모'.priority;
        }

        requirement kim_hj_need : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'김희재';
            attribute :>> coreValueWhat = ChapterMembers::'김희재'.coreValueWhat;
            attribute :>> rationale = ChapterMembers::'김희재'.rationale;
            attribute :>> validationCriterion = ChapterMembers::'김희재'.validationCriterion;
            attribute :>> priority = ChapterMembers::'김희재'.priority;
        }

        requirement kim_dw_need : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'김다운';
            attribute :>> coreValueWhat = ChapterMembers::'김다운'.coreValueWhat;
            attribute :>> rationale = ChapterMembers::'김다운'.rationale;
            attribute :>> validationCriterion = ChapterMembers::'김다운'.validationCriterion;
            attribute :>> priority = ChapterMembers::'김다운'.priority;
        }

        requirement park_hs_need : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'박홍석';
            attribute :>> coreValueWhat = ChapterMembers::'박홍석'.coreValueWhat;
            attribute :>> rationale = ChapterMembers::'박홍석'.rationale;
            attribute :>> validationCriterion = ChapterMembers::'박홍석'.validationCriterion;
            attribute :>> priority = ChapterMembers::'박홍석'.priority;
        }
    } // package ChapterMembers_Needs

    // ==========================================
    // 2. Security Rules (보안 및 리스크 규칙)
    // ==========================================
    package SecurityRules {
        doc
        /* 리스크/보안 뷰포인트의 모델 규칙(Rule)으로 직접 채택되는 제약사항 세트 */

        requirement def KnowledgeSharingSecurityRequirement {
            private import ChapterMembers::*;
            doc
            /* 문항18 체크박스 응답 — 지식공유 시 준수할 최소 규칙.
             * 소속 기업의 지적 재산(IP)이나 민감 정보를 보호하기 위한 안전 장치.
             */
            subject chapter;
            actor member : IncoseKoreaChapterMember;

            attribute securityRule : SecurityRuleKind [0..*];
            attribute securityRuleOther : String [0..1];
        }
        // --- 개별 회원 보안 규칙 Usage ---

        requirement lee_su_security : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'이수';
            attribute :>> securityRule = ChapterMembers::'이수'.securityRule;
            attribute :>> securityRuleOther = ChapterMembers::'이수'.securityRuleOther;
        }

        requirement park_sh_security : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'박승훈';
            attribute :>> securityRule = ChapterMembers::'박승훈'.securityRule;
            attribute :>> securityRuleOther = ChapterMembers::'박승훈'.securityRuleOther;
        }

        requirement lee_jy_security : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'이중윤';
            attribute :>> securityRule = ChapterMembers::'이중윤'.securityRule;
            attribute :>> securityRuleOther = ChapterMembers::'이중윤'.securityRuleOther;
        }

        requirement suh_es_security : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'서은석';
            attribute :>> securityRule = ChapterMembers::'서은석'.securityRule;
            attribute :>> securityRuleOther = ChapterMembers::'서은석'.securityRuleOther;
        }

        requirement chu_sh_security : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'추수호';
            attribute :>> securityRule = ChapterMembers::'추수호'.securityRule;
            attribute :>> securityRuleOther = ChapterMembers::'추수호'.securityRuleOther;
        }

        requirement ku_jm_security : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'구정모';
            attribute :>> securityRule = ChapterMembers::'구정모'.securityRule;
            attribute :>> securityRuleOther = ChapterMembers::'구정모'.securityRuleOther;
        }

        requirement kim_hj_security : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'김희재';
            attribute :>> securityRule = ChapterMembers::'김희재'.securityRule;
            attribute :>> securityRuleOther = ChapterMembers::'김희재'.securityRuleOther;
        }

        requirement kim_dw_security : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'김다운';
            attribute :>> securityRule = ChapterMembers::'김다운'.securityRule;
            attribute :>> securityRuleOther = ChapterMembers::'김다운'.securityRuleOther;
        }

        requirement park_hs_security : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = ChapterMembers::'박홍석';
            attribute :>> securityRule = ChapterMembers::'박홍석'.securityRule;
            attribute :>> securityRuleOther = ChapterMembers::'박홍석'.securityRuleOther;
        }
    } // package SecurityRules
} // package StakeholdersNeeds
