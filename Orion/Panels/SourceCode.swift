//
//  SourceCode.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct SourceCode: View {
    var body: some View {
        Panel(title: "source-code") {
            GeometryReader { geo in
                WebView(width: geo.size.width, height: geo.size.height, htmlName: "index")
            }
        }
    }
}

struct SourceCode_Previews: PreviewProvider {
    static var previews: some View {
        SourceCode()
    }
}
