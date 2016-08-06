struct ParrotZikEndpoints {

    static let NoiseCancellationStatus = "/api/audio/noise_cancellation/enabled/get"
    static let SetNoiseCancellationStatus = "/api/audio/noise_cancellation/enabled/set"
    static let ApplicationVersion = "/api/software/version/get"
    static let BatteryInfo = "/api/system/battery/get"
    static let FriendlyName = "/api/bluetooth/friendlyname/get"
    static let EqualizerStatus = "/api/audio/equalizer/enabled/get"
    static let SetEqualizerStatus = "/api/audio/equalizer/enabled/set"

    static let NoiseControltatus = "/api/audio/noise_control/enabled/get"
    static let SetNoiseControlStatus = "/api/audio/noise_control/enabled/set"
    static let NoiseControlLevelStatus = "/api/audio/noise_control/get"
    static let SetNoiseControlLevelStatus = "/api/audio/noise_control/set"

    static let ConcertHallStatus = "/api/audio/sound_effect/enabled/get"
    static let SetConcertHallStatus = "/api/audio/sound_effect/enabled/set"
    static let FlightModeStatus = "/api/flight_mode/get"
    static let FlightModeEnable = "/api/flight_mode/enable"
    static let FlightModeDisable = "/api/flight_mode/disable"
    static let HeadDetectionStatus = "/api/system/head_detection/enabled/get"
    static let SetHeadModeDetectionStatus = "/api/system/head_detection/enabled/set"

}

//
// '/api/account/username': ['get', 'set'],
// '/api/appli_version': ['set'],
// '/api/audio/counter': ['get'],
// '/api/audio/equalizer/enabled': ['get', 'set'],
// '/api/audio/equalizer/preset_id': ['set'],
// '/api/audio/equalizer/preset_value': ['set'],
// '/api/audio/noise_cancellation/enabled': ['get', 'set'],
// '/api/audio/noise_control/enabled': ['get', 'set'],
// '/api/audio/noise_control': ['get', 'set'],
// '/api/audio/noise_control/phone_mode': ['get', 'set'],
// '/api/audio/noise': ['get'],
// '/api/audio/param_equalizer/value': ['set'],
// '/api/audio/preset/bypass': ['get', 'set'],
// '/api/audio/preset/': ['clear_all'],
// '/api/audio/preset/counter': ['get'],
// '/api/audio/preset/current': ['get'],
// '/api/audio/preset': ['download', 'activate', 'save', 'remove', 'cancel_producer'],
// '/api/audio/preset/synchro': ['start', 'stop'],
// '/api/audio/smart_audio_tune': ['get', 'set'],
// '/api/audio/sound_effect/angle': ['get', 'set'],
// '/api/audio/sound_effect/enabled': ['get', 'set'],
// '/api/audio/sound_effect': ['get'],
// '/api/audio/sound_effect/room_size': ['get', 'set'],
// '/api/audio/source': ['get'],
// '/api/audio/specific_mode/enabled': ['get', 'set'],
// '/api/audio/thumb_equalizer/value': ['get', 'set'],
// '/api/audio/track/metadata': ['get', 'force'],
// '/api/bluetooth/friendlyname': ['get', 'set'],
// '/api/flight_mode': ['get', 'enable', 'disable'],
// '/api/software/download_check_state': ['get'],
// '/api/software/download_size': ['set'],
// '/api/software/tts': ['get', 'enable', 'disable'],
// '/api/software/version_checking': ['get'],
// '/api/software/version': ['get'],
// '/api/system/anc_phone_mode/enabled': ['get', 'set'],
// '/api/system/auto_connection/enabled': ['get', 'set'],
// '/api/system/auto_power_off': ['get', 'set'],
// '/api/system/auto_power_off/presets_list': ['get'],
// '/api/system/battery/forecast': ['get'],
// '/api/system/battery': ['get'],
// '/api/system/bt_address': ['get'],
// '/api/system': ['calibrate'],
// '/api/system/color': ['get'],
// '/api/system/device_type': ['get'],
// '/api/system/': ['factory_reset'],
// '/api/system/head_detection/enabled': ['get', 'set'],
// '/api/system/pi': ['get'],
