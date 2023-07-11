class Member {
  final int id;
  final bool isAlive;

  Member(this.id, this.isAlive);
}

// フィールドに関する処理のあるクラス
class FieldManager {
  static const int maxMemberNumber = 4;
  List<Member> members = [];

  FieldManager(this.members);

  // [BAD]
  // フィールドでパーティーを追加するメソッドなわけだが
  // イベントでパーティーを追加したり、戦闘中にパーティーが抜けたり
  // などなど別のManagerで同じロジックが入る可能性が高い
  // まぁそもそもFieldでやることなんて他にもたくさんあるだろうから
  // メンバーに関するロジックを記載したらFatなクラスになるに決まってる
  void add(Member newMember) {
    if (members.any((member) => member.id == newMember.id)) {
      throw Exception("すでに存在している");
    }
    if (members.length >= maxMemberNumber) {
      throw Exception("最大人数を超えています");
    }
    members.add(newMember);
  }
  
  // [BAD]
  // 上のメソッドと同じ理由
  bool partyIsAlive() => members.any((member) => member.isAlive);
}

// 戦闘に関する処理のあるクラス
class BattleManager {
  static const int maxMemberNumber = 4;
  List<Member> members = [];

  BattleManager(this.members);

  // [BAD]
  // FieldManagerと同様のロジック
  void add(Member newMember) {
    if (members.any((member) => member.id == newMember.id)) {
      throw Exception("すでに存在している");
    }
    if (members.length >= maxMemberNumber) {
      throw Exception("最大人数を超えています");
    }
    members.add(newMember);
  }
}

void main() {
  final members = List<Member>.generate(3, (index) => Member(index + 1, true));
  final field = FieldManager(members);
  field.add(Member(10, true));
  print(field.members);
}
