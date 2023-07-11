// dartはクラスの中でenumを定義できない
// そのためMemberの状態を表すことを名前で表現させるしかない
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
  final members = [
    Member(name: "田中", hitPoint: 100), 
    Member(name: "山田", hitPoint: 100)
  ];

  // 毒状態ならHPを減らす
  // [BAD]
  // 入れ子のif文
  for (var member in members) {
    if (member.hitPoint > 0) {
      if (member.stateTypes.contains(MemberStateType.poison)) {
        member.hitPoint -= 10;
        if (member.hitPoint <= 0) {
          member.addState(MemberStateType.dead);
          member.removeState(MemberStateType.poison);
        }
      }
    }
  }
}
