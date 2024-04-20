import 'package:honeywell_scanner/honeywell_scanner.dart';

class ScannerManager {
  static final ScannerManager _instance = ScannerManager._internal();

  factory ScannerManager() {
    return _instance;
  }

  ScannerManager._internal();

  HoneywellScanner _honeywellScanner = HoneywellScanner();
  ScannedData? _scannedData;
  String? _errorMessage;
  bool _scannerEnabled = false;
  bool _scan1DFormats = true;
  bool _scan2DFormats = true;
  bool _isDeviceSupported = false;

  Future<void> init() async {
    await updateScanProperties();
    _isDeviceSupported = await _honeywellScanner.isSupported();
  }

  Future<void> updateScanProperties() async {
    List<CodeFormat> codeFormats = [];
    if (_scan1DFormats) codeFormats.addAll(CodeFormatUtils.ALL_1D_FORMATS);
    if (_scan2DFormats) codeFormats.addAll(CodeFormatUtils.ALL_2D_FORMATS);

    Map<String, dynamic> properties = {
      ...CodeFormatUtils.getAsPropertiesComplement(codeFormats),
      'DEC_CODABAR_START_STOP_TRANSMIT': true,
      'DEC_EAN13_CHECK_DIGIT_TRANSMIT': true,
    };
    await _honeywellScanner.setProperties(properties);
  }

  Future<bool> startScanner() async {
    if (await _honeywellScanner.startScanner()) {
      _scannerEnabled = true;
      return true;
    }
    return false;
  }

  Future<bool> stopScanner() async {
    if (await _honeywellScanner.stopScanner()) {
      _scannerEnabled = false;
      return true;
    }
    return false;
  }

  Future<void> startScanning() async {
    await _honeywellScanner.startScanning();
  }

  Future<void> stopScanning() async {
    await _honeywellScanner.stopScanning();
  }

  ScannedData? get scannedData => _scannedData;
  String? get errorMessage => _errorMessage;
  bool get scannerEnabled => _scannerEnabled;
  bool get scan1DFormats => _scan1DFormats;
  bool get scan2DFormats => _scan2DFormats;
  bool get isDeviceSupported => _isDeviceSupported;

  set scan1DFormats(bool value) {
    _scan1DFormats = value;
    updateScanProperties();
  }

  set scan2DFormats(bool value) {
    _scan2DFormats = value;
    updateScanProperties();
  }

  void setScannerCallback(ScannerCallback callback) {
    _honeywellScanner.scannerCallback = callback;
  }
}
