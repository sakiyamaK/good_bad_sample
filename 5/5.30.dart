class Equipment {}

class Equipments {
  bool get canChange => true; //本来はロジックが入ってtrue/falseが返る
  Equipment head = Equipment();
  Equipment armor = Equipment();
  Equipment arm = Equipment();
}

class Member {
  final Equipments equipments = Equipments();
}

class Party {
  final List<Member> members = [Member(), Member(), Member()];
}

void equipArmor(Party party, int memberId, Equipment newAromor) {
  // [BAD]
  // パラメータの中のパラメータの中のパラメータ...とどんどん深いところのパラメータにアクセスしている
  // カプセル化できておらず、これではどこからでもアクセス可能であり、どこでどうarmorが変わったのか分からなくなる
  if (party.members[memberId].equipments.canChange) {
    party.members[memberId].equipments.armor = newAromor;
  }
}
