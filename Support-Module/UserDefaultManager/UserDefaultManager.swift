
import Foundation


class NSUserDefaults: UserDefaults {

    private static var userDefaults: UserDefaults = {
        return UserDefaults.standard
    }()
}
//MARK: Extension
extension NSUserDefaults {
    ///- Note: Use for save Codable Model Object
    static func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            standard.set(data, forKey: key)
            standard.synchronize()
        }
    }
    /** Return: Use for Retrive Decodable Model Object */
    static func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = standard.object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
    ///- Note: Use for save Object
    static public func write<T>(value: T, forKey key: String) {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: value)
        standard.set(encodedData, forKey: key)
        standard.synchronize()
    }
    static public func readValue(forKey key: String) -> Any? {
        if let decoded = standard.object(forKey: key) as? NSData {
            let data = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)
            return data
        }
        return nil
    }

    static public func deleteObject(forKey key: String) {
        standard.removeObject (forKey: key)
        standard.synchronize ()
    }

    static public func deleteAllKeys () {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            if key != "devicetoken"{
                defaults.removeObject(forKey: key)
            }
        }
        defaults.synchronize()
    }

    static public func keyExist(_ key: String) -> Bool {
        if standard.object(forKey: key) != nil {
            return true
        }
        return false
    }
}
