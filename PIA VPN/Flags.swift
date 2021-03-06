//
//  Flags.swift
//  PIA VPN
//
//  Created by Davide De Rosa on 12/17/17.
//  Copyright © 2017 London Trust Media. All rights reserved.
//

import Foundation
import PIALibrary

class Flags: NSObject {
    static let shared = Flags()
    
    // initialize to production values here

    @objc private(set) var usesDevelopmentClient = false

    @objc private(set) var customizesClientEnvironment = false
    
    @objc private(set) var customizesWelcomePreset = false

    @objc private(set) var usesMockAccount = false

    @objc private(set) var usesMockInApp = false
    
    @objc private(set) var usesMockVPN = false

    @objc private(set) var alwaysShowsWalkthrough = false

    @objc private(set) var enablesResetSettings = true
    
    @objc private(set) var enablesProtocolSelection = true

    @objc private(set) var enablesMACESetting = false
    
    @objc private(set) var enablesContentBlockerSetting = true
    
    @objc private(set) var enablesEncryptionSettings = true

    @objc private(set) var enablesDevelopmentSettings = false

    @objc private(set) var customizesVPNRenegotiation = false

    private override init() {
        super.init()
        
        #if PIA_DEV
            guard let path = AppConstants.Flags.developmentPath else {
                fatalError("Couldn't find flags path")
            }
            load(from: path)
        #endif
    }
    
    private func load(from path: String) {
        guard let toggles = NSDictionary(contentsOfFile: path) as? [String: Bool] else {
            fatalError("Couldn't load plist from \(path)")
        }
        for (key, value) in toggles {
            setValue(value, forKeyPath: key)
        }
    }
}
