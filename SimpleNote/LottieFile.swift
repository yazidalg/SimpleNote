//
//  LottieFile.swift
//  SimpleNote
//
//  Created by Yazid Al Ghozali on 09/02/24.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var name = "success"
    var loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: Context) -> some LottieAnimationView {
        let animationView = LottieAnimationView(name: name, bundle: Bundle.main)
        animationView.loopMode = loopMode
        animationView.play()
        return animationView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView()
    }
}
