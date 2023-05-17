// 6.19
struct Rectangle {
    let width: Double
    let height: Double
    
    // 本では関数だが
    // swiftではcomputed propertyがあるためそれで用意
    // 実質パラメータのない関数と思っていい
    var area: Double {
        width * height
    }
}


struct Circle {
    let radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    // 本では関数だが
    // swiftではcomputed propertyがあるためそれで用意
    // 実質パラメータのない関数と思っていい
    var area: Double {
        radius * radius * Double.pi
    }
}

// 6.21
// [BAD]
// RectangleだろうとCircleだろうと
// 同じようことを意味するareaパラメータなら呼び出せていいのに
// 型が違うためビルドエラーになる
//let object: Rectangle = Circle(radius: 10)
//print(object.area)

// 6.22
func showArea(object: Any) {
    // [BAD]
    // objectのクラスが増える度にif elseの分岐が増えていく
    if let rectangle = object as? Rectangle {
        print(rectangle.area)
    } else if let circle = object as? Circle {
        print(circle.area)
    }
}

let rectangle = Rectangle(width: 10, height: 10)
showArea(object: rectangle)
