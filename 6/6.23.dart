// [GOOD]
// アブストラクトクラスで変数やメソッドを定義すれば
// それに準拠したクラスではそれらを必ず実装しなければならない「約束事」となる
abstract class Shape {
  double get area;
}

class Rectangle extends Shape {
  final double width;
  final double height;

  Rectangle({required this.width, required this.height});

  // RectangleはShapeの約束事であるareaを実装しないといけない
  @override
  double get area => width * height;
}


class Circle extends Shape {
  final double radius;

  Circle({required this.radius});

  // CircleはShapeの約束事であるareaを実装しないといけない
  @override
  double get area => radius * radius * 3.14159265359;
}

void main() {
  // [Good]
  // Shapeの約束を守っているクラスならなんでも代入できる
  // そのため先ほどのshowAreaメソッドはいらないし型判定の分岐もしなくていい
  Shape shape = Circle(radius: 10);
  print(shape.area);
}

// [おまけ]
// これはあくまでアブストラクトクラスの「ひとつの使い方」の話であり
// アブストラクトクラスを使えば他にも色んな使い方がある
// Flutterなら定番のcallbackパターンもアブストラクトクラスのひとつの使い方
