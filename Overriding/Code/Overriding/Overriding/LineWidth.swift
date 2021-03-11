//
//  LineWidth.swift
//  Overriding
//
//  Created by Steven Curtis on 09/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

//public class LoginButton {
//    public var lineWidth: Double = 1.0
//}

//public class LogoutButton: LoginButton {
//    override public var lineWidth: Double = 2.0
//}


public class LoginButton {
    public var lineWidth: Double = 1.0
}

public class LogoutButton: LoginButton {
    override public var lineWidth: Double {
        get {
            return 2.0
        }
        set { }
}
}
