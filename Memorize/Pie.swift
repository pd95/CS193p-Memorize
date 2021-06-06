//
//  Pie.swift
//  Memorize
//
//  Created by Philipp on 06.06.21.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        )

        var p = Path()
        
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        )
        p.addLine(to: center)

        return p
    }
}

struct PieShape_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Pie(startAngle: .degrees(-90), endAngle: .degrees(110-90), clockwise: false)
        }
        .aspectRatio(2/3, contentMode: .fit)
        .frame(maxWidth: 150)
        .previewLayout(.sizeThatFits)
    }
}
