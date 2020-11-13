import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tenant_manager/models/tenant_model.dart';

class Tenant_detail extends StatefulWidget {
  Tenant tenant_instance;
  Tenant_detail(this.tenant_instance);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return tenant_detail_state(tenant_instance);
  }
}

class tenant_detail_state extends State<Tenant_detail> {
  Tenant tenant_instance;
  tenant_detail_state(this.tenant_instance);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Text(tenant_instance.name),
                  Text(tenant_instance.balance.toString()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
