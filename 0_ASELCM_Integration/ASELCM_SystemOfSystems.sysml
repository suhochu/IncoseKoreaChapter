package ASELCM_SystemOfSystems {
    doc
    /* ASELCM 통합 패키지: LV3(거버넌스)와 LV2(챕터 조직)를 함께 묶는 유일한 위치.
     *
     * 의존 방향: 이 패키지 -> LV3, LV2 (단방향). LV3는 LV2를 import하지 않고, LV2는 이 패키지를 import하지 않는다.
     * 여기서 하는 일:
     *  1) GovernanceSystemContext 와 incoseKoreaChapterContext 를 하나의 상위 part로 포함하고 포트를 connect 한다.
     *  2) chapter 에 행위(perform action)와 수명주기(exhibit state)를 연결한다.
     */

    private import GovernanceSystemAndTooling::GovernanceSystem::*;
    private import ChapterSystemContext::*;
    private import ChapterConOpsAndLifecycle::ConOps::*;
    private import ChapterConOpsAndLifecycle::Lifecycle::*;

    part def AselcmSystemOfSystems {
        doc
        /* System 3(거버넌스)와 System 2(챕터)의 상위 시스템. System 1(LV1 참조모델)은 별도 모델로 유지한다. */

        part governance : GovernanceSystemContext;

        // 구조 baseline(incoseKoreaChapterContext)을 subset 하고 chapter 에 행위/상태만 추가한다.
        // TODO(확인 필요): 패키지 수준 part usage를 ':>' 로 subset 하는 구성은 Syside check 를 통과했으나,
        //   결과 인스턴스가 baseline과 같은 chapter 인스턴스를 공유하는지는 확인하지 못했다.
        //   공유되지 않으면 baseline 쪽 part 를 part def 로 바꾸고 usage 를 이 패키지에서 생성하는 구조로 전환한다.
        part chapterContext :> incoseKoreaChapterContext {
            part :>> chapter {
                // 행위-구조 연결
                // TODO(확인 필요): 각 action 의 in/out 파라미터(internalData 등)는 아직 chapter.repository 와 바인딩하지 않았다.
                perform action sectorReporting : SectorReporting;
                perform action referenceModelDevelopment : ReferenceModelDevelopmentProcess;
                perform action knowledgeExchange : KnowledgeExchangeSession;

                // 수명주기 상태머신: metrics 는 chapter 자신(ChapterMoEsHolder 상속)을 가리킨다.
                exhibit state lifecycle : ChapterLifecycle {
                    in ref :>> metrics = chapter;
                }
            }
        }

        // LV3 정책(out)/지표(in) 포트와 LV2 켤레(~) 포트 연결
        connect governance.governanceInterface to chapterContext.chapter.governanceInterface;
    }

    part aselcmSystemOfSystems : AselcmSystemOfSystems;
} // package ASELCM_SystemOfSystems
