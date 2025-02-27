//
//  StringExtension.swift
//  Assignment
//
//  Created by Keval Thumar on 25/02/25.
//

import Foundation

extension String {
    func validateEmailId() -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return applyPredicateOnRegex(regexStr: emailRegEx)
    }

    private func applyPredicateOnRegex(regexStr: String) -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines) // Handle extra spaces
        let predicate = NSPredicate(format: "SELF MATCHES %@", regexStr)
        return predicate.evaluate(with: trimmedString)
    }
}

