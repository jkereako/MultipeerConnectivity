//
//  ViewController.swift
//  MultipeerConnectivity
//
//  Created by Jeff Kereakoglow on 3/10/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit
import PeerKit

final class ViewController: UIViewController {
    @IBOutlet weak private var serviceName: UILabel!
    @IBOutlet weak private var status: UILabel!

    // Hold on to a reference to keep it alive
    private let peerKit: PeerKit

    init() {
        let serviceName = "dummy-service"
        peerKit = PeerKit(serviceName: serviceName)

        super.init(nibName: "View", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.serviceName.text = peerKit.serviceName

        peerKit.delegate = self
        peerKit.advertise()
        peerKit.browse()
        status.text = "Advertising and browsing..."
    }
}

// MARK: - SessionDelegate
extension ViewController: PeerKitDelegate {
    func didFailToAdvertise(error: Error) {
        status.text = "Failed to advertise"
        print("\(error)")
    }

    func didFailToBrowse(error: Error) {
        status.text = "Failed to browse"
        print("\(error)")
    }

    func peerKit(_ peerKit: PeerKit, didReceiveEvent event: String, withObject object: AnyObject) {
        status.text = "Received \(event)"
    }
    
    func peerKit(_ peerKit: PeerKit, isConnectingToPeer peer: MCPeerID) {
        status.text = "Connecting to \(peer.displayName)"
    }

    func peerKit(_ peerKit: PeerKit, didConnectToPeer peer: MCPeerID) {
        status.text = "Connected to \(peer.displayName)"
    }

    func peerKit(_ peerKit: PeerKit, didDisconnectFromPeer peer: MCPeerID) {
        status.text = "Disconnected from \(peer.displayName)"
    }
}
