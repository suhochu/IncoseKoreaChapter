package MemberNeedsAndSecurityRules {
    doc
    /* Chapter Requirements — 통합된 SystemContext 및 Stakeholders 모델을
     * 기반으로 한 회원 요구사항(Member Needs) 및 보안 규칙(Security Rules) 정의.
     *
     * 속성 값은 def 안에서 actor(회원) 기준으로 한 번만 바인딩한다.
     * 새 회원의 요구사항/보안 규칙은 'need_M0NN' / 'security_M0NN' usage에 subject와 actor만 지정하면 된다.
     */

    private import ScalarValues::*;
    private import RequirementDerivation::*;
    private import StakeholderDefinitions::*;
    private import ChapterSystemContext::*;
    private import ChapterObjectives::*;
    private import ChapterMembersDirectory::*;

    // ==========================================
    // 1. Member Needs (회원 요구사항)
    // ==========================================
    package ChapterMembers_Needs {
        doc
        /* 회원들의 핵심 니즈와 가치 도출 근거를 담은 요구사항 세트.
         * MemberNeedRequirement는 Objective를 상속하지 않고, 각 need usage가 ChapterObjective에서 파생(#derivation)된다.
         */

        requirement def MemberNeedRequirement {
            doc
            /* 구글 폼 문항 "얻고 싶은 것 하나" 작성 템플릿을 옮기는 요구사항 정의.
             * GtWR(Guide to Writing Requirements) C1,C3,C5,C9 확인 대상.
             */
            subject chapter : KoreaChapter;
            actor member : IncoseKoreaChapterMember;

            attribute coreValueWhat : String [0..*] = member.coreValueWhat; // 구체적인 요구사항 핵심 가치 (What)
            attribute rationale : String [0..*] = member.rationale; // 도출 근거 (Why, C8)
            attribute validationCriterion : String [0..*] = member.validationCriterion; // 타당성 확인 기준 (Validation, C7)
            attribute priority : String [0..*] = member.priority; // 우선순위 (세트 조율용)
        }

        // --- 개별 회원 요구사항 Usage (subject, actor 지정만 남김) ---

        requirement need_M001 : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '이수';
            #derivation connection {
                end #original ::> chapterObjective;
                end #derive ::> need_M001;
            }
        }

        requirement need_M002 : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '박승훈';
            #derivation connection {
                end #original ::> chapterObjective;
                end #derive ::> need_M002;
            }
        }

        requirement need_M003 : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '이중윤';
            #derivation connection {
                end #original ::> chapterObjective;
                end #derive ::> need_M003;
            }
        }

        requirement need_M004 : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '서은석';
            #derivation connection {
                end #original ::> chapterObjective;
                end #derive ::> need_M004;
            }
        }

        requirement need_M005 : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '추수호';
            #derivation connection {
                end #original ::> chapterObjective;
                end #derive ::> need_M005;
            }
        }

        requirement need_M006 : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '구정모';
            #derivation connection {
                end #original ::> chapterObjective;
                end #derive ::> need_M006;
            }
        }

        requirement need_M007 : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '김희재';
            #derivation connection {
                end #original ::> chapterObjective;
                end #derive ::> need_M007;
            }
        }

        requirement need_M008 : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '김다운';
            #derivation connection {
                end #original ::> chapterObjective;
                end #derive ::> need_M008;
            }
        }

        requirement need_M009 : MemberNeedRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '박홍석';
            #derivation connection {
                end #original ::> chapterObjective;
                end #derive ::> need_M009;
            }
        }
    } // package ChapterMembers_Needs

    // ==========================================
    // 2. Security Rules (보안 및 리스크 규칙)
    // ==========================================
    package SecurityRules {
        doc
        /* 리스크/보안 뷰포인트의 모델 규칙(Rule)으로 직접 채택되는 제약사항 세트 */

        requirement def KnowledgeSharingSecurityRequirement {
            doc
            /* 지식공유 시 준수할 최소 규칙 (설문 체크박스 응답).
             * 소속 기업의 지적 재산(IP)이나 민감 정보를 보호하기 위한 안전 장치.
             */
            subject chapter : KoreaChapter;
            actor member : IncoseKoreaChapterMember;

            attribute securityRule : SecurityRuleKind [0..*] = member.securityRule;
            attribute securityRuleOther : String [0..1] = member.securityRuleOther;
        }

        // --- 개별 회원 보안 규칙 Usage (subject, actor 지정만 남김) ---

        requirement security_M001 : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '이수';
        }

        requirement security_M002 : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '박승훈';
        }

        requirement security_M003 : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '이중윤';
        }

        requirement security_M004 : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '서은석';
        }

        requirement security_M005 : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '추수호';
        }

        requirement security_M006 : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '구정모';
        }

        requirement security_M007 : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '김희재';
        }

        requirement security_M008 : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '김다운';
        }

        requirement security_M009 : KnowledgeSharingSecurityRequirement {
            subject chapter = incoseKoreaChapterContext.chapter;
            actor member = '박홍석';
        }
    } // package SecurityRules
} // package MemberNeedsAndSecurityRules
