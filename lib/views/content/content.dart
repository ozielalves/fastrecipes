import 'package:fastrecipes/core/theme/app_colors.dart';
import 'package:fastrecipes/core/theme/app_icons.dart';
import 'package:fastrecipes/models/recipe.dart';
import 'package:fastrecipes/views/content/components/search_content_component.dart';
import 'package:fastrecipes/views/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fastrecipes/providers/api_%20fastrecipe.dart';
import 'package:flutter/services.dart';
import '../recipe_register.dart';
import 'components/bottom_navigator_component.dart';
import 'components/home_content_component.dart';

class Recipes extends StatefulWidget {
  final String userKey;

  Recipes({this.userKey});

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> with SingleTickerProviderStateMixin {
  ApiManager apiManager = ApiManager();
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<Recipe> recipes = [];
  List<Recipe> filteredRecipes = [];
  Recipe selectedRecipe;
  bool isRecipesRequestLoading = false;
  User user;
  bool isLoggedIn = false;
  int _currentTabIndex = 0;
  int _currentContentViewIndex = 0;

  // Controllers
  TextEditingController searchController = TextEditingController();
  TabController tabController;

  @override
  void initState() {
    updateList();
    _getUser();
    _checkAuth();
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    /* checkAuth(context: context, auth: _auth, route: HomePage()); */
  }

  void _checkAuth() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LandingPage()));
      }
    });
  }

  void _getUser() async {
    User firebaseUser = _auth.currentUser;
    print(firebaseUser);
    await firebaseUser.reload();
    firebaseUser = _auth.currentUser;

    print(firebaseUser);

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isLoggedIn = true;
      });
    }
  }

  void _setRecipesRequestLoading(bool value) {
    setState(() {
      isRecipesRequestLoading = value;
    });
  }

  Future<void> updateList() async {
    _setRecipesRequestLoading(true);
    await apiManager.getRecipes().then((list) {
      setState(() {
        recipes = list;
        filteredRecipes = list;
      });
    });
    _setRecipesRequestLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_currentContentViewIndex == 0)
                  HomeContentComponent(
                    isLoggedIn: isLoggedIn,
                    isRecipesRequestLoading: isRecipesRequestLoading,
                    recipes: recipes,
                    selectedRecipe: selectedRecipe,
                  ),
                if (_currentContentViewIndex == 1)
                  SearchContentComponent(
                      recipes: recipes,
                      isRecipesRequestLoading: isRecipesRequestLoading),
                BottomNavigatorComponent(
                  onTap: (index) {
                    setState(() {
                      _currentTabIndex = index;
                    });
                  },
                  currentIndex: _currentTabIndex,
                  items: [
                    BottomNavigatorItemComponent(
                      label: "Início",
                      activeIcon: AppIcons.homeFilled,
                      icon: AppIcons.homeStroked,
                      goTo: () {
                        setState(() {
                          _currentContentViewIndex = 0;
                        });
                      },
                    ),
                    BottomNavigatorItemComponent(
                        label: "Buscar",
                        activeIcon: AppIcons.searchFilled,
                        icon: AppIcons.searchStroked,
                        goTo: () {
                          setState(() {
                            _currentContentViewIndex = 1;
                          });
                        }),
                    BottomNavigatorItemComponent(
                        label: "Nova",
                        activeIcon: AppIcons.addFilled,
                        icon: AppIcons.addStroked,
                        isActive: false,
                        goTo: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RecipeRegister(
                                      userKey: this.widget.userKey,
                                    )))),
                    BottomNavigatorItemComponent(
                      label: "Perfil",
                      activeIcon: AppIcons.personFilled,
                      icon: AppIcons.personStroked,
                    ),
                  ],
                )
              ],
            )));
  }
}
