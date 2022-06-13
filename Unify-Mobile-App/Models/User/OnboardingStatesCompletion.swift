//
//  OnboardingStateProgressEnum.swift
//  Unify
//
//  Created by Melvin Asare on 14/11/2021.
//

import Foundation

public enum OnboardingStateProgressEnum: String {
    case uncomplete = "uncomplete"
    case completed = "complete"

    var onBoardingStateString: String {
        switch self {
        case .completed:
            return "completed"
        case .uncomplete:
            return "uncomplete"
        }
    }
}
