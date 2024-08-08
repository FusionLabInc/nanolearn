import 'package:flutter/material.dart';
import 'package:choice/choice.dart';
import 'package:frontend/utils/index.dart';

class CustomBridgecardMultipleChoice extends StatefulWidget {
  final List<String> choices;
  final void Function(List<String>)? onChanged;

  const CustomBridgecardMultipleChoice(
      {super.key, required this.choices, required this.onChanged});

  @override
  State<CustomBridgecardMultipleChoice> createState() =>
      _CustomBridgecardMultipleChoiceState();
}

class _CustomBridgecardMultipleChoiceState
    extends State<CustomBridgecardMultipleChoice> {
  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
    widget.onChanged!(value);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: InlineChoice<String>(
        multiple: true,
        clearable: true,
        value: multipleSelected,
        onChanged: setMultipleSelected,
        itemCount: widget.choices.length,
        itemBuilder: (selection, i) {
          return ChoiceChip(
            backgroundColor: AppConstants.appBlack,
            selectedColor: AppConstants.appBlack,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            selected: selection.selected(widget.choices[i]),
            onSelected: selection.onSelected(widget.choices[i]),
            label: Text(
              widget.choices[i],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppConstants.appPrimaryColor,
                    fontSize: 18,
                  ),
            ),
          );
        },
        listBuilder: ChoiceList.createWrapped(
          direction: Axis.horizontal,
          spacing: 10,
          runSpacing: 10,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
        ),
      ),
    );
  }
}
