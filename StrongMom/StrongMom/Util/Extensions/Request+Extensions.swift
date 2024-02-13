//
//  Request+Extensions.swift
//  StrongMom
//
//  Created by artem on 08.02.2024.
//

import Alamofire

extension Request {
    public func debugLog() -> Self {
#if DEBUG
        debugPrint(self)
#endif
        return self
    }
}
