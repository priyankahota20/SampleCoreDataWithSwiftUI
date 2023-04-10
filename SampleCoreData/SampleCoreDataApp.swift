//
//  SampleCoreDataApp.swift
//  SampleCoreData
//
//  Created by Capgemini-DA161 on 4/7/23.
//

import SwiftUI

@main
struct SampleCoreDataApp: App {
    let persistantController = PersistanceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistantController.viewContext)
        }
    }
}
