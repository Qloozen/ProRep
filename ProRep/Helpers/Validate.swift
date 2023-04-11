//
//  Validate.swift
//  ProRep
//
//  Created by Qiang Loozen on 11/04/2023.
//

import Foundation

class Validate {
    public static func email(_ email: String?) -> String?{
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        if !predicate.evaluate(with: email) {
            return "Invalid email address!"
        }
        
        return nil
    }
    
    public static func password(_ password: String?) -> String?{
        if let password, password.count >= 6 {
            return nil
        }
        
        return "Password must be atleast 6 characters long!"
    }
    
    public static func confirmPassword(_ password: String?, _ confirmPassword: String?) -> String?{
        if let password, let confirmPassword, password == confirmPassword {
            return nil
        }
        
        return "Passwords do not match!"
    }
}
