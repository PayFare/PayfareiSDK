# PayfareiSDK, 0.1.21(errorHandler)
 This package provide:
    * Activation phisycal card.
    * View Virtual card.
    * Change PIN card.
    
    public protocol SDKErrorType where Self: Swift.Error {
    var localizedDescription: String { get }
    var errorCode: Int { get }
}
