//
//  Router.swift
//  MyReminder
//
//  Created by Illia Verezei on 08.03.2025.
//

import SwiftUI

enum Route: Hashable {
    case edit(Int)
}

final class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func showEdit(index: Int) {
        path.append(Route.edit(index))
    }
    
    func back() {
        path.removeLast()
    }
}
