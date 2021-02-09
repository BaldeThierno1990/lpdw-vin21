//
//  ContentView.swift
//  Vin21
//
//  Created by Etienne Vautherin on 08/02/2021.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject var model: Model
    
    // Etat définissant l'affichage de la vue de login
    @State var isShowingLogin = true
    
    var body: some View {
        VStack {
            
            if (model.user?.email == .none) {
                Text("Hello, world!")
                    .padding()
            } else {
                Text("Hello, \(model.user!.email!)")
                    .padding()
            }
            
            Button("Sign Out") {
                do {
                    try Auth.auth().signOut()
                    model.user = .none
                } catch {
                    print("Sign Out Error: \(error.localizedDescription)")
                }
            }
            
        }
        
        // Observation de la valeur de model.user
        // Si user est défini, isShowingLogin prend la valeur false
        // Si user n'est pas défini, isShowingLogin prend la valeur true
        .onChange(of: model.user) { (user) in
            isShowingLogin = (user == .none)
        }
        
        // La vue LoginView est affichée par dessus VStack lorsque isShowingLogin est vrai
        .sheet(isPresented: $isShowingLogin) {
            LoginView(model: model)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: Model())
    }
}
