class Member {
  final int id;
  final bool isAlive;

  Member(this.id, this.isAlive);
}

extension MemberList on List<Member> {
  // [GOOD]
  // Memberの配列を操作する処理はここに集約される
  // 書籍に書いていることをあれこれ考える必要はない
  void addMember(Member newMember, {int maxMemberNumber = 4}) {
    if (this.any((member) => member.id == newMember.id)) {
      throw Exception("すでに存在している");
    }
    if (this.length >= maxMemberNumber) {
      throw Exception("最大人数を超えています");
    }
    this.add(newMember);
  }
  
  bool get partyIsAlive => this.any((member) => member.isAlive);
}

void main() {
  final members = List<Member>.generate(3, (index) => Member(index + 1, true));
  members.addMember(Member(10, true));
  print(members);
}
