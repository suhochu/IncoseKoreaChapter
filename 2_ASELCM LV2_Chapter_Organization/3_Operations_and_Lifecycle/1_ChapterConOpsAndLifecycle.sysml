package ChapterConOpsAndLifecycle {
    doc
    /* Chapter Behavior — 통합된 시스템 경계 및 인터페이스 모델을 바탕으로
     * 챕터의 운용 시나리오(ConOps) 및 성장 상태머신(Lifecycle)을 정의.
     * 행위와 구조(chapter)의 연결(perform/exhibit)은 0_ASELCM_Integration 통합 패키지에서 수행한다.
     */

    private import ScalarValues::*;
    private import StakeholderDefinitions::*;
    private import ChapterSystemContext::*;
    private import ExternalActorsAndInterfaces::*;
    private import ChapterMetricsAndGuards::*;
    private import QualityGatesAndReviewProcess::*;

    // ==========================================
    // 1. ConOps (운용 시나리오 및 프로세스)
    // ==========================================
    package ConOps {
        doc
        /* 온라인 지식교환 방식, Do-Tank 참조모델 개발 프로세스 및 상위 시스템 보고 프로세스의 동적 행위 */

        action def KnowledgeExchangeSession {
            doc
            /* 내부 비동기/실시간 지식 교환 프로세스 (Internal Flow) */

            in attribute mode : OnlineExchangeKind;
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

        // Do-Tank 핵심 운영 프로세스: SE 과제 수행 및 LV1 참조모델 개발·검증 워크플로우
        action def ReferenceModelDevelopmentProcess {
            doc
            /* [LV2 Do-Tank 참조모델 개발 및 품질 게이트 프로세스]
             * 1) 과제 가이드(PDF) 및 LV1 공통 스캐폴드(LV1_BlackBox_ConOps_Scaffold) 배포
             * 2) 워킹그룹별 도메인 모델링 수행 (블랙박스 SoI, 임무/MOE, 시점 인프라 가정, 5-Tuple 시나리오)
             * 3) LV3 ModelReviewProcess 수행: 자동 게이트 점검, WG Lead 검토, 학술자문단 심사,
             *    기업 보안 규정(사내 데이터 배제 및 가상값 치환) 확인, 병합/배포.
             *    게이트 미통과 시 재작업 루프는 ModelReviewProcess 가 관리한다(여기서 다시 정의하지 않는다).
             * 4) 검증 통과 모델을 KnowledgeRepository::approvedReferenceModels 에 Baseline으로 정식 등록
             */
            in item assignmentGuide : ChapterArtifact;
            in attribute gateChecklist : AssignmentGateChecklist;
            out item approvedBaselineModel : ReferenceModelArtifact;

            action issueAssignmentAndScaffold {
                doc
                /* 과제 목표, 실무 가이드 및 공통 스캐폴드 코드 배포 */
            }
            action developDomainModelInWG {
                doc
                /* 워킹그룹이 스캐폴드를 상속(:>)하여 도메인 모델 작성 */
            }
            // LV3 검토 프로세스를 하위 action으로 재사용
            action modelReview : ModelReviewProcess {
                in :>> submittedChecklist = gateChecklist;
            }
            action baselineToKnowledgeRepository {
                doc
                /* 검증 통과 모델을 KnowledgeRepository::approvedReferenceModels에 정식 등록 */
            }

            first issueAssignmentAndScaffold;
            then developDomainModelInWG;
            then modelReview;
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
         * Phase 전환 조건은 LV3 QualityGatesAndReviewProcess 의 Phase1ToPhase2GateConstraint /
         * Phase2ToPhase3GateConstraint 가 단일 정의하며, 이 상태머신은 metrics 의 판정 결과만 참조한다.
         */

        state def ChapterLifecycle {
            in ref metrics : ChapterMoEsHolder;

            entry;
            then onlineStudyPhase;

            state onlineStudyPhase {
                doc
                /* Phase 1: 온라인 스터디 및 도메인별 LV1 참조모델 초기 개발 단계
                 * - Phase 1 활성 Context(incoseKoreaChapterContext)만 연결된 상태
                 * - 워킹그룹별 블랙박스 정의 및 ConOps 모델링 과제 수행
                 */
            }

            state sponsorshipAndOfflineSeminarPhase {
                doc
                /* Phase 2: 기업 스폰서 확보 및 오프라인 세미나 정례화 단계
                 * - 진입 조건: Phase1ToPhase2GateConstraint 참조
                 *   (판정식은 기업 스폰서 조건을 포함하지 않는다. 스폰서 연동 후 별도 조건 추가 여부는 TODO)
                 * - Sponsor, PeerSociety(KOSSE/KCOSE) 연결 활성화
                 * TODO(확인 필요): 단계 이름은 '기업 스폰서 확보'이나 진입 판정식에는 스폰서 조건이 없다.
                 */
            }

            state officialWorkingGroupPhase {
                doc
                /* Phase 3: INCOSE 본부 공식 워킹그룹(WG) 발족 및 자체 아키텍트 인증 프로그램 운영 단계.
                 * 진입 조건: Phase2ToPhase3GateConstraint 참조
                 */
            }

            // 전이 트리거: 파생 Boolean 값의 변화를 change trigger(accept when)로 명시
            // TODO(확인 필요): 'accept when' 구문은 Syside check 를 통과했으나, 변화 감지 실행 의미는 확인하지 못했다.
            transition phase1To2
                first onlineStudyPhase
                accept when metrics.isPhase1To2Ready
                then sponsorshipAndOfflineSeminarPhase {
                doc /* Phase 2 전환 조건: Phase1ToPhase2GateConstraint 참조 */
            }

            transition phase2To3
                first sponsorshipAndOfflineSeminarPhase
                accept when metrics.isPhase2To3Ready
                then officialWorkingGroupPhase {
                doc /* Phase 3 전환 조건: Phase2ToPhase3GateConstraint 참조 */
            }
        }
    } // package Lifecycle
} // package ChapterConOpsAndLifecycle
