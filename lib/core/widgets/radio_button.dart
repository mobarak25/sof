import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class RadioGroupB extends StatefulWidget {
  const RadioGroupB({
    super.key,
    required this.radioValues,
    this.grid = 1,
    required this.value,
    this.reset = false,
    this.defaultValue,
    this.color = bGray,
  });

  final List<RadioValue> radioValues;
  final int? grid;
  final Function value;
  final bool reset;
  final dynamic defaultValue;
  final Color color;

  @override
  State<RadioGroupB> createState() => _RadioBState();
}

class _RadioBState extends State<RadioGroupB> {
  dynamic _groupValue = 0;

  void setSelected(val) {
    setState(() {
      _groupValue = val;
      widget.value(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reset) {
      setState(() {
        _groupValue = 0;
      });
    }

    if (widget.defaultValue != null) {
      setState(() {
        _groupValue = widget.defaultValue!;
      });
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        children: List.generate(
          widget.radioValues.length,
          (index) => FractionallySizedBox(
            widthFactor: 1 / widget.grid!,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: Radio(
                      activeColor: bGreen,
                      value: widget.radioValues[index].value,
                      groupValue: _groupValue,
                      onChanged: (val) {
                        setSelected(val!);
                      },
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setSelected(widget.radioValues[index].value);
                      },
                      child: TextB(
                        text: widget.radioValues[index].name,
                        textStyle: bBody1,
                        fontColor:
                            widget.radioValues[index].value == _groupValue
                                ? bGray
                                : widget.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RadioValue {
  final String name;
  final dynamic value;
  RadioValue({required this.name, required this.value});
}
