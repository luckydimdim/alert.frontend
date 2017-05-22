import 'dart:core';
import 'dart:html' as h;

import 'package:angular2/platform/browser.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';

import 'package:http/http.dart';
import 'package:http/browser_client.dart';

import 'package:aside/aside_service.dart';
import 'package:auth/auth_service.dart';
import 'package:config/config_service.dart';
import 'package:master_layout/master_layout_component.dart';

import 'package:alert/alert_component.dart';
import 'package:alert/alert_service.dart';

bool get isDebug =>
    (const String.fromEnvironment('PRODUCTION', defaultValue: 'false')) !=
    'true';

@Component(
    selector: 'app',
    template: '<master-layout><alert></alert></master-layout>',
    directives: const [MasterLayoutComponent, AlertComponent])
class AppComponent {}

main() async {
  ComponentRef ref = await bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    const Provider(AlertService),
    const Provider(AsideService),
    const Provider(ConfigService),
    const Provider(AuthenticationService),
    const Provider(AuthorizationService),
    const Provider(MasterLayoutComponent),
    provide(Client, useFactory: () => new BrowserClient(), deps: [])
  ]);

  var alertService = ref.injector.get(AlertService);

  h.querySelector('#show-danger')
    ..onClick.listen((_) => alertService.Danger('danger text'));

  h.querySelector('#show-success')
    ..onClick.listen((_) => alertService.Success('success text'));

  h.querySelector('#show-info')
    ..onClick.listen((_) => alertService.Info('info text'));

  h.querySelector('#show-warning')
    ..onClick.listen((_) => alertService.Warning('warning text'));

  if (isDebug) {
    print('Application in DebugMode');
    enableDebugTools(ref);
  }
}