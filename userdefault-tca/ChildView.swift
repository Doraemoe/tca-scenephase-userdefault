import ComposableArchitecture
import SwiftUI

struct ChildFeature: Reducer {
    struct State: Equatable {
    }
    enum Action: Equatable {
        case test
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .test:
                UserDefaults.standard.set("test", forKey: "test")
                return .none
            }
        }
    }
}


struct ChildView: View {
    let store: StoreOf<ChildFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Button("test") {
                viewStore.send(.test)
            }
        }
    }
}
