class Rectangle {
  final double width;
  final double height;

  Rectangle({required this.width, required this.height});

  // 本では関数だが
  // dartではcomputed propertyがあるためそれで用意
  // 実質パラメータのない関数と思っていい
  double get area => width * height;
}

class Circle {
  final double radius;

  Circle({required this.radius});

  // 本では関数だが
  // dartではcomputed propertyがあるためそれで用意
  // 実質パラメータのない関数と思っていい
  double get area => radius * radius * 3.14159265359;
}

// 6.22
void showArea(Object object) {
  // [BAD]
  // objectのクラスが増える度にif elseの分岐が増えていく
  if (object is Rectangle) {
    print(object.area);
  } else if (object is Circle) {
    print(object.area);
  }
}

void main() {
  var rectangle = Rectangle(width: 10, height: 10);
  showArea(rectangle);
}
