import Foundation

struct MyEncodable: Codable {
    let name: String
    let age: Int
}

func main() {
    // Encoding
    let originalObject = LoginRequest(deviceType: 2,
                                      deviceID: "233",
                                      appVersion: 4,
                                      deviceName: "ggg",
                                      osVersion: "17.3",
                                      deviceToken: "hjkjk",
                                      firebaseIDToken: "@",
                                      loginType: .phone,
                                      timezone: "ioiuoioiouioiuiioiuoi")
    let encoder = JSONEncoder()
    do {
        let encodedData = try encoder.encode(originalObject)
        let encodedDataHexString = dataToHexString(data: encodedData)
        print("Encoded Data (as Hex): \(encodedDataHexString)")

        // Decoding
        if let decodedData = dataFromHexString(encodedDataHexString) {
            let decoder = JSONDecoder()
            do {
                let decodedObject = try decoder.decode(LoginRequest.self, from: decodedData)
                print("Decoded Data: \(decodedObject)")
            } catch {
                print("Decoding error: \(error)")
            }
        } else {
            print("Invalid hex data.")
        }
    } catch {
        print("Encoding error: \(error)")
    }
}

func dataToHexString(data: Data) -> String {
    return data.map { String(format: "%02X", $0) }.joined()
}

func dataFromHexString(_ hexString: String) -> Data? {
    var hex = hexString
    var data = Data()
    while hex.count > 0 {
        let substring = String(hex.prefix(2))
        hex = String(hex.dropFirst(2))
        if var num = UInt8(substring, radix: 16) {
            data.append(&num, count: 1)
        } else {
            return nil
        }
    }
    return data
}

main()

public struct LoginRequest: Codable {
    public let deviceType: Int
    public let deviceID: String
    public let appVersion: Int
    public let deviceName: String
    public let osVersion: String
    public let deviceToken: String
    public let firebaseIDToken: String?
    public let phone: String?
    public let providerFirebaseIDToken: String?
    public let loginType: LoginType
    public let firstName: String?
    public let lastName: String?
    public let ip: String?
    public let resolution: String?
    public let platform: Int?
    public let timezone: String

    public init(deviceType: Int, deviceID: String, appVersion: Int, deviceName: String, osVersion: String, deviceToken: String, firebaseIDToken: String? = nil, phone: String? = nil, providerFirebaseIDToken: String? = nil, loginType: LoginType, firstName: String? = nil, lastName: String? = nil, ip: String? = nil, resolution: String? = nil, platform: Int? = nil, timezone: String) {
        self.deviceType = deviceType
        self.deviceID = deviceID
        self.appVersion = appVersion
        self.deviceName = deviceName
        self.osVersion = osVersion
        self.deviceToken = deviceToken
        self.firebaseIDToken = firebaseIDToken
        self.phone = phone
        self.providerFirebaseIDToken = providerFirebaseIDToken
        self.loginType = loginType
        self.firstName = firstName
        self.lastName = lastName
        self.ip = ip
        self.resolution = resolution
        self.platform = platform
        self.timezone = timezone
    }

    enum CodingKeys: String, CodingKey {
        case deviceType = "device_type"
        case deviceID = "device_id"
        case appVersion = "app_version"
        case deviceName = "device_name"
        case osVersion = "os_version"
        case deviceToken = "device_token"
        case firebaseIDToken = "firebase_id_token"
        case phone
        case providerFirebaseIDToken = "provider_firebase_id_token"
        case loginType = "login_type"
        case firstName = "first_name"
        case lastName = "last_name"
        case ip
        case resolution
        case platform
        case timezone
    }
}

public enum LoginType: Int, Codable {
    case anonymous = 0
    case phone = 1
    case google = 2
    case facebook = 3
    case apple = 4
}
