//
//  ContentView.swift
//  FindMe
//
//  Created by Andrea Costantin on 04/03/25.
//

import SwiftUI

struct ContentView: View {
    /// View Properties
    @State private var activeTab: TabModel = .maps
    @State private var isTabBarHidden: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                if #available(iOS 18, *) {
                    TabView(selection: $activeTab) {
                        Tab.init(value: .maps) {
                            MapView()
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        Tab.init(value: .search) {
                            SearchLocationView()
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        Tab.init(value: .settings) {
                            Text("Settings")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                    }
                } else {
                    TabView(selection: $activeTab) {
                        Text("Maps")
                            .tag(TabModel.maps)
                            .toolbar(.hidden, for: .tabBar)
                            .background {
                                if !isTabBarHidden {
                                    HideTabBar {
                                        print("Hidden")
                                        isTabBarHidden = true
                                    }
                                }
                            }
                        
                        Text("Search")
                            .tag(TabModel.search)
                        
                        Text("Settings")
                            .tag(TabModel.settings)
                    }
                }
            }
            TabBar(activeTab: $activeTab)
        }
    }
}

struct HideTabBar: UIViewRepresentable {
    var result: () -> ()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

extension UIView {
    var tabController: UITabBarController? {
        if let controller = sequence(first: self, next: {
            $0.next
        }).first(where: {$0 is UITabBarController}) as? UITabBarController {
            return controller
        }
        return nil
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationManager())
}
