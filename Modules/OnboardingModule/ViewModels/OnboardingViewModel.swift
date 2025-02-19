//
//  OnboardingViewModel.swift
//  Pods
//
//  Created by Ahmad Alawneh on 19/02/2025.
//

import Foundation
import RxSwift
import Resolver
import CoreModule

public class OnboardingViewModel: ObservableObject {
    private let apiClient: APIClientProtocol
    private let disposeBag = DisposeBag()

    @Published public var onboardingData: [String] = []

    public init(apiClient: APIClientProtocol = Resolver.resolve()) {
        self.apiClient = apiClient
    }

    public func fetchOnboardingData() {
        apiClient.request(endpoint: .onboarding, method: .GET)
            .subscribe(onNext: { (data: [String]) in
                self.onboardingData = data
            }, onError: { error in
                print("Error: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
