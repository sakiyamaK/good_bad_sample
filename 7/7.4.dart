enum MemberStateType {
  poison, dead
}

class Member {
  String name;
  int hitPoint;
  List<MemberStateType> stateTypes = [];

  Member({required this.name, required this.hitPoint});

  void removeState(MemberStateType state) {
    stateTypes.removeWhere((element) => element == state);
  }

  void addState(MemberStateType state) {
    stateTypes.add(state);
  }
}

void main() {
  var members = [
    Member(name: "田中", hitPoint: 100), 
    Member(name: "山田", hitPoint: 100)
  ];

  // 毒状態ならHPを減らす
  // [GOOD]
  // ifとcontinueで
  // 入れ子を解消して見やすくした
  // それより下のコードを追う必要をなくした
  for (var member in members) {
    if (member.hitPoint <= 0 || !member.stateTypes.contains(MemberStateType.poison)) continue;

    member.hitPoint -= 10;

    if (member.hitPoint > 0) continue;

    member.addState(MemberStateType.dead);
    member.removeState(MemberStateType.poison);
  }
}
