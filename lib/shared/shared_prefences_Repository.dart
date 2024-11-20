import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  List<String> _items = [];

// Hinzufügen und Speichern von Eingaben
  @override
  Future<void> addItem(String item) async {
    _items.add(item);
    await _saveItem();
  }

// Löschen von Einträgen und Speichern
  @override
  Future<void> deleteItem(int index) async {
    _items.removeAt(index);
    await _saveItem();
  }

// Bearbeiten von Einträgen und Speichern
  @override
  Future<void> editItem(int index, String newItem) async {
    _items[index] = newItem;
    await _saveItem();
  }

// Anzeigen von Einträgen
  @override
  Future<List<String>> getItems() async {
    _items = await prefs.getStringList("tasks") ?? [];
    return _items;
  }

// Anzahl der Einträge unter Statistik wird Angezeigt
  @override
  Future<int> get itemCount async {
    await getItems();
    return _items.length;
  }

// Speichern von Einträgen
  Future<void> _saveItem() async {
    await prefs.setStringList("tasks", _items);
  }
}
