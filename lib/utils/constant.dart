import 'package:intl/intl.dart';

const newsApiKey = '92dd73b8cc4849bc923a8c444c8eaece';

final format = DateFormat('MMMM dd, yyyy');

DateTime fromDate = DateTime.now().subtract(const Duration(days: 7));

DateTime toDate = DateTime.now();