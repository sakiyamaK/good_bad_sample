class Equipment {}

class Equipments {
  // [GOOD]
  // パラメータがprivateで不用意にアクセスできないので安全
  // このクラスの中だけ注意していればいい
  bool get _canChange => true; //本来はロジックが入ってtrue/falseが返る
  Equipment? _head = Equipment();
  Equipment? _armor = Equipment();
  Equipment? _arm = Equipment();

  void equipArmor(final Equipment newArmor) {
    if (_canChange) {
      _arm = newArmor;
    }
  }

  void deactivateAll() {
    _head = null;
    _armor = null;
    _arm = null;
  }
}

class Member {
  final Equipments equipments = Equipments();
}

class Party {
  final List<Member> members = [Member(), Member(), Member()];
}

void equipArmor(Party party, int memberId, Equipment newAromor) {
  // [GOOD]
  // 装備できるかどうかのロジックはEquipmentsに集約されたのでここに必要がない
  party.members[memberId].equipments.equipArmor(newAromor);
}
