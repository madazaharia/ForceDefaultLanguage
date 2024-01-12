//
//  BundleEx.swift
//  ForceDefaultLanguage
//
//  Created by Madalin Zaharia on 11.01.2024.
//

import Foundation

class BundleEx: Bundle {
    fileprivate static var kBundleKey: Int = 0
    fileprivate static var kKeyTableKey: Int = 1
    
    fileprivate static var tables = [
        "Localizable"
    ]
    
    private var keyTable = [String: String]()
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        
        var table = tableName
        
        if  table == nil,
            let keyTable = objc_getAssociatedObject(self, &BundleEx.kKeyTableKey) as? [String: String] {
            table = keyTable[key]
        }
        
        if let bundle = objc_getAssociatedObject(self, &BundleEx.kBundleKey) as? Bundle {
            return bundle.localizedString(forKey: key, value: value, table: table)
        } else {
            return super.localizedString(forKey: key, value: value, table: table)
        }
    }
}

extension Bundle {
    func setLanguage(language: String) {
        //RAM Impact: ~100KB for 400 keys
        object_setClass(self, BundleEx.self)
        if  let path = Bundle.main.path(forResource: language, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            objc_setAssociatedObject(Bundle.main, &BundleEx.kBundleKey, bundle, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            var keyTable = [String: String]()
            
            for table in BundleEx.tables {
                if  let path = bundle.path(forResource: table, ofType: "strings"),
                    let dictionary = NSDictionary(contentsOfFile: path) {
                    for (key, _) in dictionary {
                        if let stringKey = key as? String {
                            keyTable[stringKey] = table
                        }
                    }
                }
            }
            
            objc_setAssociatedObject(Bundle.main, &BundleEx.kKeyTableKey, keyTable, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
