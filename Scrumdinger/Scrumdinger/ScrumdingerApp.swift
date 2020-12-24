//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Kristina Gelzinyte on 12/23/20.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.data
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
