package ChapterBehavior {
    doc
    /* 섹션5(문항15·17) 응답이 귀속되는 행위/상태 모델 */

    package ConOps {
        doc
        /* 문항15 온라인 지식교환 방식 + 상위 시스템 보고 프로세스 */

        enum def ExchangeModeKind {
            seminarStyle; // 세미나/특강형
            caseStudyStyle; // 케이스 스터디형
            handsOnLabStyle; // 프로젝트 실습형
            literatureReadingStyle; // 문헌 리딩형
        }

        action def KnowledgeExchangeSession {
            doc
            /* 내부 비동기/실시간 지식 교환 프로세스 (Internal Flow) */
            in item mode : ExchangeModeKind;
            action present;
            action discuss;
            action archiveToKnowledgeStore;
            first present;
            then discuss;
            then archiveToKnowledgeStore;
        }

        action def SectorReporting {
            doc
            /* 상위 시스템(INCOSE Asia-Oceania Sector)으로의 활동
             * 결과 보고 프로세스 (External Item Flow)
             */
            in item activityReport : ChapterStructure::KnowledgeStore::ChapterArtifact;
        }
    } // package ConOps

    package Lifecycle {
        doc
        /* 문항17 응답 기반 예비 상태머신. 운영 이력 부재로 guard
         * 조건은 정성적 예시 수준이며, 정식화는 Phase 2에서 실제
         * 운영 데이터와 대조한 후 진행.
         */

        state def ChapterLifecycle {
            entry;
            then onlineStudyPhase;

            state onlineStudyPhase {
                doc
                /* Phase 1: 온라인 스터디 위주 (현재) */
            }

            state sponsorshipAndOfflineSeminarPhase {
                doc
                /* Phase 2: 기업 스폰서 확보 및 오프라인 세미나 정례화 */
            }

            state officialWorkingGroupPhase {
                doc
                /* Phase 3: INCOSE 본부 공식 워킹그룹(WG) 발족 */
            }

            transition onlineStudyPhase then sponsorshipAndOfflineSeminarPhase {
                doc
                /* guard 예시(문항17 응답 기반, 정성적): 발표자료
                 * 10건 이상 누적 또는 고정 참석 인원 15명 초과.
                 * Phase 2에서 실측 데이터로 재검증 후 정식 guard로 승격.
                 */
            }

            transition sponsorshipAndOfflineSeminarPhase then officialWorkingGroupPhase {
                doc
                /* guard 예시(문항17 응답 기반, 정성적): 정기 오프라인
                 * 세미나 4회 이상 개최 및 기업 스폰서 1곳 이상 확보.
                 * Phase 2에서 실측 데이터로 재검증 후 정식 guard로 승격.
                 */
            }
        }
    } // package Lifecycle
} // package ChapterBehavior
