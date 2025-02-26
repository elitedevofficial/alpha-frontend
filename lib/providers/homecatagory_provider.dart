import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/widgets/homewidget/homecatagory_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider with ChangeNotifier {
  final Map<String, Widget> _allCategories = {
    'Recent Listened': HomecatagoryWidget(
      homeCatagoriesTitle: 'Recent Listened',
      homeCatagoriesIcon: Broken.command_square,
      homeMusicTitle: 'kanmani poove',
      homeMusicArtist: 'Jakes Bejoy',
      homeMusicImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRg0Gkx_Rvk_PGSEuglAylqZSpG_8b_BaioQ&s',
homeMusicOnTap: () {
      },
    ),
    'New Releases': HomecatagoryWidget(
      homeCatagoriesTitle: 'New Releases',
      homeCatagoriesIcon: Broken.crown_1,
      homeMusicTitle: 'kanmani poove',
      homeMusicArtist: 'Jakes Bejoy',
      homeMusicImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRg0Gkx_Rvk_PGSEuglAylqZSpG_8b_BaioQ&s',
      homeMusicOnTap: () {},
    ),
    'Popular albums': HomecatagoryWidget(
      homeCatagoriesTitle: 'Popular albums',
      homeCatagoriesIcon: Broken.backward_item,
      homeMusicTitle: 'kanmani poove',
      homeMusicArtist: 'Jakes Bejoy',
      homeMusicImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRg0Gkx_Rvk_PGSEuglAylqZSpG_8b_BaioQ&s',
      homeMusicOnTap: () {},
    ),
    'Best Of Artist': HomecatagoryWidget(
      homeCatagoriesTitle: 'Best Of Artist',
      homeCatagoriesIcon: Broken.category_2,
      homeMusicTitle: 'kanmani poove',
      homeMusicArtist: 'Jakes Bejoy',
      homeMusicImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRg0Gkx_Rvk_PGSEuglAylqZSpG_8b_BaioQ&s',
      homeMusicOnTap: () {},
    ),
  };

  List<String> _topCategoryKeys = [];
  List<String> _bottomCategoryKeys = [];

  List<String> _tempTopCategoryKeys = [];
  List<String> _tempBottomCategoryKeys = [];

  List<Widget> get topCategories =>
      _topCategoryKeys.map((key) => _allCategories[key]!).toList();

  List<Widget> get bottomCategories =>
      _bottomCategoryKeys.map((key) => _allCategories[key]!).toList();

  List<String> get tempTopCategories => List.from(_tempTopCategoryKeys);
  List<String> get tempBottomCategories => List.from(_tempBottomCategoryKeys);

  CategoryProvider() {
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Load category keys from shared preferences
    List<String>? savedTop = prefs.getStringList('topCategories');
    List<String>? savedBottom = prefs.getStringList('bottomCategories');

    // Ensure they have valid keys
    _topCategoryKeys = savedTop != null && savedTop.isNotEmpty
        ? savedTop.where((key) => _allCategories.containsKey(key)).toList()
        : [
            'Recent Listened',
            'New Releases',
            'Popular albums',
            'Best Of Artist'
          ];

    _bottomCategoryKeys = savedBottom != null
        ? savedBottom.where((key) => _allCategories.containsKey(key)).toList()
        : [];

    // Copy to temporary lists for editing
    _tempTopCategoryKeys = List.from(_topCategoryKeys);
    _tempBottomCategoryKeys = List.from(_bottomCategoryKeys);

    notifyListeners();
  }

  void moveToBottom(String key) {
    if (_tempTopCategoryKeys.contains(key) && _tempTopCategoryKeys.length > 2) {
      _tempTopCategoryKeys.remove(key);
      _tempBottomCategoryKeys.add(key);
      notifyListeners();
    }
  }

  void moveToTop(String key) {
    if (_tempBottomCategoryKeys.contains(key)) {
      _tempBottomCategoryKeys.remove(key);
      _tempTopCategoryKeys.add(key);
      notifyListeners();
    }
  }

  void reorderTop(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = _tempTopCategoryKeys.removeAt(oldIndex);
    _tempTopCategoryKeys.insert(newIndex, item);
    notifyListeners();
  }

  Future<void> saveChanges() async {
    _topCategoryKeys = List.from(_tempTopCategoryKeys);
    _bottomCategoryKeys = List.from(_tempBottomCategoryKeys);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('topCategories', _topCategoryKeys);
    await prefs.setStringList('bottomCategories', _bottomCategoryKeys);

    notifyListeners();
  }
}
