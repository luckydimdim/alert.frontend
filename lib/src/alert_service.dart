import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

class AlertModel {
  String text = '';
  String type = 'danger';

  AlertModel([this.text = '', this.type = 'danger']);
}

@Injectable()
class AlertService {
  final Router _router;
  StreamController<AlertModel> _controller = new StreamController<AlertModel>();

  AlertService(this._router) {
    _router.subscribe(onNext);
  }

  void Danger(String message) => _controller.add(new AlertModel(message));
  void Success(String message) => _controller.add(new AlertModel(message, 'success'));
  void Info(String message) => _controller.add(new AlertModel(message, 'info'));
  void Warning(String message) => _controller.add(new AlertModel(message, 'warning'));

  Stream<AlertModel> GetStream() => _controller.stream;

  void onNext(dynamic value) => _controller.add(new AlertModel());
}
