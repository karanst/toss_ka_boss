import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  var txt = '''
 orem ipsum dolor sit amet, consectetur adipiscing elit. Mauris quis libero sit amet magna sodales porta. Sed lacinia rhoncus velit ac bibendum. Maecenas eget rhoncus arcu. Pellentesque quis quam ipsum. Etiam dictum metus ac urna ullamcorper, sed porttitor magna ullamcorper. Curabitur a augue ac lorem gravida euismod nec eget justo. Pellentesque aliquet, lacus sed elementum ultricies, magna massa dapibus purus, a posuere arcu arcu non dui. Integer id nibh lobortis, tempus felis ut, elementum quam. Mauris sagittis nec nunc eget molestie. Phasellus tincidunt ante et mauris viverra laoreet. Morbi a venenatis ex. Quisque eu nunc tempus dui tempus porttitor. Mauris et nibh tincidunt lectus blandit suscipit in non lectus. Donec in pretium mi
 ''''''Suspendisse feugiat blandit justo, ultricies lobortis tortor. Etiam nec convallis lectus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Proin tortor risus, condimentum a risus eu, ultricies tincidunt dui. Donec eget porta quam, sed tincidunt risus. Proin ut tincidunt quam, ac convallis justo. Curabitur blandit eu nisl iaculis scelerisque. In hac habitasse platea dictumst. Vivamus eu mollis massa. Praesent non finibus massa, et imperdiet metus. Ut egestas risus libero, vitae rhoncus ante fermentum eget. Praesent pretium quam metus, congue blandit massa hendrerit et. Morbi sem tellus, laoreet vel pulvinar id, egestas eget justo. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean gravida elit et lectus malesuada, vitae egestas lorem euismod. Curabitur ornare vulputate pellentesque'''
      '''Phasellus sodales at sapien vitae consectetur. Curabitur a nisi pharetra, pretium purus sed, vehicula felis. Integer laoreet, nulla quis semper bibendum, justo libero feugiat odio, id cursus dui metus vel felis. Vestibulum sit amet lacinia eros, quis condimentum neque. Mauris consectetur enim id aliquam auctor. Morbi pretium erat vel libero hendrerit tempor. Aliquam faucibus velit non felis ornare, id egestas elit lacinia. Nullam dui sapien, aliquam vestibulum scelerisque ut, blandit a lacus. Mauris ultrices luctus tellus,  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Privacy Policy'),
        ),
        body:
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Container(
                child: Column(
                  children: [
                    Text(txt,textAlign: TextAlign.justify,)
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
