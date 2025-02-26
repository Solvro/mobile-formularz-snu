import "package:flutter/material.dart";
import "package:sleep_app/extensions/context_extensions.dart";

class WrongEmailDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: context.theme.colorScheme.error,
          width: 2,
        ),
      ),
      title: const Text("Niepoprawny adres email"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Niestety, nie mamy takiego adresu email w naszej bazie badanych. Spróbuj ponownie, lub napisz do nas.",
          ),
          Icon(
            Icons.close,
            color: context.theme.colorScheme.error,
            size: 150,
          ),
        ],
      ),
      actions: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }

  static Future<void> showWrongEmailDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WrongEmailDialog();
      },
    );
  }
}
