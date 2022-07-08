import 'package:core/domain.dart';

import '../errors/failure.dart';

typedef Result<E> = Either<Failure, E>;
