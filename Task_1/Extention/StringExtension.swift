//
//  StringExtension.swift
//  Assignment
//
//  Created by Keval Thumar on 25/02/25.
//

import Foundation

extension String {
    func validateEmailId() -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9]+\\.[A-Za-z]{2,}$"
        /*
         meaning
         ^ :- start with string not space
         [A-Z0-9a-z._%+-] :- for user name A to Z, a to z, 0 to 9, .,_,%,+,- allowed
         + :- menace at least one character will be there
         @ :- one always there
         [A-Za-z0-9]+ :- for the domain name like gmail,outlook etc..
         \\. :- one . string literal always there for top level domain like .com , .inventyv
         [A-Za-z]{2,}$ :- for the top level domain and {2,} is at least two character will be there and $ is for string will be end with this top level domain.
         */
        return applyPredicateOnRegex(regexStr: emailRegEx)
    }

    private func applyPredicateOnRegex(regexStr: String) -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines) // Handle extra spaces
        let predicate = NSPredicate(format: "SELF MATCHES %@", regexStr)
        return predicate.evaluate(with: trimmedString)
    }
}

