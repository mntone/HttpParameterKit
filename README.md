# HttpParameterKit

HttpParameterKit is beta.

Accessories for [Apple's NSURLSession](https://developer.apple.com/documentation/foundation/nsurlsession).

## Quick start guide

### Define http parameters

```swift
@HttpParameterBuilder
func getParameterDefine(condition: Bool) -> [HttpParameter] {
    HPBool("boolean")
    HPInt("integer", defaultValue: 20, min: 1, max: 40)
    HPString("string")
    if condition {
        HPString("conditional_parameter")
    }
    HPPattern {
        HPSet {
            HPString("set1")
        } optionals: {
            HPString("string_if_needed")
        }
        HPSet {
            HPString("set2")
        } optionals: {
            HPInt("integer_if_needed")
        }
        HPSet {
            HPString("set3")
        } optionals: {
            HPBool("boolean_if_needed")
        }
    }
}
```

### Apply http parameters

```swift
func applyParameters(parameters: [String: AnyHashable]) throws -> String {
    let define = getParameterDefine(condition: false)
    do {
        let query = try define.query(parameters)
        return query
    } catch {
        print(error.localizedDescription)
        throw error
    }
}
```

HttpParameterKit supports other formats, like JSON, XML, and MessagePack.

### Set parameters to URLRequest directly

```swift
struct RequestSupport {
    private let define: [HttpParameter]
    
    init(define: [HttpParameter]) {
        self.define = define
    }
    
    func setParameters(to request: inout URLRequest, parameters: [String: AnyHashable]) throws {
        do {
            try request.setBodyAsQuery(parameters, define: define)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
```


## Requirements

HttpParameterKit requires Xcode 11+ and is has minimum deployment targets of macOS 10.9+, iOS 7.0+, tvOS 9.0+ or watchOS 2.0+.


## Installation

HttpParameterKit is delivered via a Swift Package and can be installed either as a dependency to another Swift Package by adding it to the dependencies section of a `Package.swift` file or to an Xcode 11+ project via the menu `File` → `Swift Packages` → `Add package dependency...` in Xcode 11+.


## Copyright and license

This project is released under the [MIT license](https://github.com/mntone/HttpParameterKit/blob/main/LICENSE.txt).
