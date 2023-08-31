class Enemigo extends Animacion
{
  PImage[] covImg;
  int dir, clase;
  Enemigo(PImage ene, int esUn)
  {
    super(ene);
    shift = new Transicion();
    tamanio.x = 43;
    tamanio.y = 37;
    tipo = 1;
    clase = esUn;
    dir = izquierda;
    cambio.x = -1;
    covImg = new LeerArchivo(4,2,"covid.png").getHoja();
    quieto = new PImage[1];
    quieto[0] =covImg[0];
    moverDer = new PImage[3];
    moverIzq = new PImage[4];
    moverDer[0] = covImg[4];
    moverDer[1] = covImg[5];
    moverDer[2] = covImg[6];
    moverIzq[0] = covImg[0];
    moverIzq[1] = covImg[1];
    moverIzq[2] = covImg[2];
    moverIzq[3] = covImg[3];
    actual = moverIzq;
  }
  @Override
  void mover()
  {
    actualizar();
    resolverColision(this,plataforma);
    if(tocado(player,this))
    {
      if(player.estado == 0 && num == 49)
      {
         shift.activar();
         player.center.x = 35;
         player.center.y =  100;
         view_x = 0;
         view_y = 0;
         player.vidas--;
      }
      else if(player.estado == 0 && num == 50)
      {
        shift.activar();
        player.center.x = 35;
        player.center.y =  100;
        view_x = 0;
        view_y = 0;
        player.vidas--;
      }
    }
    center.x += cambio.x;
    center.y += cambio.y;
  }
  void invertir()
  {
    if(dir == izquierda) 
    {
      dir = derecha;
      cambio.x = 1;
    }
    else if(dir == derecha) 
    {
      dir = izquierda;
      cambio.x = -1;
    }
  }
}
