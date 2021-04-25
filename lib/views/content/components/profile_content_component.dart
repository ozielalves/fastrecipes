import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_typhography.dart';
import 'package:fastrecipes/models/user.dart';
import 'package:fastrecipes/views/content/user_edit.dart';
import 'package:flutter/material.dart';

import 'profile_header_component.dart';

class ProfileContentComponent extends StatelessWidget {
  final IUser userLoggedIn;
  final Function updateUser;

  ProfileContentComponent(
      {Key key, @required this.userLoggedIn, @required this.updateUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileHeaderComponent(),
          ListItem(
            title: "Informações pessoais",
            subtitle: "Nome, sobrenome",
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserEdition(
                    userLoggedIn: userLoggedIn, updateUser: updateUser))),
          ),
          /* ListItem(
              title: "Credenciais",
              subtitle: "Meios de acesso a sua conta",
              onTap: () {}), */
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;

  const ListItem({Key key, this.title, this.subtitle, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: AppTyphography.bodyTextSemiBold(context),
          ),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(
            color: AppColors.grey,
          ),
        )
      ],
    );
  }
}
