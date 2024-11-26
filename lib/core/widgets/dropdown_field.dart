import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';

class DropdownFieldB extends StatefulWidget {
  const DropdownFieldB(
      {super.key,
      this.dropdownHeight = 40,
      this.icon = Icons.keyboard_arrow_down,
      required this.items,
      required this.selected,
      this.setState = false,
      this.errorText = '',
      this.borderColor = bGray12,
      this.bgColor = bWhite,
      this.label = '',
      this.labelColor = bGray,
      this.isMandatory = false,
      this.dropDownValue,
      this.hint = 'Select'});

  final double? dropdownHeight;
  final IconData? icon;
  final List<DropdownItem> items;
  final Function selected;
  final bool setState;
  final String errorText;
  final Color borderColor, bgColor, labelColor;
  final String label;
  final bool isMandatory;
  final dynamic dropDownValue;
  final String hint;

  @override
  State<DropdownFieldB> createState() => _DropdownFieldBState();
}

class _DropdownFieldBState extends State<DropdownFieldB> {
  dynamic dropDownValue;

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.setState) {
        dropDownValue = null;
      } else if (widget.dropDownValue != null) {
        dropDownValue = widget.dropDownValue!;
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != '')
          Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextB(
                      maxLines: 1,
                      text: widget.label,
                      textStyle: bBody1,
                      fontColor: widget.labelColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  if (widget.isMandatory)
                    const TextB(
                      text: '*',
                      textStyle: bBody1,
                      fontColor: bRed,
                    ),
                ],
              ),
              const SizedBox(height: 5)
            ],
          ),
        Container(
          height: widget.dropdownHeight!,
          padding: const EdgeInsets.only(
            left: 15,
            right: 5,
          ),
          decoration: BoxDecoration(
            color: widget.bgColor,
            border: Border.all(color: widget.borderColor),
            borderRadius: BorderRadius.circular(7),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              alignment: Alignment.centerRight,
              isExpanded: true,
              focusColor: bRed,
              hint: Container(
                alignment: Alignment.centerLeft,
                child: TextB(text: widget.hint),
              ),
              icon: Icon(widget.icon, color: bGray),
              value: dropDownValue,
              items: widget.items.map((DropdownItem items) {
                return DropdownMenuItem(
                  value: items.value,
                  child: TextB(
                    text: items.name,
                    textStyle: bBody2,
                    fontColor: items.value == -1 ? bGray52 : bGray100,
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  widget.selected(val);
                  dropDownValue = val;
                });
              },
            ),
          ),
        ),
        if (widget.errorText != "")
          TextB(
            text: widget.errorText,
            fontSize: 12,
            fontColor: bRed,
          )
      ],
    );
  }
}
