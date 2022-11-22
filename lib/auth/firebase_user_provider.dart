import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ListhFirebaseUser {
  ListhFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

ListhFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ListhFirebaseUser> listhFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<ListhFirebaseUser>(
      (user) {
        currentUser = ListhFirebaseUser(user);
        return currentUser!;
      },
    );
