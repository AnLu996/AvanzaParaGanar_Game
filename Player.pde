class Player extends Animacion
{
  int vidas, estado,timer;
  boolean enPlataforma, enPiso;
  PImage[] irDer, irIzq, saltoDer, saltoIzq;
  ArrayList<Sprite> sombra;
  Player(PImage imagen)
  {
    super(imagen);
    sombra = new ArrayList<Sprite>();
    vidas = 3;
    dir = derecha;
    estado = 0;
    enPlataforma = false;
    enPiso = false;
    irDer=new PImage[1];
    irIzq=new PImage[1];
    moverDer=new PImage[6];
    moverIzq=new PImage[6];
    saltoDer=new PImage[3];
    saltoIzq=new PImage[3];    
    cargaEstado();
    actual = saltoDer;
  }
  void cargaEstado()
  {
    timer = 0;
    saltoDer[0]=personaje[8];
    saltoDer[1]=personaje[9];
    saltoDer[2]=personaje[10];
    saltoIzq[0]=personaje[17];
    saltoIzq[1]=personaje[18];
    saltoIzq[2]=personaje[19];
    irIzq[0]=personaje[11];
    irDer[0]=personaje[2];
    moverDer[0]=personaje[2];
    moverDer[1]=personaje[3];
    moverDer[2]=personaje[4];
    moverDer[3]=personaje[5];
    moverDer[4]=personaje[6];
    moverDer[5]=personaje[7];
    moverIzq[0]=personaje[11];
    moverIzq[1]=personaje[12];
    moverIzq[2]=personaje[13];
    moverIzq[3]=personaje[14];
    moverIzq[4]=personaje[15];
    moverIzq[5]=personaje[16];
  }

  @Override
  void actualizar()
  {
    enPlataforma = estaEnPlataforma(this,plataforma);
    enPiso = cambio.x == 0 && cambio.y == 0;
    super.actualizar();
    println("x:"+center.x+"  y:"+center.y);
  }
  @Override
  void seleccionarDireccion()
  {
    if(cambio.x > 0)
      dir = derecha;
    else if(cambio.x < 0)
      dir = izquierda;
  }
  @Override
  void seleccionarImagenActual()
  {
    if(dir == derecha)
    {
      if(enPiso)
        actual = irDer;
      else if(!enPlataforma)
        actual = saltoDer;
      else
        actual = moverDer;
    }
    else if(dir == izquierda)
    {
      if(enPiso)
        actual = irIzq;
      else if(!enPlataforma)
        actual = saltoIzq;
      else
        actual = moverIzq;
    }
  }
}
