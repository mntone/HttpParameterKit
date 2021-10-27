@testable import HttpParameterKit
import XCTest

final class XmlTests: XCTestCase {
	func testNil() throws {
		XCTAssertEqual(try HPNil("nil").xml(()), nil)
	}

	func testNilSuppress() throws {
		XCTAssertEqual(try HPNil("nil", suppressDefault: false).xml(()), "<nil></nil>")
	}

	func testBoolFalse() throws {
		XCTAssertEqual(try HPBool("boolean").xml(false), nil)
	}

	func testBoolFalseSuppress() throws {
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false).xml(false), "<boolean>false</boolean>")
	}

	func testBoolTrue() throws {
		XCTAssertEqual(try HPBool("boolean").xml(true), "<boolean>true</boolean>")
	}

	func testBoolTrueSuppress() throws {
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false).xml(true), "<boolean>true</boolean>")
	}

	func testInt() throws {
		XCTAssertEqual(try HPInt("int").xml(0), nil)
		XCTAssertEqual(try HPInt("int").xml(Int.min), "<int>\(Int.min)</int>")
		XCTAssertEqual(try HPInt("int").xml(Int.max), "<int>\(Int.max)</int>")
	}

	func testIntSuppress() throws {
		XCTAssertEqual(try HPInt("int", suppressDefault: false).xml(0), "<int>0</int>")
		XCTAssertEqual(try HPInt("int", suppressDefault: false).xml(Int.min), "<int>\(Int.min)</int>")
		XCTAssertEqual(try HPInt("int", suppressDefault: false).xml(Int.max), "<int>\(Int.max)</int>")
		XCTAssertThrowsError(try HPInt("int", min: Int.min + 1).xml(Int.min))
		XCTAssertThrowsError(try HPInt("int", max: Int.max - 1).xml(Int.max))
	}

	func testInt8() throws {
		XCTAssertEqual(try HPInt8("int8").xml(0), nil)
		XCTAssertEqual(try HPInt8("int8").xml(Int8.min), "<int8>\(Int8.min)</int8>")
		XCTAssertEqual(try HPInt8("int8").xml(Int8.max), "<int8>\(Int8.max)</int8>")
	}

	func testInt8Suppress() throws {
		XCTAssertEqual(try HPInt8("int8", suppressDefault: false).xml(0), "<int8>0</int8>")
		XCTAssertEqual(try HPInt8("int8", suppressDefault: false).xml(Int8.min), "<int8>\(Int8.min)</int8>")
		XCTAssertEqual(try HPInt8("int8", suppressDefault: false).xml(Int8.max), "<int8>\(Int8.max)</int8>")
		XCTAssertThrowsError(try HPInt8("int8", min: Int8.min + 1).xml(Int8.min))
		XCTAssertThrowsError(try HPInt8("int8", max: Int8.max - 1).xml(Int8.max))
	}

	func testInt16() throws {
		XCTAssertEqual(try HPInt16("int16").xml(0), nil)
		XCTAssertEqual(try HPInt16("int16").xml(Int16.min), "<int16>\(Int16.min)</int16>")
		XCTAssertEqual(try HPInt16("int16").xml(Int16.max), "<int16>\(Int16.max)</int16>")
	}

	func testInt16Suppress() throws {
		XCTAssertEqual(try HPInt16("int16", suppressDefault: false).xml(0), "<int16>0</int16>")
		XCTAssertEqual(try HPInt16("int16", suppressDefault: false).xml(Int16.min), "<int16>\(Int16.min)</int16>")
		XCTAssertEqual(try HPInt16("int16", suppressDefault: false).xml(Int16.max), "<int16>\(Int16.max)</int16>")
		XCTAssertThrowsError(try HPInt16("int16", min: Int16.min + 1).xml(Int16.min))
		XCTAssertThrowsError(try HPInt16("int16", max: Int16.max - 1).xml(Int16.max))
	}

	func testInt32() throws {
		XCTAssertEqual(try HPInt32("int32").xml(0), nil)
		XCTAssertEqual(try HPInt32("int32").xml(Int32.min), "<int32>\(Int32.min)</int32>")
		XCTAssertEqual(try HPInt32("int32").xml(Int32.max), "<int32>\(Int32.max)</int32>")
	}

	func testInt32Suppress() throws {
		XCTAssertEqual(try HPInt32("int32", suppressDefault: false).xml(0), "<int32>0</int32>")
		XCTAssertEqual(try HPInt32("int32", suppressDefault: false).xml(Int32.min), "<int32>\(Int32.min)</int32>")
		XCTAssertEqual(try HPInt32("int32", suppressDefault: false).xml(Int32.max), "<int32>\(Int32.max)</int32>")
		XCTAssertThrowsError(try HPInt32("int32", min: Int32.min + 1).xml(Int32.min))
		XCTAssertThrowsError(try HPInt32("int32", max: Int32.max - 1).xml(Int32.max))
	}

	func testInt64() throws {
		XCTAssertEqual(try HPInt64("int64").xml(0), nil)
		XCTAssertEqual(try HPInt64("int64").xml(Int64.min), "<int64>\(Int64.min)</int64>")
		XCTAssertEqual(try HPInt64("int64").xml(Int64.max), "<int64>\(Int64.max)</int64>")
	}

	func testInt64Suppress() throws {
		XCTAssertEqual(try HPInt64("int64", suppressDefault: false).xml(0), "<int64>0</int64>")
		XCTAssertEqual(try HPInt64("int64", suppressDefault: false).xml(Int64.min), "<int64>\(Int64.min)</int64>")
		XCTAssertEqual(try HPInt64("int64", suppressDefault: false).xml(Int64.max), "<int64>\(Int64.max)</int64>")
		XCTAssertThrowsError(try HPInt64("int64", min: Int64.min + 1).xml(Int64.min))
		XCTAssertThrowsError(try HPInt64("int64", max: Int64.max - 1).xml(Int64.max))
	}

	func testUInt() throws {
		XCTAssertEqual(try HPUInt("uint").xml(0), nil)
		XCTAssertEqual(try HPUInt("uint").xml(UInt.max), "<uint>\(UInt.max)</uint>")
	}

	func testUIntSuppress() throws {
		XCTAssertEqual(try HPUInt("uint", suppressDefault: false).xml(0), "<uint>0</uint>")
		XCTAssertEqual(try HPUInt("uint", suppressDefault: false).xml(UInt.max), "<uint>\(UInt.max)</uint>")
		XCTAssertThrowsError(try HPUInt("uint", min: UInt.min + 1).xml(UInt.min))
		XCTAssertThrowsError(try HPUInt("uint", max: UInt.max - 1).xml(UInt.max))
	}

	func testUInt8() throws {
		XCTAssertEqual(try HPUInt8("uint8").xml(0), nil)
		XCTAssertEqual(try HPUInt8("uint8").xml(UInt8.max), "<uint8>\(UInt8.max)</uint8>")
	}

	func testUInt8Suppress() throws {
		XCTAssertEqual(try HPUInt8("uint8", suppressDefault: false).xml(0), "<uint8>0</uint8>")
		XCTAssertEqual(try HPUInt8("uint8", suppressDefault: false).xml(UInt8.max), "<uint8>\(UInt8.max)</uint8>")
		XCTAssertThrowsError(try HPUInt8("uint8", min: UInt8.min + 1).xml(UInt8.min))
		XCTAssertThrowsError(try HPUInt8("uint8", max: UInt8.max - 1).xml(UInt8.max))
	}

	func testUInt16() throws {
		XCTAssertEqual(try HPUInt16("uint16").xml(0), nil)
		XCTAssertEqual(try HPUInt16("uint16").xml(UInt16.max), "<uint16>\(UInt16.max)</uint16>")
	}

	func testUInt16Suppress() throws {
		XCTAssertEqual(try HPUInt16("uint16", suppressDefault: false).xml(0), "<uint16>0</uint16>")
		XCTAssertEqual(try HPUInt16("uint16", suppressDefault: false).xml(UInt16.max), "<uint16>\(UInt16.max)</uint16>")
		XCTAssertThrowsError(try HPUInt16("uint16", min: UInt16.min + 1).xml(UInt16.min))
		XCTAssertThrowsError(try HPUInt16("uint16", max: UInt16.max - 1).xml(UInt16.max))
	}

	func testUInt32() throws {
		XCTAssertEqual(try HPUInt32("uint32").xml(0), nil)
		XCTAssertEqual(try HPUInt32("uint32").xml(UInt32.max), "<uint32>\(UInt32.max)</uint32>")
	}

	func testUInt32Suppress() throws {
		XCTAssertEqual(try HPUInt32("uint32", suppressDefault: false).xml(0), "<uint32>0</uint32>")
		XCTAssertEqual(try HPUInt32("uint32", suppressDefault: false).xml(UInt32.max), "<uint32>\(UInt32.max)</uint32>")
		XCTAssertThrowsError(try HPUInt32("uint32", min: UInt32.min + 1).xml(UInt32.min))
		XCTAssertThrowsError(try HPUInt32("uint32", max: UInt32.max - 1).xml(UInt32.max))
	}

	func testUInt64() throws {
		XCTAssertEqual(try HPUInt64("uint64").xml(0), nil)
		XCTAssertEqual(try HPUInt64("uint64").xml(UInt64.max), "<uint64>\(UInt64.max)</uint64>")
	}

	func testUInt64Suppress() throws {
		XCTAssertEqual(try HPUInt64("uint64", suppressDefault: false).xml(0), "<uint64>0</uint64>")
		XCTAssertEqual(try HPUInt64("uint64", suppressDefault: false).xml(UInt64.max), "<uint64>\(UInt64.max)</uint64>")
		XCTAssertThrowsError(try HPUInt64("uint64", min: UInt64.min + 1).xml(UInt64.min))
		XCTAssertThrowsError(try HPUInt64("uint64", max: UInt64.max - 1).xml(UInt64.max))
	}

#if swift(>=5.3) && (os(iOS) || os(watchOS) || os(tvOS))
	@available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
	func testFloat16() throws {
		XCTAssertEqual(try HPFloat16("float16").xml(0), nil)
		XCTAssertEqual(try HPFloat16("float16").xml(Float16.leastNormalMagnitude), "<float16>\(Float16.leastNormalMagnitude)</float16>")
		XCTAssertEqual(try HPFloat16("float16").xml(Float16.greatestFiniteMagnitude), "<float16>\(Float16.greatestFiniteMagnitude)</float16>")
	}

	@available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
	func testFloat16Suppress() throws {
		XCTAssertEqual(try HPFloat16("float16", suppressDefault: false).xml(0), "<float16>0.0</float16>")
		XCTAssertEqual(try HPFloat16("float16", suppressDefault: false).xml(Float16.leastNormalMagnitude), "<float16>\(Float16.leastNormalMagnitude)</float16>")
		XCTAssertEqual(try HPFloat16("float16", suppressDefault: false).xml(Float16.greatestFiniteMagnitude), "<float16>\(Float16.greatestFiniteMagnitude)</float16>")
		XCTAssertThrowsError(try HPFloat16("float16", min: 40).xml(20))
		XCTAssertThrowsError(try HPFloat16("float16", max: 40).xml(60))
	}
#endif

	func testFloat() throws {
		XCTAssertEqual(try HPFloat("float").xml(0), nil)
		XCTAssertEqual(try HPFloat("float").xml(Float.leastNormalMagnitude), "<float>\(Float.leastNormalMagnitude)</float>")
		XCTAssertEqual(try HPFloat("float").xml(Float.greatestFiniteMagnitude), "<float>\(Float.greatestFiniteMagnitude)</float>")
	}

	func testFloatSuppress() throws {
		XCTAssertEqual(try HPFloat("float", suppressDefault: false).xml(0), "<float>0.0</float>")
		XCTAssertEqual(try HPFloat("float", suppressDefault: false).xml(Float.leastNormalMagnitude), "<float>\(Float.leastNormalMagnitude)</float>")
		XCTAssertEqual(try HPFloat("float", suppressDefault: false).xml(Float.greatestFiniteMagnitude), "<float>\(Float.greatestFiniteMagnitude)</float>")
		XCTAssertThrowsError(try HPFloat("float", min: 40).xml(20))
		XCTAssertThrowsError(try HPFloat("float", max: 40).xml(60))
	}

	func testDouble() throws {
		XCTAssertEqual(try HPDouble("double").xml(0), nil)
		XCTAssertEqual(try HPDouble("double").xml(Double.leastNormalMagnitude), "<double>\(Double.leastNormalMagnitude)</double>")
		XCTAssertEqual(try HPDouble("double").xml(Double.greatestFiniteMagnitude), "<double>\(Double.greatestFiniteMagnitude)</double>")
	}

	func testDoubleSuppress() throws {
		XCTAssertEqual(try HPDouble("double", suppressDefault: false).xml(0), "<double>0.0</double>")
		XCTAssertEqual(try HPDouble("double", suppressDefault: false).xml(Double.leastNormalMagnitude), "<double>\(Double.leastNormalMagnitude)</double>")
		XCTAssertEqual(try HPDouble("double", suppressDefault: false).xml(Double.greatestFiniteMagnitude), "<double>\(Double.greatestFiniteMagnitude)</double>")
		XCTAssertThrowsError(try HPDouble("double", min: 40).xml(20))
		XCTAssertThrowsError(try HPDouble("double", max: 40).xml(60))
	}

#if swift(>=1.1) && os(macOS)
	@available(macOS 10.10, *)
	func testFloat80() throws {
		XCTAssertEqual(try HPFloat80("float80").xml(0), nil)
		XCTAssertEqual(try HPFloat80("float80").xml(Float80.leastNormalMagnitude), "<float80>\(Float80.leastNormalMagnitude)</float80>")
		XCTAssertEqual(try HPFloat80("float80").xml(Float80.greatestFiniteMagnitude), "<float80>\(Float80.greatestFiniteMagnitude)</float80>")
	}

	@available(macOS 10.10, *)
	func testFloat80Suppress() throws {
		XCTAssertEqual(try HPFloat80("float80", suppressDefault: false).xml(0), "<float80>0.0</float80>")
		XCTAssertEqual(try HPFloat80("float80", suppressDefault: false).xml(Float80.leastNormalMagnitude), "<float80>\(Float80.leastNormalMagnitude)</float80>")
		XCTAssertEqual(try HPFloat80("float80", suppressDefault: false).xml(Float80.greatestFiniteMagnitude), "<float80>\(Float80.greatestFiniteMagnitude)</float80>")
		XCTAssertThrowsError(try HPFloat80("float80", min: 40).xml(20))
		XCTAssertThrowsError(try HPFloat80("float80", max: 40).xml(60))
	}
#endif

	func testCGFloat() throws {
		XCTAssertEqual(try HPCGFloat("cgfloat").xml(0), nil)
		XCTAssertEqual(try HPCGFloat("cgfloat").xml(CGFloat.leastNormalMagnitude), "<cgfloat>\(CGFloat.leastNormalMagnitude)</cgfloat>")
		XCTAssertEqual(try HPCGFloat("cgfloat").xml(CGFloat.greatestFiniteMagnitude), "<cgfloat>\(CGFloat.greatestFiniteMagnitude)</cgfloat>")
	}

	func testCGFloatSuppress() throws {
		XCTAssertEqual(try HPCGFloat("cgfloat", suppressDefault: false).xml(0), "<cgfloat>0.0</cgfloat>")
		XCTAssertEqual(try HPCGFloat("cgfloat", suppressDefault: false).xml(CGFloat.leastNormalMagnitude), "<cgfloat>\(CGFloat.leastNormalMagnitude)</cgfloat>")
		XCTAssertEqual(try HPCGFloat("cgfloat", suppressDefault: false).xml(CGFloat.greatestFiniteMagnitude), "<cgfloat>\(CGFloat.greatestFiniteMagnitude)</cgfloat>")
		XCTAssertThrowsError(try HPCGFloat("cgfloat", min: 40).xml(20))
		XCTAssertThrowsError(try HPCGFloat("cgfloat", max: 40).xml(60))
	}
}
