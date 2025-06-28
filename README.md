# Petstore Swift Client

## Structure

- [`PetstoreApplication`](/Sources/PetstoreApplication): Example main program that consumes the Petstore SDK.
- [`PetstoreSDK`](/Sources/PetstoreSDK): The Fern-generated Petstore SDK.

## Instructions

From project root, run `swift run` to run the main program (`PetstoreApplication`)

## Remarks

Principle: _Treat whether an API parameter is in the body, query or path as an implementation detail._

Corollary 1: SDK interface doesn't reference terms like "query parameters" or "request body".

Corollary 2: We need to devise a parameter naming strategy that handles conflicts, edge cases like same names for path and query params.

- label path and query params, don't label request body param

## Planned Generator Config

- **`useAsyncAwait`** (boolean, default: `true`)  
  Whether to use async/await in the generated SDK. Requires Swift 5.5+. When disabled, falls back to completion handler-based APIs.

- **`fieldNamingStrategy`** (string, default: `"camelcase"`)  
  Controls how field names are transformed from the OpenAPI spec:

  - `"camelcase"`: Converts to camelCase (e.g., `user_name` → `userName`)
  - `"snakecase"`: Preserves snake_case naming
  - `"nochange"`: Uses field names exactly as defined in the spec

- **`protocolConformanceForStructs`** (object)  
  Controls which protocols generated structs should conform to:

  ```yaml
  protocolConformanceForStructs:
    Codable: true # required and cannot be changed
    Hashable: true # default: true
    Sendable: true # default: true
  ```

- **`protocolConformanceForEnums`** (object)  
  Controls which protocols generated enums should conform to:

  ```yaml
  protocolConformanceForEnums:
    Codable: true # required and cannot be changed
    Hashable: true # default: true
    Sendable: true # default: true
    CaseIterable: true # default: false
  ```

- **`labelPathParameters`** (boolean, default: `true`)  
  Whether to include argument labels for path parameters in method signatures.

  - `true`: `getPet(petId: 123)`
  - `false`: `getPet(123)`

- **`labelQueryParameters`** (boolean, default: `true`)  
  Whether to include argument labels for query parameters in method signatures.

  - `true`: `findPets(status: .available, tags: ["dog"])`
  - `false`: `findPets(.available, ["dog"])`

- **`labelRequestBodyParameters`** (boolean, default: `false`)  
  Whether to include argument labels for request body parameters in method signatures.
  - `true`: `createPet(pet: newPet)`
  - `false`: `createPet(newPet)`

## TODOS

- Make `Sources/PetstoreSDK/Core` static across all SDKs.
  - Don't reference `PetstoreError` in `HTTPClient`
- Specify default values in model schemas?
- Specify user agent in transport layer
- Figure out how to infer whether an `enum` should conform to String. How do we handle "mixed" enums.
- Plan how to convert simple (undiscriminated) unions.
- Field mapping strategy. Must convert kebab-case to camelcase automatically. But how do we handle edge cases like `big-apple` and `bigApple` being in the same object definition?
