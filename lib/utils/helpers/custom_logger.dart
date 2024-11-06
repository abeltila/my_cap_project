part of 'index.dart';

//This is a custom logger used to debug the app
//This logger can also be used when the app has
//issues when it's in profile mode. Helping us
//find and resolve the any bugs.
class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}
final logger = Logger(
  filter: MyFilter(),
  printer: PrettyPrinter(
    printEmojis: true,
    colors: true,
    printTime: false
  )
);


