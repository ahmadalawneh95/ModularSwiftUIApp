//
//  AppDIContainer.swift
//  ModularSwiftUIApp
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import Resolver
import CoreModule

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { APIClient() as APIClientProtocol }
    }
}
