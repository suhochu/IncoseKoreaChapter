package ChapterMembersDirectory {
    private import StakeholderDefinitions::*;

    // ---- 개별 회원 모델링 (Part Usages) ----
    part '이수' : IncoseKoreaChapterMember {
        :>> name = "이수";
        :>> email = "isugkgkgk@gmail.com";
        :>> affiliation = "인터그래비티(주)";
        :>> position = "비행SW팀 연구원";
        :>> phoneNumber = "010-2650-9183";
        :>> region = RegionKind::daejeonSejongChungcheong;
        :>> domain = DomainKind::defenseAndAerospace;
        :>> preferredActivity = (
            "MBSE, SysML, UAF, Digital Engineering 등 신흥 SE 기술 지식 교류",
            "INCOSE 리소스(SE Handbook, SE 역량 등) 기반 전문성 개발 및 SEP 자격증 스터디",
            "주니어 SE 및 학생을 위한 교육, 멘토링, 네트워킹 프로그램",
        );
        :>> expectation =
            "기존 국내 학회에 참여하지 않아, INCOSE Korea Chapter에서 SE 학술 활동이 어떤 형태로 진행되는지 알아가고싶습니다.";

        :>> interestKeyword = ("MBSE 실무 적용", "디지털 엔지니어링",);
        :>> coreValueWhat =
            "나는 SysML V2를 처음 실무에 적용해볼 때, 챕터 활동을 통해 SysML V2의 모델링을 기반으로 한 시뮬레이션 레퍼런스를 얻을 수 있어야 한다.";
        :>> rationale =
            "현 시점에서 SysML V1 대비 툴 성숙도가 낮은 SysML V2를 어떻게 활용할 수 있는지에 대한 레퍼런스가 부족하여 SysML V2의 사내 운용의 합리성이 부족한 상황이기 때문입니다.";
        :>> validationCriterion =
            "SysML V2 기반의 MILS, SILS, 가능하다면 HILS의 시뮬레이션 레퍼런스 확보";
        :>> giveResource = (
            GiveResourceKind::knowledgeSharing, GiveResourceKind::operationsSupport,
        );
        :>> giveDetail = "Capella/ARCADIA 기반 MBSE 운용 경험 공유 가능";
        :>> operationalConstraint =
            "보안 규정상 사내 실제 업무 데이터는 외부 공유 불가. 대전 근무 및 거주로 인해 현장 미팅 참여가 제한적임";
        :>> externalDependency =
            "프로젝트의 기획 범위가 CATIA Magic Community Edition의 가용 범위에 있거나, 프로젝트 참가자 전원이 Magic 툴 라이선스를 보유할 필요가 있음.";
        :>> preferredOnlineExchange = (
            OnlineExchangeKind::seminar, OnlineExchangeKind::caseStudy,
            OnlineExchangeKind::projectLab, OnlineExchangeKind::literatureReading,
        );
        :>> preferredITPlatform = (
            ITPlatformKind::notion, ITPlatformKind::slackDiscord, ITPlatformKind::googleWorkspace,
        );
        :>> lifecycleTransitionCondition =
            "발표 자료 10건, 자체 프로젝트 3건 이상 등 MBSE의 실효성을 직접적으로 보여줄 수 있는 레퍼런스를 확보한 경우";
        :>> securityRule = (
            SecurityRuleKind::anonymizeData, SecurityRuleKind::noCompanyProjectNames,
            SecurityRuleKind::internalOnly,
        );
        :>> uniqueCapability = "다른 INCOSE 챕터와의 국제적 협력";
    }

    part '박승훈' : IncoseKoreaChapterMember {
        :>> name = "박승훈";
        :>> email = "abhyung123@gmail.com";
        :>> affiliation = "영풍전자";
        :>> position = "무인항전체계개발팀 책임연구원";
        :>> phoneNumber = "010-4007-8059";
        :>> region = (RegionKind::seoul, RegionKind::gyeonggiIncheon,);
        :>> domain = DomainKind::defenseAndAerospace;
        :>> preferredActivity = (
            "MBSE, SysML, UAF, Digital Engineering 등 신흥 SE 기술 지식 교류",
            "국내 SE 전문가 간의 네트워킹 및 전문적 교류",
        );
        :>> expectation =
            "기존 활동 내역을 잘 모릅니다. 실무에 적용할 수 있는 구체 내용들을 다루었으면 합니다";

        :>> interestKeyword = (
            "MBSE 실무 적용", "SE 적용 실제 사례분석", "주요 문서 양식 및 예시문서 학습",
        );
        :>> coreValueWhat = (
            "1. 무인기 시스템 개발 시 챕터 활동을 통하여 MBSE 실무 지식을 습득하고 이를 모델링툴에 적용할 수 있어야 한다.",
            "2. SW 요구도 및 SE관련 문서를 적절히 산출하고 구조를 파악하며 요구도를 작성할 수 있어야 한다.",
        );
        :>> rationale =
            "무인기 시스템에 체계적인 SE 및 체계종합 적용에 있어 적절한 관리도구가 없기 때문입니다. 또한 LRU SW/HW 관련 요구도 및 개발과정을 관리함에 있어 해당 지식이 필요하기 때문입니다.";
        :>> validationCriterion =
            "1년 뒤 목적한 시스템 개발이 완료되었다는 가정하에 SE 모델링 툴로 완성된 파일을 생성하고 V모델을 따라 단계별로 구성이 되어있는지 확인(분석, 시연)";
        :>> giveResource = GiveResourceKind::other;
        :>> giveDetail =
            "능력이 되는데로 활동이 가능하나 우선 어떤 부분이 필요한지 탐색이 필요할 것 같습니다. 운영 방안등의 초기 논의가 필요해 보입니다.";
        :>> operationalConstraint = "특별 제약사항 없음";
        :>> externalDependency =
            "SE관련 소프트웨어를 쓴다면 해당 라이센스 보유여부 확인 필요, 오픈소스인 카펠라가 있는데 사용여부 확인이 필요할 것 같습니다.";
        :>> preferredOnlineExchange = (
            OnlineExchangeKind::seminar, OnlineExchangeKind::projectLab,
        );
        :>> preferredITPlatform = (
            ITPlatformKind::notion, ITPlatformKind::slackDiscord, ITPlatformKind::googleWorkspace,
        );
        :>> securityRule = (
            SecurityRuleKind::anonymizeData, SecurityRuleKind::noCompanyProjectNames,
        );
        :>> uniqueCapability = "incose와 연계한 글로벌 현업트랜드 제공";
    }

    part '이중윤' : IncoseKoreaChapterMember {
        :>> name = "이중윤";
        :>> email = "leejy@ajou.ac.kr, lee.joongyoon@gmail.com";
        :>> affiliation = "아주대학교";
        :>> position = "시스템공학과 교수";
        :>> phoneNumber = "010-8951-5222";
        :>> region = (RegionKind::seoul, RegionKind::gyeonggiIncheon,);
        :>> domain = (
            DomainKind::defenseAndAerospace, DomainKind::automotiveAndMobility,
            DomainKind::railInfrastructureAndEnergy, DomainKind::itAndSoftware,
            DomainKind::academiaAndResearch,
        );
        :>> preferredActivity = (
            "국내 SE 전문가 간의 네트워킹 및 전문적 교류",
            "주니어 SE 및 학생을 위한 교육, 멘토링, 네트워킹 프로그램",
            "국내 SE 연구 및 산업 적용 사례를 국제 사회에 발표/공유",
        );
        :>> expectation =
            "기존 학회(KOSSE)에는 국제협력분과가 있습니다. 추수호 총무님께서 국제협력분과 임원으로 역임하시고, 이 활동을 이끌어 가시면 좋겠습니다. INCOSE Korea Chapter는 독립 조직으로 활동하면서, 활동 내역을 학회와 공유하는 방식으로 협력하고 그 외의 협력 방법도 찾아 가면 좋겠습니다.";

        :>> interestKeyword =
            "MBSE 사례 기반 교육을 위해 도메인별로 모범 사례로 활용할 수 있는 참조모델 만들기";
        :>> coreValueWhat = (
            "R.1 MBSE 사례 개발", "R.2 아키텍트 양성", "R.3 아키텍트 능력 수준 달성",
        );
        :>> rationale =
            "국가 전반의 산업이... (중략) ...개념설계 역량이 필요하다. 따라서 개념설계 기술의 핵심인 MBSE 기술 및 도메인 참조모델을 개발하고 활용하는 기술을 겸비한 아키텍트 양성이 필요하다.";
        :>> validationCriterion = (
            "1) 스스로 개발한 개념설계 참조모델 갯수",
            "2) 스스로 개발한 개념설계 참조모델이 미래에 적합한 수준에 대한 주관적 평가",
            "3) 참조모델을 재활용한 다른 사람이 그 유용성에 대한 주관적 평가",
        );
        :>> priority = "1순위:R.1 MBSE 사례 개발, 2순위: R.2 아키텍트 양성";
        :>> giveResource = (
            GiveResourceKind::knowledgeSharing, GiveResourceKind::toolExpertise,
            GiveResourceKind::networking,
        );
        :>> giveDetail = "MBSE 참조모델 개발 교육";
        :>> operationalConstraint =
            "모두 바쁜게 문제인데, 온라인으로 만나고, 오프라인 모임은 가끔씩 진행";
        :>> externalDependency = "무료 MBSE 도구 지원";
        :>> preferredOnlineExchange = (
            OnlineExchangeKind::caseStudy, OnlineExchangeKind::projectLab,
        );
        :>> preferredITPlatform = ITPlatformKind::googleWorkspace;
        :>> lifecycleTransitionCondition =
            "1. 세미나 자료가 누적되면, INCOSE 저널에 논문 게제 2. 교육자료로 활용할 수 있는 참조 모델이 3건 이상 개발되면... 3. CSEP 10명 이상이 되면, Korea Chapter에서 별도로 아키텍트 인증 프로그램 개발";
        :>> securityRule = (
            SecurityRuleKind::anonymizeData, SecurityRuleKind::noCompanyProjectNames,
            SecurityRuleKind::other,
        );
        :>> securityRuleOther =
            "녹화/캡처 결과물을 AI를 활용하여 보안 처리한 후 보안 처리된 데이터를 외부 공개 (매 건별로 제공자가 결정)";
        :>> uniqueCapability =
            "챕터 구성원이 학회 및 협회 활동에 참가 (학술대회 발표 및 임원진으로 참여 등)";
    }

    part '서은석' : IncoseKoreaChapterMember {
        :>> name = "서은석";
        :>> email = "essuh@snu.ac.kr";
        :>> affiliation = "서울대학교";
        :>> position = "교수";
        :>> phoneNumber = "010-2688-7175";
        :>> region = RegionKind::seoul;
        :>> domain = (DomainKind::automotiveAndMobility, DomainKind::academiaAndResearch,);
        :>> preferredActivity = (
            "국내 SE 전문가 간의 네트워킹 및 전문적 교류",
            "주니어 SE 및 학생을 위한 교육, 멘토링, 네트워킹 프로그램",
            "국내 SE 연구 및 산업 적용 사례를 국제 사회에 발표/공유",
        );
        :>> expectation = "추후 모임에서 같이 논의 요망";

        :>> interestKeyword = "SE 관련 산학협력";
        :>> coreValueWhat = "SE를 한국 산업계에 널리 전파할 수 있는 조직이 되어야 한다.";
        :>> rationale =
            "학교 재직자 입장에서 보았을 때 한국 기업들은 아직 Fast Follower에 머물러 있고 진정한 First Mover로 도약하기 위해서는 SE 적용이 필수라 생각됨";
        :>> validationCriterion = "기업들의 SE Practice 적용";
        :>> giveResource = (GiveResourceKind::knowledgeSharing, GiveResourceKind::other,);
        :>> giveDetail = "본인의 교육 경험 공유 (SE 관련 교육 산학 기반)";
        :>> operationalConstraint = "추후 논의";
        :>> externalDependency = "추후 논의";
        :>> preferredOnlineExchange = OnlineExchangeKind::seminar;
        :>> preferredITPlatform = ITPlatformKind::googleWorkspace;
        :>> lifecycleTransitionCondition = "추후 논의";
        :>> securityRule = SecurityRuleKind::anonymizeData;
        :>> uniqueCapability = "추후 논의";
    }

    part '추수호' : IncoseKoreaChapterMember {
        :>> name = "추수호";
        :>> email = "chooshow@gmail.com";
        :>> affiliation = "현대모비스";
        :>> position = "책임연구원 / 시스템 엔지니어";
        :>> phoneNumber = "010-8379-0578";
        :>> region = (RegionKind::seoul, RegionKind::gyeonggiIncheon,);
        :>> domain = DomainKind::automotiveAndMobility;
        :>> preferredActivity = (
            "MBSE, SysML, UAF, Digital Engineering 등 신흥 SE 기술 교류",
            "INCOSE 워킹그룹(WG) 및 해외 챕터와의 국제 협력 활동",
            "국내 SE 전문가 간의 네트워킹 및 전문적 교류",
        );
        :>> expectation =
            "다양한 비즈니스 영역 (자동차, 항공&우주, 방산, IoT)에서의 시스템 엔지니어링의 효율적인 적용 방안 공유";

        :>> interestKeyword = (
            "MBSE 실무 적용", "SysML v2", "안전 및 보안 표준 적용 시스템 아키텍처",
        );
        :>> coreValueWhat =
            "나는 SysML v2를 적용해 자동차 임베디드 시스템 아키텍처를 디자인 할 때, 챕터 활동을 통해 함께 고민할 수 있는 동료와 좋은 레퍼런스를 배워 갈 수 있어야 한다.";
        :>> rationale =
            "실제로 제품의 품질/안전/보안과 이어지는 시스템 아키텍처를 만들 수 있는 기회가 없었다... MBSE를 도입해야 문서화를 위한 요식행위가 줄어들고... 시스템 아키텍처를 만들 수 있다고 생각하게 되었다.";
        :>> validationCriterion =
            "SysML v2 + MBSE 방법론 + ISO26262 + ISO/SAE21434를 전부 적용한 시스템 아키텍처 모델의 레퍼런스 완성. Github Reposiory를 Incose 아시아 챕터에 보고.";
        :>> priority = "1순위. SysML v2 를 이용한 모델링 / 2순위. MBSE 스터디";
        :>> giveResource = (GiveResourceKind::operationsSupport, GiveResourceKind::toolExpertise,);
        :>> giveDetail = "1. 총무로서 챕터 운영/행정지원. 2. SysML v2 실습 리드";
        :>> operationalConstraint = "육아를 하고 있어서, 야간 시간에는 항상 시간을 내기가 어려움";
        :>> preferredOnlineExchange = (
            OnlineExchangeKind::seminar, OnlineExchangeKind::caseStudy,
            OnlineExchangeKind::projectLab,
        );
        :>> preferredITPlatform = ITPlatformKind::googleWorkspace;
        :>> lifecycleTransitionCondition =
            "기업 및 학회에서 참고할 만한 레퍼런스 자료가 10건 이상 누적되면.";
        :>> securityRule = (
            SecurityRuleKind::anonymizeData, SecurityRuleKind::noCompanyProjectNames,
        );
        :>> uniqueCapability = "자동차/IoT 등 다양한 분야의 전문가 참여, Incose와 직접 교류";
    }

    part '구정모' : IncoseKoreaChapterMember {
        :>> name = "구정모";
        :>> email = "jeongmokoo@gmail.com";
        :>> affiliation = "볼보그룹코리아(주)";
        :>> position = "Group Technology&Operations Principal Solution Architect";
        :>> phoneNumber = "010-6304-3930";
        :>> region = (
            RegionKind::seoul, RegionKind::gyeonggiIncheon, RegionKind::busanUlsanGyeongnam,
        );
        :>> domain = (DomainKind::automotiveAndMobility, DomainKind::itAndSoftware,);
        :>> preferredActivity = (
            "MBSE, SysML, UAF, Digital Engineering 등 신흥 SE 기술 지식 교류",
            "해외 SE 전문가 초청 국제 세미나 및 워크숍",
            "국내 SE 전문가 간의 네트워킹 및 전문적 교류",
        );
        :>> expectation =
            "기존 학회 및 협회에도 참석 하고 있지만 정보 공유가 잘 안되는 것 같습니다. 주제별로 공유 또는 공동 협업하는 활동이 있으면 좋을 것 같습니다.";

        :>> interestKeyword = "제품 개발 단계에서 SysML 적용 하기";
        :>> coreValueWhat = "MBSE Ontology 와 meta model 관련 레퍼런스";
        :>> rationale = "현 제품 개발 프로세스에 적용 하기 위하여";
        :>> validationCriterion = "Pilot 프로젝트 적용 후 적용 성공도";
        :>> giveResource = GiveResourceKind::toolExpertise;
        :>> giveDetail =
            "현재 사용 중인 툴 (PTC Modeler, EA)을 이용하여 협업에서 SysML로 시스템 모델링 리딩 중";
        :>> operationalConstraint =
            "근무지가 창원이기 때문에 주중 서울 출장이 어렵습니다. 대면은 가능하면 금요일, 주중에는 화상회의가 좋을 것 같습니다. 화상회의는 사전 시간 조율이 필요합니다. 글로벌 미팅이 대부분 오후 4시~7시 사이에 많이 있어서.";
        :>> externalDependency =
            "표준 프레임워크를 정의 후 진행 하는 것이 좋을 것 같습니다. 둘은 큰 문제가 안될 것 같습니다.";
        :>> preferredOnlineExchange = (
            OnlineExchangeKind::literatureReading, OnlineExchangeKind::other,
        );
        :>> preferredITPlatform = (ITPlatformKind::notion, ITPlatformKind::googleWorkspace,);
        :>> lifecycleTransitionCondition =
            "INCOSE 자격 보유 인원 확보 후 실무에서 적용 가능한 표준안 마련 필요";
        :>> securityRule = SecurityRuleKind::noRecording;
        :>> uniqueCapability = "표준 가이드 기준으로 실무 적용 가능 레퍼런스 제공";
    }

    part '김희재' : IncoseKoreaChapterMember {
        :>> name = "김희재";
        :>> email = "tim0huj@gmail.com";
        :>> affiliation = "에드워드코리아";
        :>> position = "시스템개발부 (NPI-IS Sr. Systems Engineer)";
        :>> phoneNumber = "010-9863-7900";
        :>> region = (
            RegionKind::seoul, RegionKind::gyeonggiIncheon, RegionKind::daejeonSejongChungcheong,
        );
        :>> domain = DomainKind::other;
        :>> domainOther = "Manufacturing Semiconductor Equipment";
        :>> preferredActivity = (
            "MBSE, SysML, UAF, Digital Engineering 등 신흥 SE 기술 지식 교류",
            "INCOSE 워킹그룹(WG) 및 해외 챕터와의 국제 협력 활동",
        );
        :>> expectation = "성공사례도 중요하지만 실패에서 개선한 사례등을 배우고자 합니다";

        :>> interestKeyword = ("MBSE 활용성", "요구사항 및 V&V 추적성 관리", "Regression 관리",);
        :>> coreValueWhat =
            "현재 사용중인 SysMLv2를 기반으로 한 EA를 쓰고 있지만 업무적으로는 별도의 문서를 쓰고있는 실정으로 이를 실무에서 유용하게 그리고 라이브 문서로써 역할을 할 수 있는 방안 도출필요";
        :>> rationale =
            "MBSE에는 많은 요구사항과 설계지표가 들어가지면 현재는 가시적이지 않은 S/W의 아키텍쳐를 그리는 현실이며 이마저도 업데이트를 쫓아가지 못하는 실정";
        :>> validationCriterion = (
            "1. MBSE의 S/W와 소통하여 함께 Release될 수 있는 연동",
            "2. MBSE를 활용한 기존 제품의 Modular 단위의 설계 데이터 반영",
        );
        :>> priority = "1. 실제 적용 사례, 2. 툴 실습 기회";
        :>> giveResource = GiveResourceKind::knowledgeSharing;
        :>> giveDetail = "(승인 필요) 실패담 - 현재에서 활용중인 MBSE와 그 실태";
        :>> operationalConstraint = "보안 규정상 사내 실제 업무 데이터는 외부 공유 승인 필요";
        :>> preferredOnlineExchange = (
            OnlineExchangeKind::seminar, OnlineExchangeKind::caseStudy,
            OnlineExchangeKind::projectLab,
        );
        :>> preferredITPlatform = (ITPlatformKind::notion, ITPlatformKind::googleWorkspace,);
        :>> lifecycleTransitionCondition =
            "실제 적용 사례 및 개선 활동에 대한 이력 - 이는 MBSE 도입을 고려중인 기업 및 담당자가 참고 할 수 있는 좋은 사례 및 도입하였으나 여러 이유로 실패한 담당자에게 도움이 될 것으로 예상";
        :>> securityRule = SecurityRuleKind::other;
        :>> securityRuleOther = "발표자의 역량과 승인 한도에 맞춰 결정";
        :>> uniqueCapability = "타 학회 경험 없음";
    }

    part '김다운' : IncoseKoreaChapterMember {
        :>> name = "김다운";
        :>> email = "dawun.kim93@gmail.com";
        :>> affiliation = "한국항공우주산업";
        :>> position = "디지털엔지니어링팀 선임연구원";
        :>> phoneNumber = "010-4745-6797";
        :>> region = RegionKind::busanUlsanGyeongnam;
        :>> domain = DomainKind::defenseAndAerospace;
        :>> preferredActivity = (
            "MBSE, SysML, UAF, Digital Engineering 등 신흥 SE 기술 지식 교류",
            "해외 SE 전문가 초청 국제 세미나 및 워크숍",
            "INCOSE 워킹그룹(WG) 및 해외 챕터와의 국제 협력 활동",
        );
        :>> expectation =
            "KCOSE 활동을 해보지는 않았지만, 국내 MBSE 확산을 위한 사례연구 및 정책적인 방향도 같이 논의해보면 좋을 것 같습니다.";

        :>> interestKeyword = (
            "RA 모델 개발", "Methodology (ex, RFLP 등)", "항공기 Agile 개발 방법",
        );
        :>> coreValueWhat =
            "나는 [항공기 개발에 있어 MBSE 적용 실효성을 입증할] 때, 챕터 활동을 통해 [국내외 사례 등 레퍼런스를 얻고 개발 방법론을 확립할 수 있는 인사이트]를 얻을 수 있어야 한다.";
        :>> rationale =
            "해외 업체 발표자료만으로는 MBSE 툴을 사용해 어떤 Methodology를 어떤 방식으로 사용했고... 실무에 적용하고자 할 때 기존 항공기 등 복합제품시스템 개발 프로세스를 어떻게 대체할 수 있는지 구체적으로 논의해보고 싶습니다.";
        :>> validationCriterion = (
            "1. 향후 차세대 복합제품 개발 프로그램에 MBSE를 도입해 개발 전 주기를 MBSE 툴로써 관리하는 사례",
            "2. K-MOSA 연구에도 기여",
        );
        :>> priority = "1. 표준(레퍼런스) 모델 개발 / 2. MBSE 파일럿 프로젝트 수행";
        :>> giveResource = (
            GiveResourceKind::knowledgeSharing, GiveResourceKind::operationsSupport,
        );
        :>> giveDetail = "해외 아티클 번역 가능, 컨퍼런스 참석 후 지식 공유는 가능할 것 같습니다.";
        :>> operationalConstraint = "방산 업계 보안 규정에 따라 업무 관련 데이터는 공유 불가";
        :>> externalDependency =
            "사용하는 Tool에 대한 전원 라이센스 보유가 필요하고, 공동 개발 시 Cloud Server(ex, TWC 등)도 필요할 것 같습니다.";
        :>> preferredOnlineExchange = (
            OnlineExchangeKind::seminar, OnlineExchangeKind::caseStudy,
            OnlineExchangeKind::projectLab, OnlineExchangeKind::literatureReading,
        );
        :>> preferredITPlatform = (ITPlatformKind::slackDiscord, ITPlatformKind::googleWorkspace,);
        :>> securityRule = (
            SecurityRuleKind::anonymizeData, SecurityRuleKind::noCompanyProjectNames,
        );
        :>> uniqueCapability = "MBSE 측면을 강화해 국내 도입 시 도움을 주면 좋겠습니다.";
    }

    part '박홍석' : IncoseKoreaChapterMember {
        :>> name = "박홍석";
        :>> email = "hongseok@selab.ai";
        :>> affiliation = "시스템엔지니어링(주)";
        :>> position = "연구개발팀 연구원";
        :>> phoneNumber = "010-8944-3072";
        :>> region = (RegionKind::seoul, RegionKind::gyeonggiIncheon,);
        :>> domain = DomainKind::academiaAndResearch;
        :>> preferredActivity = (
            "MBSE, SysML, UAF, Digital Engineering 등 신흥 SE 기술 지식 교류",
            "해외 SE 전문가 초청 국제 세미나 및 워크숍",
            "국내 SE 전문가 간의 네트워킹 및 전문적 교류",
        );

        :>> interestKeyword = ("SysML v2", "ISO 15288", "아키텍처 설계",);
        :>> coreValueWhat =
            "나는 [실무에서 전체 아키텍처를 설계]할 때, 챕터 활동을 통해, [시니어 설계자의 관점과 계층 분리 사례를 접할 기회]를 얻을 수 있어야 한다.";
        :>> rationale =
            "기획자부터, 개발자, 의사결정자 등 다양한 사람과 소통해야 하는데, 각 자리에 따라 적절한 관점 전환과 적절한 추상화 계층에서 논의하는 노련함의 강력함과 필요성을 실감하기 때문입니다.";
        :>> validationCriterion =
            "300명 이상 고객 확보. 실무에서 개발 중인 MBSE 도구가 실제 국제 무대에서 인정받고 안정적 운영이 이루어진다면 좋겠습니다.";
        :>> priority = "1. 시니어와의 세미나";
        :>> giveResource = GiveResourceKind::toolExpertise;
        :>> giveDetail = "자사에서 개발 중인 SysML v2 기반 MBSE 도구를 기반으로 한 실습 제공 가능";
        :>> operationalConstraint =
            "개발 중인 모델링 도구의 내부 테스트 단계라서, 실습을 통하여 개선 소요 수집 및 문제 신고를 받을 수 있음";
        :>> preferredOnlineExchange = (
            OnlineExchangeKind::seminar, OnlineExchangeKind::projectLab,
            OnlineExchangeKind::literatureReading,
        );
        :>> preferredITPlatform = ITPlatformKind::googleWorkspace;
        :>> securityRule = SecurityRuleKind::none;
    }

    // ---- 설문 2 응답 없는 회원 (설문 1 정보만 유지) ----
    part '심정환' : IncoseKoreaChapterMember {
        :>> name = "심정환";
        :>> email = "jshim@lotustech.co.kr, jshim10@gmail.com";
        :>> affiliation = "로터스정보기술";
        :>> position = "대표이사";
        :>> phoneNumber = "010-3270-3997";
        :>> region = (RegionKind::seoul, RegionKind::gyeonggiIncheon,);
        :>> domain = DomainKind::itAndSoftware;
        :>> preferredActivity = (
            "MBSE, SysML, UAF, Digital Engineering 등 신흥 SE 기술 지식 교류",
            "INCOSE 리소스(SE Handbook, SE 역량 등) 기반 전문성 개발 및 SEP 자격증 스터디",
            "국내 SE 전문가 간의 네트워킹 및 전문적 교류",
        );
        :>> expectation = "INCOSE 공인 국제 인증자격 관련 소모임 또는 스터디그룹";
    }

    part '최성열' : IncoseKoreaChapterMember {
        :>> name = "최성열";
        :>> email = "bm0611@gmail.com";
        :>> affiliation = "현대모비스";
        :>> position = "책임연구원 / 시스템 엔지니어";
        :>> phoneNumber = "010-6302-3888";
    }

    part '최지원' : IncoseKoreaChapterMember {
        :>> name = "최지원";
        :>> email = "ein1013@selab.ai";
        :>> affiliation = "아주대학교";
        :>> position = "공학연구소 연구원";
        :>> phoneNumber = "010-8217-0205";
        :>> region = RegionKind::seoul;
        :>> domain = (DomainKind::itAndSoftware, DomainKind::academiaAndResearch,);
        :>> preferredActivity = (
            "MBSE, SysML, UAF, Digital Engineering 등 신흥 SE 기술 지식 교류",
            "해외 SE 전문가 초청 국제 세미나 및 워크숍",
            "INCOSE 리소스(SE Handbook, SE 역량 등) 기반 전문성 개발 및 SEP 자격증 스터디",
        );
        :>> expectation = "국내 학회 참여 경험이 없어 잘 모릅니다. 많이 배우고 싶습니다.";
    }
} // package ChapterMembersDirectory
