Nivel nivel;
PImage[] personaje;
Player player;
Transicion shift;

ArrayList<Sprite> plataforma,enemigo;
final static int normal = 0;
final static int derecha = 1;
final static int izquierda = 2;
final static float salto = 12;
final static float gravedad = 0.6;
final static float vel = 5;
final static float size_sprite = 32;
final static float der_margen = 400;
final static float izq_margen = 32;
final static float vert_margen = 40;
float view_x = 0;
float view_y = 0;
Informacion info;
int estado_juego=0;
int posicionX_cursor=250; int posicionY_cursor=216;
PImage cursor;
void setup(){
   size(800,511);
   cursor=loadImage("cursor.png");
   imageMode(CENTER);
   nivel = new Nivel();
   personaje = new LeerArchivo(5,4,"ninho.png").getHoja();
   player = new Player(personaje[0]);
   player.center.x = 35;
   player.center.y = 100;
   info = new Informacion();
}

void draw(){
  if(estado_juego==0){
    clear();
    PImage cartel=loadImage("inicio.png");
    imageMode(CORNER);
    image(cartel,0,0);
    image(cursor,posicionX_cursor,posicionY_cursor);
    player.vidas=3;
  }
  else if(estado_juego==1){
    imageMode(CENTER);
    background(178,255,255);
    shift.mostrar();
  
    if(!shift.visible)
    {
      scroll();
      nivel.mostrar();
      player.mostrar();
      player.actualizar();
      resolverColision(player,plataforma);
      reset();
      info.mostrar();
      if(player.center.x > 4531)
      {
        estado_juego=3;
      } 
    }
  }
  
  else if(estado_juego==3){
        clear();
        PImage cartell=loadImage("ganaste.png");
        imageMode(CENTER);
        image(cartell,400,250);
  } 

  else{
    clear();
    PImage cartel=loadImage("cartel_final.png");
    imageMode(CENTER);
    image(cartel,400,250);
  }
}
void scroll()
{
  float der_dimension = view_x + width - der_margen;
  if(player.getRight() > der_dimension)
  {
    if(view_x < 3700) 
      view_x += player.getRight() - der_dimension;
    
  }
  float izq_dimension = view_x + izq_margen;
  if(player.getLeft() < izq_dimension)
  {
    if(view_x > 0)
    view_x -= izq_dimension - player.getLeft();
  }
  float piso_dimension = view_y + height - vert_margen+10;
  if(player.getBottom() > piso_dimension)
  {
    view_y += player.getBottom() - piso_dimension;
  }

  translate(-view_x,-view_y);
}
boolean tocado(Sprite s1, Sprite s2)
{
   boolean tocarX = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight(); 
   boolean tocarY = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
   if(tocarX || tocarY)
     return false;
   else
   {
     return true;
   }
}
void resolverColision(Sprite s, ArrayList<Sprite> lista)
{
  s.cambio.y += gravedad;
  s.center.y += s.cambio.y;
  ArrayList<Sprite> colLista = tocandoLista(s,lista);
  if(colLista.size() > 0)
  {
    Sprite colision = colLista.get(0);
    if(s.cambio.y > 0)
    {
      s.setBottom(colision.getTop());
    }
    else if(s.cambio.y < 0)
    {
      s.setTop(colision.getBottom());
    }
    s.cambio.y = 0;
  }
  s.center.x += s.cambio.x;
  colLista = tocandoLista(s,lista);
  if(colLista.size() > 0)
  {
    Sprite colision = colLista.get(0);
    if(s.cambio.x > 0)
    {
      s.setRight(colision.getLeft());
    }
    else if(s.cambio.x < 0)
    {
      s.setLeft(colision.getRight());
    }
    s.cambio.x = 0;

    if(s.tipo > 0)
      ((Enemigo)s).invertir();
  }
}
boolean estaEnPlataforma(Sprite s, ArrayList<Sprite> pared)
{
  s.center.y += 5;
  ArrayList<Sprite> col_lista = tocandoLista(s,pared);
  s.center.y -= 5;
  if(col_lista.size()>0)
    return true;
  else
    return false;
}

void mouseClicked(){
  if(estado_juego==0){
    if(posicionY_cursor<217) estado_juego=1;
    else if(217<posicionY_cursor && posicionY_cursor<332) estado_juego=0;
    else if(332<posicionY_cursor && posicionY_cursor<447) super.exit();
  }
  else if(estado_juego==1){
    estado_juego=2;
  }
  else{
    estado_juego=0;
  }
}
void keyPressed()
{
  if(estado_juego==0){
    if(keyCode == DOWN){
     posicionY_cursor+=115;
     if(posicionY_cursor>446){
        posicionY_cursor=446;
     }
     image(cursor,posicionX_cursor,posicionY_cursor);
    }
    else if(keyCode == UP){
      posicionY_cursor-=115;
      if(posicionY_cursor<216){
        posicionY_cursor=216;
      }
      image(cursor,posicionX_cursor,posicionY_cursor);
    }
  }
  
  
  else if(estado_juego==1){
    if(keyCode == RIGHT)
      player.cambio.x = vel;
    else if(keyCode == LEFT)
      player.cambio.x = -vel;
    else if(keyCode == UP && estaEnPlataforma(player,plataforma))
    {
      player.cambio.y = -salto;
    }  
  }
  
    
}
void keyReleased()
{
  if(keyCode == RIGHT)
    player.cambio.x = 0;
  else if(keyCode == LEFT)
    player.cambio.x = 0;
  else if(keyCode == UP)
    player.cambio.y = 0;
}
void reset()
{
  if(player.center.y>height)
  {
    shift.activar();
    player.center.x = 75;
    player.center.y =  100;
    view_x = 0;
    view_y = 0;
    player.vidas--;
  }
  if(player.vidas<1){
    shift.activar();
    estado_juego=2;
  }
}
