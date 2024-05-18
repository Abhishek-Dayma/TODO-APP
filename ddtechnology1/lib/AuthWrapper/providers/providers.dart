import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth_service.dart';

final authProvider1 = Provider<AuthService>((ref) => AuthService());
