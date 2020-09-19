import 'package:flutter/material.dart';
import 'package:h_safari/widget/widget.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, '개인정보처리방침'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('H-Safari는 개인정보 보호법 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리지침을 수립 ․공개합니다. \n\n'),

                Row(
                  children: [
                    Text('제1조(개인정보의 처리목적)', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Text('H-Safari는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다. \n'),
                Text('\t1. 회원 가입 및 관리\n\t회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별 ․인증, 회원자격 유지 ․관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 만 14세 미만 아동의 개인정보 처리시 법정대리인의 동의여부 확인, 각종 고지 ․통지, 고충처리 등을 목적으로 개인정보를 처리합니다. \n'),
                Text('\t2. 재화 또는 서비스 제공\n\t서비스 제공, 콘텐츠 제공, 맞춤서비스 제공, 본인인증, 연령인증 등을 목적으로 개인정보를 처리합니다. \n'),
                Text('\t3. 고충처리\n\t민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락 ․통지, 처리결과 통보 등의 목적으로 개인정보를 처리합니다.\n'),

                Row(
                  children: [
                    Text('제2조(개인정보의 처리 및 보유기간)', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Text('① H-Safari는 법령에 따른 개인정보 보유 ․이용기간 또는 정보주체로부터 개인정보를 수집시에 동의받은 개인정보 보유 ․이용기간 내에서 개인정보를 처리 ․보유합니다. \n'),
                Row(children: [Text('② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다. \n'),]),
                Row(children: [Text('\t1. 회원 가입 및 관리 : H-Safari 어플 탈퇴 후 6개월까지\n다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료시까지\n'),]),
                Text('\t\t1) 관계 법령 위반에 따른 수사 ․조사 등이 진행중인 경우에는 해당 수사 ․조사 종료시까지\n\t\t2) 어플 이용에 따른 채권 ․채무관계 잔존시에는 해당 채권 ․채무관계 정산시까지 \n'),
                Text('2. 재화 또는 서비스 제공 : 재화 ․서비스 공급완료 및 요금결제․정산 완료시까지\n다만, 다음의 사유에 해당하는 경우에는 해당 기간 종료시까지 \n'),
                Text('\t1) 「전자상거래 등에서의 소비자 보호에 관한 법률」에 따른 표시 ․광고, 계약내용 및 이행 등 거래에 관한 기록 \n\t\t\t'),
                Text('\t- 표시 ․광고에 관한 기록 : 6개월 \n\t- 계약 또는 청약철회, 대금결제, 재화 등의 공급기록 : 5년\n\t- 소비자 불만 또는 분쟁처리에 관한 기록 : 3년 \n'),
                Row(children: [Text('\t2)「통신비밀보호법」제41조에 따른 통신사실확인자료 보관\n\t\t'),],),
                Text('\t\t- 가입자 전기통신일시, 개시 ․종료시간, 상대방 가입자번호, 사용도수, 발신기지국 위치추적자료 : 1년 \n\t\t- 컴퓨터통신, 인터넷 로그기록자료, 접속지 추적자료 : 6개월\n'),
                Text('\t3) 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」시행령 제29조에 따른 본인확인정보 보관 : 게시판에 정보 게시가 종료된 후 6개월\n'),

                Row(
                  children: [
                    Text('제3조(개인정보의 제3자 제공) ', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Text('① H-Safari는 정보주체의 개인정보를 제1조(개인정보의 처리 목적)에서 명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 개인정보 보호법 제17조 및 제18조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다. '),
                Text('② H-Safari는 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.'),
                Row(children: [Text('1. CRA (한동대학교 동아리) '),],),
                Text('\t- 개인정보를 제공받는 자 : CRA\n\t- 제공받는 자의 개인정보 이용목적 : 이벤트 공동개최 및 서비스 관리\n\t- 제공하는 개인정보 항목 : 학번\n\t- 제공받는 자의 보유 ․이용기간 : 어플 탈퇴 후 6개월까지\n'),

                Row(
                  children: [
                    Text('제4조(개인정보처리의 위탁) ', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(children: [Text('① H-Safari는 개인정보 처리업무를 위탁하고 있지 않습니다. \n'),],),

                Row(
                  children: [
                    Text('제5조(정보주체와 법정대리인의 권리․의무 및 행사방법) ', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Text('① 정보주체는 H-Safari에 대해 언제든지 개인정보 열람 ․정정 ․삭제 ․처리정지 요구 등의 권리를 행사할 수 있습니다.'),
                Text('② 제1항에 따른 권리 행사는 H-Safari에 대해 개인정보보호법 시행령 제41조제1항에 따라 서면, 전자우편 등을 통하여 하실 수 있으며, H-Safari는 이에 대해 지체없이 조치하겠습니다. '),
                Text('③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다. '),
                Text('④ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 H-Safari는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다. '),
                Text('⑤ 정보주체는 개인정보 보호법 등 관계법령을 위반하여 H-Safari가 처리하고 있는 정보주체 본인이나 타인의 개인정보 및 사생활을 침해하여서는 아니됩니다. '),
                Text('⑥ H-Safari는 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다. \n'),

                Row(
                  children: [
                    Text('제6조(처리하는 개인정보 항목) ', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(children: [Text('H-Safari는 다음의 개인정보 항목을 처리하고 있습니다. '),],),
                Row(children: [Text('1. 어플 회원 가입 및 관리\n\t․필수항목 : 아이디(학번)'),],),
                Row(children: [Text('2. 재화 또는 서비스 제공\n\t․선택항목 : 성명, 전화번호, 주소, 은행계좌정보 등 결제정보'),],),
                Text('3. 인터넷 서비스 이용과정에서 아래 개인정보 항목이 자동으로 생성되어 수집될 수 있습니다.\n\t․IP주소, MAC주소, 서비스 이용기록, 방문기록, 불량 이용기록 등 \n'),
                Row(children: [Text('4. H-Safari는 개인정보중에 주소, 은행계좌정보 등 결제정보를 수집하지 않습니다.\n'),],),

                Row(
                  children: [
                    Text('제7조(개인정보의 파기) ', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Text('① H-Safari는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다. '),
                Text('② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다. '),
                Row(children: [Text('③ 개인정보 파기의 절차 및 방법은 다음과 같습니다. '),],),
                Text('\t1. 파기절차\n\t\tH-Safari는 파기 사유가 발생한 개인정보를 선정하고, 개인정보를 파기합니다. '),
                Text('\t2. 파기방법\n\t\tH-Safari는 전자적 파일 형태로 기록․저장된 개인정보는 기록을 재생할 수 없도록 파기하며, 종이 문서에 기록․저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다. \n'),

                Row(
                  children: [
                    Text('제8조(개인정보의 안전성 확보조치)', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Text('H-Safari는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다. '),
                Row(children: [Text('\t1. 관리적 조치 : 정기적 직원 교육'),],),
                Row(children: [Text('\t2. 기술적 조치 : 개인정보처리시스템 등의 접근권한 관리,\n'),],),

                Row(
                  children: [
                    Text('제9조(개인정보 자동 수집 장치의 설치∙운영 및 거부에 관한 사항) ', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Text('① H-Safari는 정보주체의 이용정보를 저장하고 수시로 불러오는 ‘쿠기(cookie)’를 사용하지 않습니다.\n'),

                Row(
                  children: [
                    Text('제10조(개인정보 보호책임자)', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Text('① H-Safari는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.\n '),
                Text('\t▶ 개인정보 보호책임자\n\t성명 : 박수현\n\t직책 : H-Safari 팀장\n\t연락처 : HandongSafari@gmail.com\n'),
                Text('② 정보주체께서는 H-Safari의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. H-Safari는 정보주체의 문의에 대해 지체없이 답변 및 처리해드릴 것입니다. \n'),

                Row(
                  children: [
                    Text('제12조(권익침해 구제방법) ', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Text('정보주체는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을 문의하실 수 있습니다. '),
                Text('<아래의 기관은 H-Safari와는 별개의 기관으로서, H-Safari의 자체적인 개인정보 불만처리, 피해구제 결과에 만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다>\n'),
                Text('\t▶ 개인정보 침해신고센터 (한국인터넷진흥원 운영)\n\t- 소관업무 : 개인정보 침해사실 신고, 상담 신청\n\t- 홈페이지 : privacy.kisa.or.kr\n\t- 전화 : (국번없이) 118\n\t- 주소 : (58324) 전남 나주시 진흥길 9(빛가람동 301-2) 3층 개인정보침해신고센터\n'),
                Text('\t▶ 개인정보 분쟁조정위원회\n\t- 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)\n\t- 홈페이지 : www.kopico.go.kr\n\t- 전화 : (국번없이) 1833-6972\n\t- 주소 : (03171)서울특별시 종로구 세종대로 209 정부서울청사 4층\n'),
                Text('\t▶ 대검찰청 사이버범죄수사단 : 02-3480-3573 (www.spo.go.kr)\n'),
                Text('\t▶ 경찰청 사이버안전국 : 182 (http://cyberbureau.police.go.kr)\n'),

                Row(
                  children: [
                    Text('제13조(영상정보처리기기 설치․운영) ', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(children: [Text('\t① H-Safari는 영상정보처리기기를 설치․운영하고 있지 않습니다. \n'),],),

                Row(
                  children: [
                    Text('제14조(개인정보 처리방침 변경)', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(children: [Text('\t① 이 개인정보 처리방침은 2020. 08. 21부터 적용됩니다.\n'),],),
              ],
            ),
          ),
        ));
  }
}
