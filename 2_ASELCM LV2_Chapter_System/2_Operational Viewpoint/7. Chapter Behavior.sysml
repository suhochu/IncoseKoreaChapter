package Chapter_Behavior {
    doc
    /* Chapter Behavior — 통합된 시스템 경계 및 인터페이스 모델을 바탕으로
     * 챕터의 운용 시나리오(ConOps) 및 성장 상태머신(Lifecycle)을 정의
     */

    private import SystemContext::*;
    private import ActorAndInterfaces::*;

    // ==========================================
    // 1. ConOps (운용 시나리오 및 프로세스)
    // ==========================================
    package ConOps {
        doc
        /* 온라인 지식교환 방식 및 상위 시스템 보고 프로세스의 동적 행위 */

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
        /* 챕터 성장 단계별 상태머신. Phase 2 진입 시 실측 데이터를 기반으로 
         * 정식 Guard 조건식을 수립할 수 있도록 구조화함.
         */

        state def ChapterLifecycle {
            entry;
            then onlineStudyPhase;

            state onlineStudyPhase {
                doc
                /* Phase 1: 온라인 스터디 위주 (현재) - 활성 Context 3종만 연결된 상태 */
            }

            state sponsorshipAndOfflineSeminarPhase {
                doc
                /* Phase 2: 기업 스폰서 확보 및 오프라인 세미나 정례화 - Sponsor, PeerSociety 연결 활성화 단계 */
            }

            state officialWorkingGroupPhase {
                doc
                /* Phase 3: INCOSE 본부 공식 워킹그룹(WG) 발족 단계 */
            }

            transition phase1To2 first onlineStudyPhase then sponsorshipAndOfflineSeminarPhase {
                doc
                /* Phase 2 전환(Transition) 조건. 
                 * 예시: 발표자료 10건 이상 누적 또는 고정 참석 인원 15명 초과.
                 * 추후 실측 데이터가 모이면 정식 Guard Constraint로 승격 예정.
                 */
            }

            transition phase2To3
                first sponsorshipAndOfflineSeminarPhase then officialWorkingGroupPhase {
                doc
                /* Phase 3 전환(Transition) 조건.
                 * 예시: 정기 오프라인 세미나 4회 이상 개최 및 기업 스폰서 1곳 이상 확보.
                 */
            }
        }
    } // package Lifecycle
} // package Chapter_Behavior
