import 'package:flutter/material.dart';
import 'package:neurostore/utils/constants.dart';

class ProfileIconInAppBar extends StatefulWidget {
  const ProfileIconInAppBar({super.key});

  @override
  State<ProfileIconInAppBar> createState() => _ProfileIconInAppBarState();
}

class _ProfileIconInAppBarState extends State<ProfileIconInAppBar> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      position: PopupMenuPosition.under,
      color: lightGrey,
      elevation: 3,
      offset: Offset(0, 15),
      itemBuilder: (BuildContext context) => [
        _buildPopupMenuItem('Profile', 'profile', context),
        _buildPopupDivider(),
        _buildPopupMenuItem('Payment Method', 'pay', context),
        _buildPopupDivider(),
        _buildPopupMenuItem('Apps', 'app', context),
        _buildPopupDivider(),
        _buildPopupMenuItem('Log Out', 'log', context),
      ],
      onSelected: (String value) {
        if (value == "profile") {
        } else if (value == "pay") {
        } else if (value == "app") {
        } else if (value == "log") {}
      },
      onCanceled: () {
        FocusScope.of(context).unfocus();
      },
      surfaceTintColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade700),
        child: Icon(
          Icons.person,
          color: Colors.grey,
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
      String title, String value, BuildContext context) {
    return PopupMenuItem<String>(
      padding: EdgeInsets.only(left: 20, right: 60),
      value: value,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (value == "profile") SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (value == "log") SizedBox(height: 15),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupDivider() {
    return PopupMenuItem<String>(
      enabled: false,
      padding: EdgeInsets.all(0),
      value: null,
      child: Divider(color: Colors.white),
    );
  }
}
