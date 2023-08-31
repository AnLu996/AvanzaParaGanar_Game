import ddf.minim.*;
Minim minim,minim2;
AudioPlayer[] jump,btc;

PImage[] collected;
ArrayList<Sprite> coin, mar, decoracion, frenteAgua;
ArrayList<Sprite> tocandoLista(Sprite s, ArrayList<Sprite> lista)
{
  ArrayList<Sprite> listaTocada = new ArrayList<Sprite>();
  for(Sprite p: lista)
  {
    if(tocado(s,p))
      listaTocada.add(p);
  }
  return listaTocada;
}
