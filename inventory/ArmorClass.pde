class ArmorClass extends ItemClass{
  float Durability;
  ArmorClass(){
    super();
    Durability = 20;
  }
  float getDurability(){
    return x;
  }
  void setDurability(float a){
    Durability = a;
  }
}
