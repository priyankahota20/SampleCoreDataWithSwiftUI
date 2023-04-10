//
//  UpdateCountryView.swift
//  SampleCoreData
//
//  Created by Capgemini-DA161 on 4/7/23.
//

import SwiftUI

struct UpdateCountryView: View {
    @StateObject var company: Company
    @State private var companyName: String = ""
    var body: some View {
        VStack {
            HStack {
                TextField("Update Company Name", text: $companyName)
                    .textFieldStyle(.roundedBorder)
                Button(action: updateCompany) {
                    Label("", systemImage: "arrowshape.turn.up.left")
                }
            }.padding()
            Text(company.name ?? "")
            Spacer()
        }
    }
    
    private func updateCompany() {
        withAnimation {
            company.name = companyName
            PersistanceController.shared.saveContext()
        }
    }
}

struct UpdateCountryView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistanceController.preview.container.viewContext
        let newCompany = Company(context: viewContext)
        newCompany.name = "IBM"
        return UpdateCountryView(company: newCompany).environment(\.managedObjectContext, PersistanceController.preview.container.viewContext)
    }
}
