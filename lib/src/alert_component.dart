import 'dart:async';

import 'package:angular2/core.dart';
import 'alert_service.dart';

@Component(
    selector: 'alert',
    templateUrl: 'alert_component.html',
    styleUrls: const <String>['alert_component.css'])
class AlertComponent implements OnInit, OnDestroy {
  StreamSubscription _alerServiceSubscription;
  final AlertService _alertService;
  String message = '';
  String type = 'danger';

  AlertComponent(this._alertService);

  @override
  void ngOnInit() {
    _alerServiceSubscription = _alertService.GetStream().listen(_setMessage);
  }

  void _setMessage(AlertModel alertModel) {
    this.message = alertModel.text;
    this.type = alertModel.type;
  }

  void close() {
    this.message = '';
    this.type = 'danger';
  }

  Map<String, bool> setClasses() {
    final classes = {
      'alert': true,
      'alert-dismissible': true,
      'alert-' + type: true
    };

    return classes;
  }

  @override
  ngOnDestroy() {
    if (_alerServiceSubscription != null) {
      _alerServiceSubscription.cancel();
      _alerServiceSubscription = null;
    }
  }
}