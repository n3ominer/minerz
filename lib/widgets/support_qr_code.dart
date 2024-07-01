import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minerz/models/referal/referal_const.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SUpportQrCodeWidget extends StatelessWidget {
  const SUpportQrCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
      widthFactor: 1,
      child: SafeArea(
        bottom: true,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 158, 158, 158),
              width: 0.7,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  )
                ],
              ),
              const Text(
                "Support the project",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'PatuaOne',
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              QrImageView(
                data: lnurlWallet,
                version: QrVersions.auto,
                size: 250,
                backgroundColor: Colors.transparent,
                gapless: false,
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.circle,
                  color: Colors.orange,
                ),
                eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.circle, color: Colors.grey),
                embeddedImageStyle: const QrEmbeddedImageStyle(
                  size: Size(80, 80),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: lnurlWallet));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.copy_rounded,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "${lnurlWallet.substring(0, 15)}....${lnurlWallet.substring(lnurlWallet.length - 15, lnurlWallet.length)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'PatuaOne',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
