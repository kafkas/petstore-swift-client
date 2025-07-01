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

- **`clientClassName`** (string, default: inferred from the spec):  
  The name of the main client struct/class that serves as the entry point to the SDK and contains all resource clients (e.g., `PetClient`, `StoreClient`, `UserClient`).

- **`skipResponseValidation`** (_boolean_, default: `true`)
  Effectively disables decoding errors. Needs investigation.

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
