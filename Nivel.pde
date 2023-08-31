class Nivel
{
  Fondo lv1;
  int mapa;
  Nivel()
  {
    mapa = 0;
    lv1 = new Fondo("map0.csv","Tileset32.png",32);
  }
  void mostrar()
  {
    lv1.mostrar();
  }
  void cambiarNivel()
  {
    plataforma.removeAll(plataforma);
    coin.removeAll(coin);
    decoracion.removeAll(decoracion);
    mar.removeAll(mar);
    enemigo.removeAll(enemigo);
    frenteAgua.removeAll(frenteAgua);
    mapa++;
    player.center.x = 75;
    view_x = 0;
    lv1 = new Fondo("map"+mapa+".csv","Tileset32.png",32);
  }
}
