import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/material.dart';

class SwitchSelectorWidget extends StatefulWidget {

  final Function onChanged;
  final String first;
  final String second;

  const SwitchSelectorWidget({
    super.key,
    required this.onChanged,
    required this.first,
    required this.second
  });

  @override
  State<StatefulWidget> createState() => _SwitchSelectorWidget();

}

class _SwitchSelectorWidget extends State<SwitchSelectorWidget> {

  bool _isFirst = true;

  final TextStyle defaultTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter'
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 164,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          setState(() {
            _isFirst = !_isFirst;
          });
          widget.onChanged.call(_isFirst);
        },
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 80,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: _isFirst ? AppColor.secondary : Colors.white,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text(
                  widget.first,
                  style: defaultTextStyle.apply(
                    color: _isFirst ? Colors.white : AppColor.secondary,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 80,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: _isFirst ? Colors.white : AppColor.secondary,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text(
                  widget.second,
                  style: defaultTextStyle.apply(
                    color: _isFirst ? AppColor.secondary : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}