import 'package:flutter/material.dart';
import 'package:my_family_mobile_app/themes/theme.dart';

class CommonButton extends StatelessWidget {
  VoidCallback _callBack = () {};
  var title = "";
  var primary = Colors.black;

  CommonButton(this._callBack, this.title, [this.primary = Colors.black]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _callBack,
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(8),
           ),
            backgroundColor: AppColors.buttonColor,
            textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
            ),
            shadowColor: Theme.of(context).primaryColor.withOpacity(0.5),
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14)),
      ),
    );
  }
}
