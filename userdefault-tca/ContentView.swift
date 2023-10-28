import ComposableArchitecture
import SwiftUI

struct RootFeature: Reducer {
    struct State: Equatable {
        var path = StackState<Path.State>()
    }
    enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
    
    
    struct Path: Reducer {
        enum State: Equatable {
            case child(ChildFeature.State = .init())
        }
        enum Action: Equatable {
            case child(ChildFeature.Action)
        }
        var body: some ReducerOf<Self> {
            Scope(state: /State.child, action: /Action.child) {
                ChildFeature()
            }
        }
    }
}


struct ContentView: View {
    let store: StoreOf<RootFeature>
    
    var body: some View {
            NavigationStackStore(
                self.store.scope(state: \.path, action: { .path($0) })
            ) {
                Form {
                    
                    Section(header: Text("settings.read")) {
                        NavigationLink("test", state: RootFeature.Path.State.child())
                        
                    }
                }
            } destination: { state in
                // A view for each case of the Path.State enum
                switch state {
                case .child:
                    CaseLet(
                        /RootFeature.Path.State.child,
                         action: RootFeature.Path.Action.child,
                         then: ChildView.init(store:)
                    )
                }
            }
    }
}

#Preview {
    ContentView(store: Store(initialState: RootFeature.State(), reducer: {
        RootFeature()
    }))
}
