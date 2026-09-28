package Viewpoints {
    doc
    /* Viewpoints — ISO/IEC/IEEE 42010 뷰포인트 정의 */
    private import Concerns::*;

    viewpoint 'stakeholder viewpoint' {
        frame concern : StakeholderIdentificationConcern;
        require constraint {
            doc
            /* 구글 폼 매핑: 섹션 2 (문항 5 한 줄 소개, 문항 6 관심 키워드)
             * 분석: KOSSE/KCOSE와 회원 자격이 분리된 독립 기관 방침 하에,
             *   챕터 고유의 외부 액터(방산 도메인 SE, 자율주행 아키텍트,
             *   툴 벤더 등)를 식별·분류. (GtWR C2 Appropriate 확인용 원자료)
             */
        }
    }

    viewpoint 'requirements viewpoint' {
        frame concern : ValueRationaleValidationConcern;
        require constraint {
            doc
            /* 구글 폼 매핑: 섹션 3 (문항 7 단일 핵심가치, 문항 8 근거,
             *   문항 9 검증지표, 문항 10 우선순위)
             * 분석: 단일성(C1,C3,C5,C9)·근거(C8)·검증가능성(C7)을 갖춘
             *   목표 모델(Goal Model) 도출. 문항10 우선순위 데이터는
             *   응답자 한 명의 답변만으로는 세트 특성(C11 일관성,
             *   C15 정확성)을 담보하지 못하므로, 개별 응답 취합 후
             *   교차분석 단계에서 검증할 근거자료로만 위치시킴
             *   (자동 충족이 아님을 명시).
             */
        }
    }

    viewpoint 'context constraints viewpoint' {
        frame concern : BoundaryDependencyConcern;
        require constraint {
            doc
            /* 구글 폼 매핑: 섹션 4 (문항 11 자원유형 체크박스, 문항 12
             *   자원상세, 문항 13 개인 제약) 및 섹션 5 (문항 14 외부 의존성)
             * 분석: 무자본 학술 동호회라는 재정적 제약을 아키텍처에 반영.
             *   문항11 체크박스 유형화(지식공유/운영지원/툴역량/네트워크)는
             *   Member part의 give-속성 및 포트 후보를 자유서술보다 먼저
             *   구조화하여 enum 타입 속성으로의 전환 비용을 낮춤. 외부
             *   표준(ISO 26262 등)과의 인터페이스는 문항14에서 확인.
             *   참고: 문항13 "개인 제약"은 개별 요구사항의 완전성(C4)이
             *   아니라, 세트 차원에서 빠진 경계 조건을 채우는 것이므로
             *   C10(세트의 완전성) 근거자료로 재분류함.
             */
        }
    }

    viewpoint 'operational viewpoint' {
        frame concern : OperationalFlowConcern;
        require constraint {
            doc
            /* 구글 폼 매핑: 섹션 5 (문항 15 온라인 지식교환 방식, 문항 16
             *   IT 플랫폼 선호도)
             * 분석: 대부분의 활동이 온라인으로 진행되며 독립적 IT 플랫폼
             *   사용이 가능하다는 지침을 반영. 내부의 비동기/실시간 지식
             *   교환 프로세스(Internal Flow)와 상위 시스템(INCOSE Sector)
             *   으로의 보고 프로세스(External Item Flow)를 아키텍처로
             *   구현하는 기반.
             */
        }
    }

    viewpoint 'lifecycle evolution viewpoint' {
        frame concern : LifecycleEvolutionConcern;
        require constraint {
            doc
            /* 구글 폼 매핑: 섹션 5 (문항 17 — 다음 단계 성장 조건)
             * 분석: "학술 동호회 형식으로 출발하여 체계를 차차 정비한다"는
             *   방침을 SysML v2 상태 머신(State Machine)으로 모델링.
             *   Phase 1(온라인 스터디, 현재) → Phase 2(기업 스폰서 확보
             *   및 오프라인 세미나 정례화) → Phase 3(INCOSE 본부 공식
             *   워킹그룹 발족)의 상태 전환(transition) 조건(guard)을
             *   문항17 응답에서 도출.
             *   주의: 현재는 운영 이력이 없어 응답이 정성적일 가능성이
             *   큼. 정식 상태머신 guard 조건으로의 승격은 Phase 2에서
             *   실제 운영 데이터와 대조한 후 진행.
             */
        }
    }

    viewpoint 'knowledge asset viewpoint' {
        frame concern : KnowledgeAssetConcern;
        require constraint {
            doc
            /* 구글 폼 매핑: 섹션 5 (문항 16 IT 플랫폼 선호도 — 운용
             *   뷰포인트와 공유)
             * 분석: 예산이 없는 조직에서 가장 중요한 자산은 '정보'.
             *   SysML v2와 외부 플랫폼(Notion, Discord 등) 간의 정보
             *   흐름(Information Flow)과 데이터 스키마를 정의. 아티클
             *   번역본, SysML 다이어그램, 회의록이 흩어지지 않도록 단일
             *   진실 공급원(Single Source of Truth) 폴더 구조와 접근
             *   권한을 설계.
             *   참고: 이 뷰포인트는 IT 플랫폼 선택이 확정된 이후(킥오프
             *   직후) 별도의 폴더/스키마 설계 워크숍에서 구체화하는 것이
             *   현실적임. 폼만으로는 완전히 채워지지 않음.
             */
        }
    }

    viewpoint 'risk security viewpoint' {
        frame concern : RiskSecurityConcern;
        require constraint {
            doc
            /* 구글 폼 매핑: 섹션 5 (문항 18 — 지식공유 최소 규칙)
             * 분석: 다양한 도메인(방산, 자동차 등)의 실무자가 모이므로,
             *   보안 제약조건(Security Constraints)과 데이터 마스킹
             *   (Data Masking) 프로세스를 모델의 규칙(Rules)으로 강제.
             *   문항18의 체크박스 응답(가상값 치환, 사명 비언급, 내부
             *   공유 한정, 녹화금지 등)을 모임 내 지식 공유 가이드라인의
             *   초안으로 직접 채택 가능.
             */
        }
    }

    viewpoint 'capability Value Viewpoint' {
        frame concern : CapabilityValueConcern;
        require constraint {
            doc
            /* 구글 폼 매핑: 섹션 5 (문항 19 — 타 학회 대비 차별점)
             * 분석: UAF(Unified Architecture Framework)의 전략/역량
             *   뷰포인트와 맞닿음. KOSSE·KCOSE 같은 동위 시스템(Peer
             *   Systems)이 하지 못하는, 챕터만의 고유 기능(글로벌 표준의
             *   빠른 국내 도입, 영어 원문 해독 네트워크 등)을 Capability
             *   단위로 정의.
             *   주의: 문항19는 회원 개개인의 주관적 인식을 묻는 것이므로,
             *   응답들 간 공통분모를 뽑아내는 별도의 취합 분석이 킥오프
             *   이후 필요함.
             */
        }
    }
} // package Viewpoints
