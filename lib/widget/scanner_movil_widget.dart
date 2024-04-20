import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/app_colors.dart';

class ScannerMovilWidget extends StatelessWidget {
  const ScannerMovilWidget({super.key, required this.codigoBarrController});

  final TextEditingController codigoBarrController;

  @override
  Widget build(BuildContext context) {
    //return BlocBuilder<MasterizadoScannerBloc, MasterizadoScannerState>(
        //builder: (context, state) {
          //if (state.honeywell == false) {
            return Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.primaryBlue),
                  ),
                  onPressed: () async {
                    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                        "#ff6666", "cancelar", false, ScanMode.QR);
                    codigoBarrController.text = barcodeScanRes;
                  },
                  child: const Text("Escanear",style: TextStyle(color: Colors.white))),
            );
          //}
          return Container();//
        //});//
  }
}
