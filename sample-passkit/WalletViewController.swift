//
//  walletViewController.swift
//  sample-passkit
//
//  Created by Gustavo Nogales on 07/02/23.
//

import Foundation
import UIKit
import SwiftUI
import PassKit

struct WalletViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = PKAddPassesViewController
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var pass: PKPass?
    
    func makeUIViewController(context: Context) -> PKAddPassesViewController {
        let passVC = PKAddPassesViewController(pass: self.pass!)!
        return passVC
    }
    
    func updateUIViewController(_ uiViewController: PKAddPassesViewController, context: Context) {
        
    }
}
