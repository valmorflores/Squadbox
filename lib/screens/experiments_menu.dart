import 'package:SquadBox/experiments/bouncing_ball.dart';
import 'package:flutter/material.dart';

import '../experiments/composability.dart';
import '../experiments/noise_effect.dart';
import '../experiments/particles_effects.dart';
import '../experiments/raycast_light_effect.dart';
import '../experiments/size_effect.dart';

class ExperimentsMenu extends StatefulWidget {
  const ExperimentsMenu({Key key}) : super(key: key);

  @override
  State<ExperimentsMenu> createState() => _ExperimentsMenuState();
}

class _ExperimentsMenuState extends State<ExperimentsMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Experimentos')),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text(
                'Bouncing Ball',
                style: TextStyle(fontSize: 28),
              ),
              subtitle: Text(
                '04/05/2023 - Rotina de teste de bolinha com teste de colisão lateral',
                style: TextStyle(fontSize: 11),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return BouncingBallGame(); //MyGame()
                  }),
                );
              },
            ),
            ListTile(
              title: Text(
                'Noise Effect',
                style: TextStyle(fontSize: 28),
              ),
              subtitle: Text(
                '04/05/2023 - Rotina de teste de noise effect',
                style: TextStyle(fontSize: 11),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return NoiseEffectGame(); //MyGame()
                  }),
                );
              },
            ),
            ListTile(
              title: Text(
                'Composability',
                style: TextStyle(fontSize: 28),
              ),
              subtitle: Text(
                '04/05/2023 - Rotina de teste componente composto por varias partes. Um padrão a ser aplicado ao desenho dos personagens (face and eye)',
                style: TextStyle(fontSize: 11),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ComposabilityGame(); //MyGame()
                  }),
                );
              },
            ),
            ListTile(
              title: Text(
                'Size Effect',
                style: TextStyle(fontSize: 28),
              ),
              subtitle: Text(
                '04/05/2023 - Rotina de teste de efeito em resize',
                style: TextStyle(fontSize: 11),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SizeEffectGame(); //MyGame()
                  }),
                );
              },
            ),
            ListTile(
              title: Text(
                'Particles Effects',
                style: TextStyle(fontSize: 28),
              ),
              subtitle: Text(
                '04/05/2023 - Rotina de teste de particulas e efeitos',
                style: TextStyle(fontSize: 11),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ParticleEffectGame(); //MyGame()
                  }),
                );
              },
            ),
            ListTile(
              title: Text(
                'Raycast Light Effects',
                style: TextStyle(fontSize: 28),
              ),
              subtitle: Text(
                '04/05/2023 - Efeito de luz e sombra com detecção de raycast',
                style: TextStyle(fontSize: 11),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return RaycastLightEffectGame(); //MyGame()
                  }),
                );
              },
            ),
          ]),
        ));
  }
}
