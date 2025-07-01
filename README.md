# Petstore Swift Client

## Structure

- **[`PetstoreApplication`](/Sources/PetstoreApplication)**: Example main program that consumes the Petstore SDK
- **[`PetstoreSDK`](/Sources/PetstoreSDK)**: The Fern-generated Petstore SDK

## Instructions

From project root, run `swift run` to run the main program (`PetstoreApplication`)

## Design Principles

### Principle 1

_Treat whether an API parameter is in the body, query or path as an implementation detail._

**Corollary 1.1**: SDK interface doesn't reference terms like "query parameters" or "request body"

**Corollary 1.2**: We need to devise a parameter naming strategy that handles conflicts, edge cases like same names for path and query params

### Principle 2

_SDK interface should look good by default with minimal configuration._

**Corollary 2.1**: Sensible defaults should be chosen for all generator configuration options to produce clean, idiomatic Swift code

**Corollary 2.2**: Common use cases should work well without requiring custom configuration

### Principle 3

_SDK should gracefully handle server responses that don't match the OpenAPI spec._

**Corollary 3.1**: Decoding should not fail when server returns unexpected values; instead use fallback values or mark fields as unavailable.

**Corollary 3.2**: Runtime errors may still occur when application code accesses fields that weren't properly decoded, but this is preferable to immediate decode failures

## Planned Generator Config

- **`clientName`** (string, default: inferred from the spec):  
  The name of the main client struct/class that serves as the entry point to the SDK and contains all resource clients (e.g., `PetClient`, `StoreClient`, `UserClient`).

- **`useAsyncAwait`** (_boolean_, default: `true`)  
  Whether to use async/await in the generated SDK. Requires Swift 5.5+. When disabled, falls back to completion handler-based APIs. Can skip for v1.

- **`skipResponseValidation`** (_boolean_, default: `true`)
  Effectively disables decoding errors. Needs investigation.

- **`protocolConformanceForStructs`** (_object_)  
  Controls which protocols generated structs should conform to:

  ```yaml
  protocolConformanceForStructs:
    Codable: true # required and cannot be changed
    Hashable: true # default: true
    Sendable: true # default: true
  ```

- **`protocolConformanceForEnums`** (_object_)  
  Controls which protocols generated enums should conform to:

  ```yaml
  protocolConformanceForEnums:
    Codable: true # required and cannot be changed
    Hashable: true # default: true
    Sendable: true # default: true
    CaseIterable: true # default: false
  ```

- **`fieldNamingStrategy`** (_enum_, default: `"camel-case"`)  
  Controls how field names are transformed from the OpenAPI spec:

  - `"camel-case"`: Converts to camelCase  
    Example: `user_name` → `userName`
  - `"snake-case"`: Converts to snake_case  
    Example: `userName` → `user_name`
  - `"preserve"`: Uses field names as close to the original as possible while ensuring valid Swift identifiers  
    Example: `user-name` → `user_name`, `user_name` → `user_name`

- **`pathParameterLabelNamingStrategy`** (_enum_, default: `"camel-case"`)  
  Controls argument labels for path parameters in method signatures:

  - `"camel-case"`: Use camel-cased parameter names from the OpenAPI spec  
    Example: `"pet_id"` → `getPet(petId: 123)`
  - `"snake-case"`: Use snake-cased parameter names from the OpenAPI spec  
    Example: `"petId"` → `getPet(pet_id: 123)`
  - `"none"`: No argument labels  
    Example: `getPet(123)`

- **`queryParameterLabelNamingStrategy`** (_enum_, default: `"camel-case"`)  
  Controls argument labels for query parameters in method signatures:

  - `"camel-case"`: Use camel-cased parameter names from the OpenAPI spec  
    Example: `"pet_status"` → `findPets(petStatus: .available)`
  - `"snake-case"`: Use snake-cased parameter names from the OpenAPI spec  
    Example: `"petStatus"` → `findPets(pet_status: .available)`
  - `"none"`: No argument labels  
    Example: `findPets(.available, ["dog"])`

- **`requestBodyParameterLabel`** (_string_, default: `undefined`)  
  Controls argument labels for request body parameters in method signatures:
  - `undefined`: No argument labels  
    Example: `createPet(newPet)`
  - Custom string: Use the specified label for request body parameters  
    Example: `"body"` → `createPet(body: newPet)`

## Things to watch out for

- Ensure unique file names across the generated SDK to avoid conflicts
- Robust name conflict resolution algo handling:
  - edge cases like `big-apple` and `bigApple` in the same object definition
  - conflicts in function param labels
- Handle reserved keywords in generated struct fields and enum cases

## TODOs

- Make `Sources/PetstoreSDK/Core` static across all SDKs
  - Don't reference `PetstoreError` in `HTTPClient`
- Specify default values in model schemas?
- Path/query params encoding
- Specify user agent in transport layer
- Figure out how to infer whether an `enum` should conform to String or Int etc.
  - How do we handle "mixed" enums?
- Plan how to convert simple (undiscriminated) unions
