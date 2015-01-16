class ArmorClass extends ItemClass{
  ArmorClass(String a){
    x = 0;
    y = 0;
    size = 20;
    name = a;
  }
  ArmorClass(){
    this("a peice of armor");
  }
  
  float Durability;
  float getDurability(){
    return x;
  }
  void setDurability(float a){
    Durability = a;
  }
}
