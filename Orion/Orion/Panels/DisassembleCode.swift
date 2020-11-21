//
//  DisassembleCode.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct DisassembleCode: View {
    var body: some View {
        GeometryReader { geo in
            WebView(width: geo.size.width, height: geo.size.height, htmlName: "index")
        }
    }
}

struct DisassembleCode_Previews: PreviewProvider {
    static var previews: some View {
        DisassembleCode()
    }
}
