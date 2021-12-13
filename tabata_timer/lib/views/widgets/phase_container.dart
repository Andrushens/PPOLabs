import 'package:flutter/material.dart';

class PhaseContainer extends StatelessWidget {
  const PhaseContainer({
    required this.title,
    required this.icon,
    this.onAddPressed,
    this.onSubPressed,
    this.onTextChanged,
    this.amount,
    Key? key,
  }) : super(key: key);

  final String title;
  final int? amount;
  final IconData icon;
  final VoidCallback? onAddPressed;
  final VoidCallback? onSubPressed;
  final Function(String)? onTextChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Icon(
            icon,
            size: 50,
          ),
          const SizedBox(width: 50),
          Expanded(
            child: Column(
              children: [
                if (amount != null) ...{
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                } else ...{
                  TextFormField(
                    onChanged: onTextChanged,
                    initialValue: title,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Pudge',
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    textAlign: TextAlign.center,
                    maxLength: 14,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                },
                if (amount != null) ...{
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: onSubPressed,
                        icon: const Icon(
                          Icons.remove,
                          size: 40,
                        ),
                      ),
                      Text(
                        '${amount!}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      IconButton(
                        onPressed: onAddPressed,
                        icon: const Icon(
                          Icons.add,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                },
              ],
            ),
          ),
        ],
      ),
    );
  }
}
