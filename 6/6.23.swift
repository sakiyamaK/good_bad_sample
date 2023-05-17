// 6.23
// [GOOD]
// プロトコルに準拠したclassやstructなどは
// プロトコルで定義されている変数やメソッドは
// 絶対実装しなければいけない「約束事」となる

// つまりこのShapeプロトコルに準拠したらareaは絶対ある
protocol Shape {
    var area: Double { get }
}

struct Rectangle: Shape {
    let width: Double
    let height: Double
    
    // RectangleはShapeの約束事であるareaを実装しないといけない
    var area: Double {
        width * height
    }
}


struct Circle: Shape {
    let radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    // CircleはShapeの約束事であるareaを実装しないといけない
    var area: Double {
        radius * radius * Double.pi
    }
}

// 6.21
// [Good]
// Shapeの約束を守っているstruct(classなど)ならなんでも代入できる
// そのため先ほどのshowAreaメソッドはいらないし型判定の分岐もしなくていい
let shape: Shape = Circle(radius: 10)
print(shape.area)


// [おまけ]
// これはあくまでprotocolの「ひとつの使い方」の話であり
// protocolを使えば他にも色んな使い方がある
// iOSなら定番のdelegateパターンもprotocolのひとつの使い方
