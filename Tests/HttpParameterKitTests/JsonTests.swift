@testable import HttpParameterKit
import XCTest

final class JsonTests: XCTestCase {
	func testNil() throws {
		XCTAssertEqual(try HPNil("nil").json(()), nil)
	}

	func testNilSuppress() throws {
		XCTAssertEqual(try HPNil("nil", suppressDefault: false).json(()), "\"nil\":null")
	}

	func testBoolFalse() throws {
		XCTAssertEqual(try HPBool("boolean").json(false), nil)
	}

	func testBoolFalseSuppress() throws {
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false).json(false), "\"boolean\":false")
	}

	func testBoolTrue() throws {
		XCTAssertEqual(try HPBool("boolean").json(true), "\"boolean\":true")
	}

	func testBoolTrueSuppress() throws {
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false).json(true), "\"boolean\":true")
	}

	func testInt() throws {
		XCTAssertEqual(try HPInt("int").json(0), nil)
		XCTAssertEqual(try HPInt("int").json(Int.min), "\"int\":\(Int.min)")
		XCTAssertEqual(try HPInt("int").json(Int.max), "\"int\":\(Int.max)")
	}

	func testIntSuppress() throws {
		XCTAssertEqual(try HPInt("int", suppressDefault: false).json(0), "\"int\":0")
		XCTAssertEqual(try HPInt("int", suppressDefault: false).json(Int.min), "\"int\":\(Int.min)")
		XCTAssertEqual(try HPInt("int", suppressDefault: false).json(Int.max), "\"int\":\(Int.max)")
		XCTAssertThrowsError(try HPInt("int", min: Int.min + 1).json(Int.min))
		XCTAssertThrowsError(try HPInt("int", max: Int.max - 1).json(Int.max))
	}

	func testInt8() throws {
		XCTAssertEqual(try HPInt8("int8").json(0), nil)
		XCTAssertEqual(try HPInt8("int8").json(Int8.min), "\"int8\":\(Int8.min)")
		XCTAssertEqual(try HPInt8("int8").json(Int8.max), "\"int8\":\(Int8.max)")
	}

	func testInt8Suppress() throws {
		XCTAssertEqual(try HPInt8("int8", suppressDefault: false).json(0), "\"int8\":0")
		XCTAssertEqual(try HPInt8("int8", suppressDefault: false).json(Int8.min), "\"int8\":\(Int8.min)")
		XCTAssertEqual(try HPInt8("int8", suppressDefault: false).json(Int8.max), "\"int8\":\(Int8.max)")
		XCTAssertThrowsError(try HPInt8("int8", min: Int8.min + 1).json(Int8.min))
		XCTAssertThrowsError(try HPInt8("int8", max: Int8.max - 1).json(Int8.max))
	}

	func testInt16() throws {
		XCTAssertEqual(try HPInt16("int16").json(0), nil)
		XCTAssertEqual(try HPInt16("int16").json(Int16.min), "\"int16\":\(Int16.min)")
		XCTAssertEqual(try HPInt16("int16").json(Int16.max), "\"int16\":\(Int16.max)")
	}

	func testInt16Suppress() throws {
		XCTAssertEqual(try HPInt16("int16", suppressDefault: false).json(0), "\"int16\":0")
		XCTAssertEqual(try HPInt16("int16", suppressDefault: false).json(Int16.min), "\"int16\":\(Int16.min)")
		XCTAssertEqual(try HPInt16("int16", suppressDefault: false).json(Int16.max), "\"int16\":\(Int16.max)")
		XCTAssertThrowsError(try HPInt16("int16", min: Int16.min + 1).json(Int16.min))
		XCTAssertThrowsError(try HPInt16("int16", max: Int16.max - 1).json(Int16.max))
	}

	func testInt32() throws {
		XCTAssertEqual(try HPInt32("int32").json(0), nil)
		XCTAssertEqual(try HPInt32("int32").json(Int32.min), "\"int32\":\(Int32.min)")
		XCTAssertEqual(try HPInt32("int32").json(Int32.max), "\"int32\":\(Int32.max)")
	}

	func testInt32Suppress() throws {
		XCTAssertEqual(try HPInt32("int32", suppressDefault: false).json(0)!, "\"int32\":0")
		XCTAssertEqual(try HPInt32("int32", suppressDefault: false).json(Int32.min), "\"int32\":\(Int32.min)")
		XCTAssertEqual(try HPInt32("int32", suppressDefault: false).json(Int32.max), "\"int32\":\(Int32.max)")
		XCTAssertThrowsError(try HPInt32("int32", min: Int32.min + 1).json(Int32.min))
		XCTAssertThrowsError(try HPInt32("int32", max: Int32.max - 1).json(Int32.max))
	}

	func testInt64() throws {
		XCTAssertEqual(try HPInt64("int64").json(0), nil)
		XCTAssertEqual(try HPInt64("int64").json(Int64.min), "\"int64\":\(Int64.min)")
		XCTAssertEqual(try HPInt64("int64").json(Int64.max), "\"int64\":\(Int64.max)")
	}

	func testInt64Suppress() throws {
		XCTAssertEqual(try HPInt64("int64", suppressDefault: false).json(0), "\"int64\":0")
		XCTAssertEqual(try HPInt64("int64", suppressDefault: false).json(Int64.min), "\"int64\":\(Int64.min)")
		XCTAssertEqual(try HPInt64("int64", suppressDefault: false).json(Int64.max), "\"int64\":\(Int64.max)")
		XCTAssertThrowsError(try HPInt64("int64", min: Int64.min + 1).json(Int64.min))
		XCTAssertThrowsError(try HPInt64("int64", max: Int64.max - 1).json(Int64.max))
	}

	func testUInt() throws {
		XCTAssertEqual(try HPUInt("uint").json(0), nil)
		XCTAssertEqual(try HPUInt("uint").json(UInt.max), "\"uint\":\(UInt.max)")
	}

	func testUIntSuppress() throws {
		XCTAssertEqual(try HPUInt("uint", suppressDefault: false).json(0), "\"uint\":0")
		XCTAssertEqual(try HPUInt("uint", suppressDefault: false).json(UInt.max), "\"uint\":\(UInt.max)")
		XCTAssertThrowsError(try HPUInt("uint", min: UInt.min + 1).json(UInt.min))
		XCTAssertThrowsError(try HPUInt("uint", max: UInt.max - 1).json(UInt.max))
	}

	func testUInt8() throws {
		XCTAssertEqual(try HPUInt8("uint8").json(0), nil)
		XCTAssertEqual(try HPUInt8("uint8").json(UInt8.max), "\"uint8\":\(UInt8.max)")
	}

	func testUInt8Suppress() throws {
		XCTAssertEqual(try HPUInt8("uint8", suppressDefault: false).json(0), "\"uint8\":0")
		XCTAssertEqual(try HPUInt8("uint8", suppressDefault: false).json(UInt8.max), "\"uint8\":\(UInt8.max)")
		XCTAssertThrowsError(try HPUInt8("uint8", min: UInt8.min + 1).json(UInt8.min))
		XCTAssertThrowsError(try HPUInt8("uint8", max: UInt8.max - 1).json(UInt8.max))
	}

	func testUInt16() throws {
		XCTAssertEqual(try HPUInt16("uint16").json(0), nil)
		XCTAssertEqual(try HPUInt16("uint16").json(UInt16.max), "\"uint16\":\(UInt16.max)")
	}

	func testUInt16Suppress() throws {
		XCTAssertEqual(try HPUInt16("uint16", suppressDefault: false).json(0), "\"uint16\":0")
		XCTAssertEqual(try HPUInt16("uint16", suppressDefault: false).json(UInt16.max), "\"uint16\":\(UInt16.max)")
		XCTAssertThrowsError(try HPUInt16("uint16", min: UInt16.min + 1).json(UInt16.min))
		XCTAssertThrowsError(try HPUInt16("uint16", max: UInt16.max - 1).json(UInt16.max))
	}

	func testUInt32() throws {
		XCTAssertEqual(try HPUInt32("uint32").json(0), nil)
		XCTAssertEqual(try HPUInt32("uint32").json(UInt32.max), "\"uint32\":\(UInt32.max)")
	}

	func testUInt32Suppress() throws {
		XCTAssertEqual(try HPUInt32("uint32", suppressDefault: false).json(0), "\"uint32\":0")
		XCTAssertEqual(try HPUInt32("uint32", suppressDefault: false).json(UInt32.max), "\"uint32\":\(UInt32.max)")
		XCTAssertThrowsError(try HPUInt32("uint32", min: UInt32.min + 1).json(UInt32.min))
		XCTAssertThrowsError(try HPUInt32("uint32", max: UInt32.max - 1).json(UInt32.max))
	}

	func testUInt64() throws {
		XCTAssertEqual(try HPUInt64("uint64").json(0), nil)
		XCTAssertEqual(try HPUInt64("uint64").json(UInt64.max), "\"uint64\":\(UInt64.max)")
	}

	func testUInt64Suppress() throws {
		XCTAssertEqual(try HPUInt64("uint64", suppressDefault: false).json(0), "\"uint64\":0")
		XCTAssertEqual(try HPUInt64("uint64", suppressDefault: false).json(UInt64.max), "\"uint64\":\(UInt64.max)")
		XCTAssertThrowsError(try HPUInt64("uint64", min: UInt64.min + 1).json(UInt64.min))
		XCTAssertThrowsError(try HPUInt64("uint64", max: UInt64.max - 1).json(UInt64.max))
	}

#if swift(>=5.3) && (os(iOS) || os(watchOS) || os(tvOS))
	@available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
	func testFloat16() throws {
		XCTAssertEqual(try HPFloat16("float16").json(0), nil)
		XCTAssertEqual(try HPFloat16("float16").json(Float16.leastNormalMagnitude), "\"float16\":\(Float16.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat16("float16").json(Float16.greatestFiniteMagnitude), "\"float16\":\(Float16.greatestFiniteMagnitude)")
	}

	@available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
	func testFloat16Suppress() throws {
		XCTAssertEqual(try HPFloat16("float16", suppressDefault: false).json(0), "\"float16\":0.0")
		XCTAssertEqual(try HPFloat16("float16", suppressDefault: false).json(Float16.leastNormalMagnitude), "\"float16\":\(Float16.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat16("float16", suppressDefault: false).json(Float16.greatestFiniteMagnitude), "\"float16\":\(Float16.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPFloat16("float16", min: 40).json(20))
		XCTAssertThrowsError(try HPFloat16("float16", max: 40).json(60))
	}
#endif

	func testFloat() throws {
		XCTAssertEqual(try HPFloat("float").json(0), nil)
		XCTAssertEqual(try HPFloat("float").json(Float.leastNormalMagnitude), "\"float\":\(Float.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat("float").json(Float.greatestFiniteMagnitude), "\"float\":\(Float.greatestFiniteMagnitude)")
	}

	func testFloatSuppress() throws {
		XCTAssertEqual(try HPFloat("float", suppressDefault: false).json(0), "\"float\":0.0")
		XCTAssertEqual(try HPFloat("float", suppressDefault: false).json(Float.leastNormalMagnitude), "\"float\":\(Float.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat("float", suppressDefault: false).json(Float.greatestFiniteMagnitude), "\"float\":\(Float.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPFloat("float", min: 40).json(20))
		XCTAssertThrowsError(try HPFloat("float", max: 40).json(60))
	}

	func testDouble() throws {
		XCTAssertEqual(try HPDouble("double").json(0), nil)
		XCTAssertEqual(try HPDouble("double").json(Double.leastNormalMagnitude), "\"double\":\(Double.leastNormalMagnitude)")
		XCTAssertEqual(try HPDouble("double").json(Double.greatestFiniteMagnitude), "\"double\":\(Double.greatestFiniteMagnitude)")
	}

	func testDoubleSuppress() throws {
		XCTAssertEqual(try HPDouble("double", suppressDefault: false).json(0), "\"double\":0.0")
		XCTAssertEqual(try HPDouble("double", suppressDefault: false).json(Double.leastNormalMagnitude), "\"double\":\(Double.leastNormalMagnitude)")
		XCTAssertEqual(try HPDouble("double", suppressDefault: false).json(Double.greatestFiniteMagnitude), "\"double\":\(Double.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPDouble("double", min: 40).json(20))
		XCTAssertThrowsError(try HPDouble("double", max: 40).json(60))
	}

#if swift(>=1.1) && os(macOS)
	@available(macOS 10.10, *)
	func testFloat80() throws {
		XCTAssertEqual(try HPFloat80("float80").json(0), nil)
		XCTAssertEqual(try HPFloat80("float80").json(Float80.leastNormalMagnitude), "\"float80\":\(Float80.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat80("float80").json(Float80.greatestFiniteMagnitude), "\"float80\":\(Float80.greatestFiniteMagnitude)")
	}

	@available(macOS 10.10, *)
	func testFloat80Suppress() throws {
		XCTAssertEqual(try HPFloat80("float80", suppressDefault: false).json(0), "\"float80\":0.0")
		XCTAssertEqual(try HPFloat80("float80", suppressDefault: false).json(Float80.leastNormalMagnitude), "\"float80\":\(Float80.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat80("float80", suppressDefault: false).json(Float80.greatestFiniteMagnitude), "\"float80\":\(Float80.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPFloat80("float80", min: 40).json(20))
		XCTAssertThrowsError(try HPFloat80("float80", max: 40).json(60))
	}
#endif

	func testCGFloat() throws {
		XCTAssertEqual(try HPCGFloat("cgfloat").json(0), nil)
		XCTAssertEqual(try HPCGFloat("cgfloat").json(CGFloat.leastNormalMagnitude), "\"cgfloat\":\(CGFloat.leastNormalMagnitude)")
		XCTAssertEqual(try HPCGFloat("cgfloat").json(CGFloat.greatestFiniteMagnitude), "\"cgfloat\":\(CGFloat.greatestFiniteMagnitude)")
	}

	func testCGFloatSuppress() throws {
		XCTAssertEqual(try HPCGFloat("cgfloat", suppressDefault: false).json(0), "\"cgfloat\":0.0")
		XCTAssertEqual(try HPCGFloat("cgfloat", suppressDefault: false).json(CGFloat.leastNormalMagnitude), "\"cgfloat\":\(CGFloat.leastNormalMagnitude)")
		XCTAssertEqual(try HPCGFloat("cgfloat", suppressDefault: false).json(CGFloat.greatestFiniteMagnitude), "\"cgfloat\":\(CGFloat.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPCGFloat("cgfloat", min: 40).json(20))
		XCTAssertThrowsError(try HPCGFloat("cgfloat", max: 40).json(60))
	}
}
