//
//  UserModel.swift
//  Assignment
//
//  Created by Keval Thumar on 25/02/25.
//

import Foundation


// MARK: - UserData
struct UserModel: Codable {
    var heightCM: Int?
    var email: String?
    var gdprAcceptedDateTime: String?
    var userLevel, firstName: String?
    var isReceiveNewsLetters: Bool?
    var receiveNewsLettersGlobalTime: String?
    var gender: Int?
    var initials: String?
    var isDoubleOptInNewsletter, heightInch, heightFeet: Int?
    var dob: String?
    var isGDPRAccepted: Int?
    var culture, lastName, gdprAcceptedPlatform, emailSalt: String?
    var userID1: Int?
    var encryptedPassword, salt: String?
    var isEmailVerified: Bool?
    var createdDate, globalTime: String?
    var isRegistrationCompleted: Bool?
    var failedPasswordAttemptCount: Int?
    var isLockedOut: Bool?
    var lastLockoutDate: String?
    var lastPasswordChangedDate: String?
    var doubleOptInDateTime, updatedDate: String?
    var isValidUser, sendMaxFailedPasswordAttemptEmail, isOldUser, isEmailAddressExists: Bool?
    var userAccessToken: String?
    var settings: Settings?
    var aspnetUserID, source: String?
    var userID: Int?
    var userStatusCode: String?
    var activitySensorSettings: ActivitySensorSettings?
    var deviceClassDurationSetting: [DeviceClassDurationSetting]?
    var glucoseSettings: GlucoseSettings?
    var deviceClassConfiguration: DeviceClassConfiguration?
    var temperatureSettings: TemperatureSettings?
    var waterSettings: WaterSettings?
    var newsletterStatus: Int?
    var allRoles: [String]?
    var role, finalIdentifier, deviceID: String?

    enum CodingKeys: String, CodingKey {
        case heightCM = "HeightCm"
        case email = "Email"
        case gdprAcceptedDateTime = "GDPRAcceptedDateTime"
        case userLevel = "UserLevel"
        case firstName = "FirstName"
        case isReceiveNewsLetters = "IsReceiveNewsLetters"
        case receiveNewsLettersGlobalTime = "ReceiveNewsLettersGlobalTime"
        case gender = "Gender"
        case initials = "Initials"
        case isDoubleOptInNewsletter
        case heightInch = "HeightInch"
        case heightFeet = "HeightFeet"
        case dob = "DOB"
        case isGDPRAccepted = "IsGDPRAccepted"
        case culture
        case lastName = "LastName"
        case gdprAcceptedPlatform = "GDPRAcceptedPlatform"
        case emailSalt = "EmailSalt"
        case userID1 = "UserID1"
        case encryptedPassword = "EncryptedPassword"
        case salt
        case isEmailVerified = "IsEmailVerified"
        case createdDate = "CreatedDate"
        case globalTime = "GlobalTime"
        case isRegistrationCompleted = "IsRegistrationCompleted"
        case failedPasswordAttemptCount = "FailedPasswordAttemptCount"
        case isLockedOut = "IsLockedOut"
        case lastLockoutDate = "LastLockoutDate"
        case lastPasswordChangedDate = "LastPasswordChangedDate"
        case doubleOptInDateTime = "DoubleOptInDateTime"
        case updatedDate = "UpdatedDate"
        case isValidUser = "IsValidUser"
        case sendMaxFailedPasswordAttemptEmail
        case isOldUser = "IsOldUser"
        case isEmailAddressExists = "IsEmailAddressExists"
        case userAccessToken = "UserAccessToken"
        case settings = "Settings"
        case aspnetUserID = "AspnetUserId"
        case source = "Source"
        case userID = "UserId"
        case userStatusCode
        case activitySensorSettings = "ActivitySensorSettings"
        case deviceClassDurationSetting = "DeviceClassDurationSetting"
        case glucoseSettings = "GlucoseSettings"
        case deviceClassConfiguration = "DeviceClassConfiguration"
        case temperatureSettings = "TemperatureSettings"
        case waterSettings = "WaterSettings"
        case newsletterStatus = "NewsletterStatus"
        case allRoles = "AllRoles"
        case role = "Role"
        case finalIdentifier = "FinalIdentifier"
        case deviceID = "DeviceId"
    }
}

// MARK: - ActivitySensorSettings
struct ActivitySensorSettings: Codable {
    var weightKg, strideWalkFt, strideWalkInch, strideWalkCM: Int?
    var strideRunFt, strideRunInch, strideRunCM, goalSteps: Int?
    var goalUnit, goalSleep: Int?
    var alarmStatus: Bool?
    var alarmHour, alarmMinute: Int?
    var over100PctGoal: Bool?
    var calorieBurnedPerStep, calorieGoal: Int?
    var weightPound: Double?
    var bmr: Int?
    var createdDate: String?
    var isDeleted: Bool?
    var globalTime: String?
    var keyIdentifier, source: String?

    enum CodingKeys: String, CodingKey {
        case weightKg = "WeightKg"
        case strideWalkFt = "StrideWalkFt"
        case strideWalkInch = "StrideWalkInch"
        case strideWalkCM = "StrideWalkCM"
        case strideRunFt = "StrideRunFt"
        case strideRunInch = "StrideRunInch"
        case strideRunCM = "StrideRunCM"
        case goalSteps = "GoalSteps"
        case goalUnit = "GoalUnit"
        case goalSleep = "GoalSleep"
        case alarmStatus = "AlarmStatus"
        case alarmHour = "AlarmHour"
        case alarmMinute = "AlarmMinute"
        case over100PctGoal = "Over100PctGoal"
        case calorieBurnedPerStep = "CalorieBurnedPerStep"
        case calorieGoal = "CalorieGoal"
        case weightPound = "WeightPound"
        case bmr = "BMR"
        case createdDate = "CreatedDate"
        case isDeleted = "IsDeleted"
        case globalTime = "GlobalTime"
        case keyIdentifier = "KeyIdentifier"
        case source = "Source"
    }
}

// MARK: - DeviceClassConfiguration
struct DeviceClassConfiguration: Codable {
    var createdDate, globalTime: String?
    var counter, isDeleted: Int?
    var deviceClassJSON, source: String?

    enum CodingKeys: String, CodingKey {
        case createdDate = "CreatedDate"
        case globalTime = "GlobalTime"
        case counter = "Counter"
        case isDeleted = "IsDeleted"
        case deviceClassJSON = "DeviceClassJSON"
        case source = "Source"
    }
}

// MARK: - DeviceClassDurationSetting
struct DeviceClassDurationSetting: Codable {
    var deviceClassID: Int?
    var duration, startTime, endTime: String?
    var deviceClassDurationSettingID, counter: Int?
    var createdDate: String?
    var isDeleted: Bool?
    var globalTime: String?
    var userID3, recordIdentifier, source, keyIdentifier: String?
    var userID: Int?
    var startTimeHour, startTimeMinute, startTimeSecond, endTimeHour: String?
    var endTimeMinute, endTimeSecond: String?

    enum CodingKeys: String, CodingKey {
        case deviceClassID = "DeviceClassId"
        case duration = "Duration"
        case startTime = "StartTime"
        case endTime = "EndTime"
        case deviceClassDurationSettingID = "DeviceClassDurationSettingID"
        case counter = "Counter"
        case createdDate = "CreatedDate"
        case isDeleted = "IsDeleted"
        case globalTime = "GlobalTime"
        case userID3 = "UserID3"
        case recordIdentifier = "RecordIdentifier"
        case source = "Source"
        case keyIdentifier = "KeyIdentifier"
        case userID = "UserId"
        case startTimeHour = "StartTimeHour"
        case startTimeMinute = "StartTimeMinute"
        case startTimeSecond = "StartTimeSecond"
        case endTimeHour = "EndTimeHour"
        case endTimeMinute = "EndTimeMinute"
        case endTimeSecond = "EndTimeSecond"
    }
}

// MARK: - GlucoseSettings
struct GlucoseSettings: Codable {
    var displayUnit: String?
    var targetStartValueMgdl, targetEndValueMgdl, targetStartValueMmol: Int?
    var targetEndValueMmol: Double?
    var createdDate: String?
    var isDeleted: Bool?
    var globalTime: String?
    var recordIdentifier, keyIdentifier, source: String?

    enum CodingKeys: String, CodingKey {
        case displayUnit = "DisplayUnit"
        case targetStartValueMgdl = "TargetStartValue_mgdl"
        case targetEndValueMgdl = "TargetEndValue_mgdl"
        case targetStartValueMmol = "TargetStartValue_mmol"
        case targetEndValueMmol = "TargetEndValue_mmol"
        case createdDate = "CreatedDate"
        case isDeleted = "IsDeleted"
        case globalTime = "GlobalTime"
        case recordIdentifier = "RecordIdentifier"
        case keyIdentifier = "KeyIdentifier"
        case source = "Source"
    }
}

// MARK: - Settings
struct Settings: Codable {
    var dateFormat, timeFormat, metricFormat, language: String?
    var userID3, recordIdentifier: String?
    var globalTime, updatedDate: String?
    var isDeleted, updateCheck: Bool?
    var firstDayOfWeek, counter: Int?
    var source: String?

    enum CodingKeys: String, CodingKey {
        case dateFormat = "DateFormat"
        case timeFormat = "TimeFormat"
        case metricFormat = "MetricFormat"
        case language = "Language"
        case userID3 = "UserID3"
        case recordIdentifier = "RecordIdentifier"
        case globalTime = "GlobalTime"
        case updatedDate = "UpdatedDate"
        case isDeleted = "IsDeleted"
        case updateCheck = "UpdateCheck"
        case firstDayOfWeek = "FirstDayOfWeek"
        case counter = "Counter"
        case source = "Source"
    }
}

// MARK: - TemperatureSettings
struct TemperatureSettings: Codable {
    var createdDate, globalTime: String?
    var isDeleted: Bool?
    var recordIdentifier, source: String?
    var counter, temperatureUnit: Int?

    enum CodingKeys: String, CodingKey {
        case createdDate = "CreatedDate"
        case globalTime = "GlobalTime"
        case isDeleted = "IsDeleted"
        case recordIdentifier = "RecordIdentifier"
        case source = "Source"
        case counter = "Counter"
        case temperatureUnit = "TemperatureUnit"
    }
}

// MARK: - WaterSettings
struct WaterSettings: Codable {
    var createdDate, globalTime: String?
    var isDeleted: Int?
    var userID3, recordIdentifier, source: String?
    var counter, waterUnit: Int?
    var keyIdentifier: String?

    enum CodingKeys: String, CodingKey {
        case createdDate = "CreatedDate"
        case globalTime = "GlobalTime"
        case isDeleted = "IsDeleted"
        case userID3 = "UserID3"
        case recordIdentifier = "RecordIdentifier"
        case source = "Source"
        case counter = "Counter"
        case waterUnit = "WaterUnit"
        case keyIdentifier = "KeyIdentifier"
    }
}



