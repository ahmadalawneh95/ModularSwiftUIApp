import SwiftUI

public struct OnboardingView: View {
    public init() {}

    public var body: some View {
        VStack {
            Text("Welcome to the App!")
                .font(.largeTitle)
            Button("Continue") {
                print("Onboarding Completed")
            }
        }
    }
}


// ✅ Add this to enable preview
#Preview {
    OnboardingView()
}
