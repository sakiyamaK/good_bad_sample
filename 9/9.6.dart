// 装備品をmixinで定義
mixin Equipment {
  int get defense;
}

class Head with Equipment {
  @override
  final int defense;
  
  Head(this.defense);
}

class Body with Equipment {
  @override
  final int defense;
  
  Body(this.defense);
}

class Arm with Equipment {
  @override
  final int defense;
  
  Arm(this.defense);
}

// 強引に書籍のエラーが出るようにする書き方
class Member {
  /* 
  [BAD]
  書籍のエラーを出すためにあえてnullableで定義
  */
  Head? _head;
  Body? _body;
  Arm? _arm;

  Member(this._head, this._body, this._arm);

  void takeOffAllEquipments() {
    _head = null;
    _body = null;
    _arm = null;
  }

  int get totalDefense {
    /* 
    [BAD]
    書籍のエラーを出すためにあえてnullable型を!で強制アンラップしている
    */
    return _head!.defense + _body!.defense + _arm!.defense;
  }
}

void main() {
  // 装備品を付けてインスタンスを生成
  final member = Member(
    Head(10),
    Body(10),
    Arm(20),
  );


  /*
  
  数千行の色んな処理
  
  */

  // しれっと装備品が外れてる
  member.takeOffAllEquipments();

  /*
  
  数千行の色んな処理
  
  */

  // 防御力を計算してクラッシュ
  print(member.totalDefense);  
}

