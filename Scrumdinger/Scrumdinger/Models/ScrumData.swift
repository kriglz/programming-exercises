//
//  ScrumData.swift
//  Scrumdinger
//
//  Created by Kristina Gelzinyte on 12/25/20.
//

import Foundation

class ScrumData: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("scrums.data")
    }
    @Published var scrums: [DailyScrum] = []
}
