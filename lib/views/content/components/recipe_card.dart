import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_icons.dart';
import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/models/user.dart';
import 'package:fastrecipes/providers/api_%20fastrecipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecipeCard extends StatelessWidget {
  final ApiManager _apiManager = ApiManager();
  final Recipe recipe;
  final bool selected;
  final Function onSelected;
  final bool isFavorite;
  final IUser userLoggedIn;
  final Function updateUser;

  RecipeCard(
      {Key key,
      @required this.recipe,
      @required this.selected,
      @required this.onSelected,
      @required this.userLoggedIn,
      this.isFavorite,
      @required this.updateUser})
      : super(key: key);

  Future<void> _toggleFavorite() async {
    await _apiManager.toggleRecipeLove(userLoggedIn.key, recipe.key);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: selected
                ? Border.all(width: 1.5, color: AppColors.borderColor)
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/images/FoodAvatar.svg'),
            SizedBox(
              width: 23,
            ),
            Container(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(recipe.name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF333333))),
                      Text(recipe.creatorName,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6B6B6B))),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Text(
                            '${recipe.preparationTime} min - ${recipe.dificultyLevel}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B6B6B))),
                        SizedBox(width: 8),
                        SvgPicture.asset(
                          recipe.dificultyLevel == 'Fácil'
                              ? 'assets/images/easy_dark.svg'
                              : recipe.dificultyLevel == 'Médio'
                                  ? 'assets/images/medium_dark.svg'
                                  : recipe.dificultyLevel == 'Difícil'
                                      ? 'assets/images/hard_dark.svg'
                                      : 'assets/images/noLevel_dark.svg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FavoriteButton(
              active: userLoggedIn.favoriteRecipesKeys.contains(recipe.key),
              onTap: _toggleFavorite,
              updateUser: updateUser,
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  final bool active;
  final Function onTap;
  final Function updateUser;

  FavoriteButton(
      {Key key,
      @required this.active,
      @required this.onTap,
      @required this.updateUser})
      : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool active;

  @override
  void initState() {
    active = widget.active;
    super.initState();
  }

  _toggleActivity() async {
    setState(() {
      active = !active;
    });
    await widget.onTap();
    await widget.updateUser();
    //Tratar caso não dê certo
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: widget.key,
      onTap: _toggleActivity,
      child: AppIcon(
        active ? AppIcons.heartFilled : AppIcons.heartStroked,
        size: Size.square(40),
      ),
    );
  }
}
