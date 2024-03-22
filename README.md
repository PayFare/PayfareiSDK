# PayfareiSDK, 0.2.1
 This package provide:
    * Activation phisycal card.
    * View Virtual card.
    * Change PIN card.
    
        case CARD_ACTIVATION_ERROR(Int, String)
      case VIRTUAL_CARD_ERROR(Int, String)
      case CARD_PIN_ERROR(Int, String)
      case NO_CARD_TING
      case CARD_ALREADY_ACTIVE
      case UNAUTHORIZED(Int, String)
      case VC_OTP_NOT_VALIDATED
      case VC_I2C_TOKEN_EXPIRED
      case VC_OTP_ENTER_TIME_EXPIRE
