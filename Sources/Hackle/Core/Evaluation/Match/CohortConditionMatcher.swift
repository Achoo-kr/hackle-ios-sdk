//
//  CohortConditionMatcher.swift
//  Hackle
//
//  Created by yong on 2023/10/03.
//

import Foundation


class CohortConditionMatcher: ConditionMatcher {

    private let valueOperatorMatcher: ValueOperatorMatcher

    init(valueOperatorMatcher: ValueOperatorMatcher) {
        self.valueOperatorMatcher = valueOperatorMatcher
    }

    func matches(request: EvaluatorRequest, context: EvaluatorContext, condition: Target.Condition) throws -> Bool {
        guard condition.key.type == .cohort else {
            throw HackleError.error("Unsupported TargetKeyType [\(condition.key.type)]")
        }
        let cohortIds = request.user.cohorts.map({ $0.id })
        return valueOperatorMatcher.matches(userValue: cohortIds, match: condition.match)
    }
}
