package ChapterConOpsAndLifecycle {
    doc
    /* Chapter Behavior — 통합된 시스템 경계 및 인터페이스 모델을 바탕으로
     * 챕터의 운용 시나리오(ConOps) 및 성장 상태머신(Lifecycle)을 정의
     */

    private import ScalarValues::*;
    private import ChapterSystemContext::*;
    private import ExternalActorsAndInterfaces::*;

    // ==========================================
    // 1. ConOps (운용 시나리오 및 프로세스)
    // ==========================================
    package ConOps {
        doc
        /* 온라인 지식교환 방식, Do-Tank 참조모델 개발 프로세스 및 상위 시스템 보고 프로세스의 동적 행위 */

        enum def ExchangeModeKind {
            seminarStyle; // 세미나/특강형
            caseStudyStyle; // 케이스 스터디형
            handsOnLabStyle; // 프로젝트 실습형
            literatureReadingStyle; // 문헌 리딩형
        }

        action def KnowledgeExchangeSession {
            doc
            /* 내부 비동기/실시간 지식 교환 프로세스 (Internal Flow) */

            in attribute mode : ExchangeModeKind;
            in item referenceResource : HandbookResourceItem [0..1]; // TechOps 등 외부 문헌 리소스 활용

            out item producedArtifact : ChapterArtifact; // 논의 후 생성된 지식 자산

            action present;
            action discuss;
            action archiveToKnowledgeStore {
                doc
                /* 생성된 산출물(producedArtifact)을 KnowledgeRepository 단일 진실 공급원에 저장 */
            }

            // 제어 흐름 (Control Flow)
            first present;
            then discuss;
            then archiveToKnowledgeStore;
        }

        // [신규] Do-Tank 핵심 운영 프로세스: SE 과제 수행 및 LV1 참조모델 개발·검증 워크플로우
        action def ReferenceModelDevelopmentProcess {
            doc
            /* [LV2 Do-Tank 참조모델 개발 및 품질 게이트 프로세스]
             * 1) 과제 가이드(PDF) 및 LV1 공통 스캐폴드(LV1_BlackBox_ConOps_Scaffold) 배포
             * 2) 워킹그룹별 도메인 모델링 수행 (블랙박스 SoI, 임무/MOE, 시점 인프라 가정, 5-Tuple 시나리오)
             * 3) 학술자문단(교수진) 피드백 3대 원칙 및 가이드 6대 자체 감사 게이트(Gate 1~6) 심사
             * 4) 기업 보안 규정(사내 데이터 배제 및 가상값 치환) 준수 확인
             * 5) KnowledgeRepository 및 GitHub 메인 브랜치 Baseline 정식 등록
             */
            in item assignmentGuide : ChapterArtifact;
            out item approvedBaselineModel : ReferenceModelArtifact;

            action issueAssignmentAndScaffold {
                doc
                /* 과제 목표, 실무 가이드 및 공통 스캐폴드 코드 배포 */
            }
            action developDomainModelInWG {
                doc
                /* 워킹그룹이 스캐폴드를 상속(:>)하여 도메인 모델 작성 */
            }
            action reviewByAdvisorsAndVerifyGates {
                doc
                /* 교수님 피드백 1(존재목적 달성 표현), 피드백 2(MOE 목표값/한계값/단위),
                 * 피드백 3(운용시점 인프라 가정 및 블랙박스 상호작용) 및 Gate 1~6 충족 여부 검증
                 */
            }
            action verifySecurityAndAnonymization {
                doc
                /* 회사명/프로젝트명 비언급 및 민감 수치 가상값 치환 여부 점검 */
            }
            action baselineToKnowledgeRepository {
                doc
                /* 검증 통과 모델을 KnowledgeRepository::approvedReferenceModels에 정식 등록 */
            }

            first issueAssignmentAndScaffold;
            then developDomainModelInWG;
            then reviewByAdvisorsAndVerifyGates;
            then verifySecurityAndAnonymization;
            then baselineToKnowledgeRepository;
        }

        action def SectorReporting {
            doc
            /* 상위 시스템(INCOSE Asia-Oceania Sector)으로의 활동 결과 보고 프로세스 (External Flow).
             * 챕터 총무 및 운영진이 내부 지식 저장소의 산출물들을 취합하여 공식 리포트 형태로 변환 및 전송함.
             */

            in item internalData : ChapterArtifact [1..*]; // 지식 저장소에 누적된 내부 산출물
            out item activityReport : SectorActivityReportItem; // Sector 전송용 포맷

            action compileReport;
            action sendToSector;

            first compileReport;
            then sendToSector;
        }
    } // package ConOps

    // ==========================================
    // 2. Lifecycle (수명주기 상태머신)
    // ==========================================
    package Lifecycle {
        doc
        /* 챕터 성장 단계별 상태머신.
         * LV3 거버넌스의 PhaseTransitionGateCondition(승인된 참조모델 3건 이상, 발표자료 10건 이상)과 연동됨.
         */

        state def ChapterLifecycle {
            attribute approvedModelsCount : Integer default 0;
            attribute seminarArtifactsCount : Integer default 0;

            entry;
            then onlineStudyPhase;

            state onlineStudyPhase {
                doc
                /* Phase 1: 온라인 스터디 및 도메인별 LV1 참조모델 초기 개발 단계 (현재)
                 * - 활성 Context 3종만 연결된 상태
                 * - 워킹그룹별 블랙박스 정의 및 ConOps 모델링 과제 수행 중
                 */
            }

            state sponsorshipAndOfflineSeminarPhase {
                doc
                /* Phase 2: 기업 스폰서 확보 및 오프라인 세미나 정례화 단계
                 * - 교육/실무 참고용 LV1 참조모델 3건 이상 확보 및 발표자료 10건 이상 누적 시 진입
                 * - Sponsor, PeerSociety(KOSSE/KCOSE) 연결 활성화
                 */
            }

            state officialWorkingGroupPhase {
                doc
                /* Phase 3: INCOSE 본부 공식 워킹그룹(WG) 발족 및 자체 아키텍트 인증 프로그램 운영 단계 */
            }

            transition phase1To2
                first onlineStudyPhase
                if approvedModelsCount >= 3 and seminarArtifactsCount >= 10
                then sponsorshipAndOfflineSeminarPhase {
                doc
                /* Phase 2 전환(Transition) 조건 (LV3 PhaseTransitionGateCondition 반영):
                 * 승인된 도메인 참조모델(ReferenceModelArtifact) 3건 이상 & 누적 세미나/발표 자료 10건 이상 달성
                 */
            }

            transition phase2To3
                first sponsorshipAndOfflineSeminarPhase then officialWorkingGroupPhase {
                doc
                /* Phase 3 전환(Transition) 조건:
                 * 정기 오프라인 세미나 4회 이상 개최, 기업 스폰서 1곳 이상 확보 및 CSEP 보유 인원 10명 이상 달성
                 */
            }
        }
    } // package Lifecycle
} // package ChapterConOpsAndLifecycle
