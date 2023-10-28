import ComposableArchitecture
import SwiftUI

@main
struct userdefault_tcaApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: RootFeature.State(), reducer: {
                RootFeature()
            }))
            
        }
    }
}
