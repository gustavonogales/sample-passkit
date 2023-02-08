//
//  ContentView.swift
//  sample-passkit
//
//  Created by Gustavo Nogales on 07/02/23.
//

import PassKit
import SwiftUI

struct ContentView: View {
    @State var status: String = "Unknown"
    @State var wasAdded: Bool = false
    @State var pass: PKPass?
    @State var loading: Bool = false
    @State var showAddPass: Bool = false
    
    var body: some View {
        VStack {
            Button(
                action: check, label: {
                    Text("Check Availability")
                }
            ).padding(.bottom)
            Text(status)
            if self.loading {
                ProgressView()
            } else {
                AddPassToWalletButton(action: addToWallet).frame(width: 250.0, height: 50.0).padding()
            }
            Text("Was Added?").padding(.top)
            Text(wasAdded ? "Yes" : "No")
        }.onAppear {
            verifyIfPassIsAdded()
        }
        .sheet(isPresented: self.$showAddPass, onDismiss: wasPassAdded) {
            WalletViewController(pass: $pass)
        }
    }
                   
    func check() -> Void {
       let canAdd = PKAddPassesViewController.canAddPasses()
       self.status = canAdd ? "Can Add" : "Cannot Add"
    }
    
    func addToWallet() {
        self.loading = true
        if let asset = NSDataAsset(name: "Test") {
            pass = try? PKPass.init(data: asset.data)
            showAddPass = true
        }
        self.loading = false
    }
    
    func wasPassAdded() {
        wasAdded = PKPassLibrary().containsPass(self.pass!)
    }
    
    func verifyIfPassIsAdded() {
        let addedPass = PKPassLibrary().pass(withPassTypeIdentifier: "pass.br.com.kamino.app.pre-paid-credit", serialNumber: "8j23fm3")
        if(addedPass != nil) {
            wasAdded = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
