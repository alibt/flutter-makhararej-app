import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:makharej_app/features/profile/provider/user_provider.dart';

@GenerateNiceMocks([MockSpec<UserProvider>()])
class MockFirebase extends Mock implements Firebase {}
