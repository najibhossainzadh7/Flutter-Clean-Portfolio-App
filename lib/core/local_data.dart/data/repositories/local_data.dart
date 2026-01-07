import 'dart:typed_data';
import 'package:hive/hive.dart';

class AvatarRepository {

  Future<Box> get _box async {
    if (Hive.isBoxOpen('avatarBox')) {
      return Hive.box('avatarBox');
    } else {
      return await Hive.openBox('avatarBox');
    }
  }

  Future<void> saveAvatar(Uint8List bytes) async {
    final box = await _box;
    await box.put('avatar', bytes);
  }

  Future<Uint8List?> loadAvatar() async {
    final box = await _box;
    return box.get('avatar');
  }
}
