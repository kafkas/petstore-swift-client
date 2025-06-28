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

- `useAsyncAwait` (bool): Whether to use async/await in the generated. Compatible with Swift 5.5+
- `protocolConformanceForStructs`: {
  Hashable: (bool) defaults to true,
  Sendable: (bool) defaults to true
  }
- `protocolConformanceForEnums`: {
  Hashable: (bool) defaults to true,
  Sendable: (bool) defaults to true,
  CaseIterable: (bool)
  }
- `fieldNamingStrategy` ("camelcase", "snakecase", "nochange")
- `labelPathParameters` (bool) defaults to true
- `labelQueryParameters` (bool): defaults to true
- `labelRequestBodyParameters` (bool): defaults to false

## TODOS

- Make `Sources/PetstoreSDK/Core` static across all SDKs.
  - Don't reference `PetstoreError` in `HTTPClient`
- Specify default values in model schemas?
- Specify user agent in transport layer
- Figure out how to infer whether an `enum` should conform to String. How do we handle "mixed" enums.
- Plan how to convert simple (undiscriminated) unions.
- Field mapping strategy. Must convert kebab-case to camelcase automatically. But how do we handle edge cases like `big-apple` and `bigApple` being in the same object definition?
