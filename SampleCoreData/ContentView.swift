//
//  ContentView.swift
//  SampleCoreData
//
//  Created by Capgemini-DA161 on 4/7/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var companyName: String = ""
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Company.name, ascending: true)], animation: .default)
    private var companies: FetchedResults<Company>
    
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    TextField("Company Name", text: $companyName)
                        .textFieldStyle(.roundedBorder)
                    Button(action: addCompany) {
                        Label("", systemImage: "plus")
                    }
                }.padding()
                List {
                    ForEach(companies) {company in
                        NavigationLink(destination: UpdateCountryView(company: company)) {
                            Text(company.name ?? "")
                        }
                    }.onDelete(perform: deleteCompany)
                }
            }
        }
       
    }
    
    private func deleteCompany(offsets: IndexSet) {
        withAnimation {
            offsets.map { companies[$0] }.forEach(viewContext.delete)
            PersistanceController.shared.saveContext()
        }
    }
    
    private func addCompany() {
        withAnimation {
            let newCompany = Company(context: viewContext)
            newCompany.name = companyName
            PersistanceController.shared.saveContext()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistanceController.preview.container.viewContext)
    }
}
