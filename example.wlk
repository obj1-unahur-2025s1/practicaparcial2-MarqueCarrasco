class Personaje{
  var fuerza 
  var inteligencia
  var rol

  method fuerza()= fuerza
  method inteligencia()= inteligencia
  method rolPersonaje() = rol
  method tramiteRol(nuevo){
    rol = nuevo
  } 

  method potencialOfensivo(){
    return fuerza * 10 + rol.extra() 
  } 
  method esGroso()= self.esInteligente() or self.esGrosoEnRol() 

  method esInteligente()
  method esGrosoEnRol()= rol.exigencia(self)
}


class Orgo  inherits Personaje{
  override method potencialOfensivo(){
    var potencial= super()
    if (rol = mago){
      potencial = potencial + fuerza * 0.1
    }
    return potencial
  }
  
  override method esInteligente()= false 
 
} 

class Humano inherits Personaje{
  override method esInteligente()= inteligencia > 50
}

object mago{
  method extra()= 0
  method exigencia(unPersonaje)= true
}

object guerrero{

  method extra()= 100
  method exigencia(unPersonaje)= unPersonaje.fuerza() > 50 
}

object cazador{
  var tieneMascota= Mascota

  method cambiarMascota(unaMascota){
    tieneMascota = unaMascota
  }

  method extra()= tieneMascota.potencialOfensivo()
  method exigencia(unPersonaje)= Mascota.esLongeva() > 10
}

class Mascota{
  var property fuerza
  var property edad
  var property garras

  method esLongeva()= edad > 10

  method potencialEfensivo(){
    if (garras){
      fuerza * 2
    }
    else{
      fuerza 
    }
  }
}

class Aldea{
  var tamaño
  const habitantes= #{}
  
  method tamaño()= tamaño
  method cantHabitantesMaxima()= tamaño.cantHabitantes()
  method agregarPersonaje(unPersonaje){
    if (habitantes.size() < self.cantHabitantesMaxima()){
       habitantes.add(unPersonaje)
    }
    else{
      self.error("Cantidad de habitantes completado")
    }
     
  }
  method potencialOfensivoTotal()= habitantes.sum{h => h.potencialOfensivo()}
  method nosAtacan(unInvasor){
    if (self.potencialOfensivoTotal() < unInvasor.potencialOfensivoTotal() and self.cantHabitantesMaxima() < unInvasor.tamaño()){
      habitantes.removeAll()
      habitantes.addAll(unInvasor.diezMejores())
    }
    else-if (self.potencialOfensivoTotal() < unInvasor.potencialOfensivoTotal() ){
      habitantes.removeAll()
      habitantes.addAll(unInvasor.habitantes())
    }
    
  }
}

class Invacion{
  const habitantes= #{}
  method habitantes()= habitantes
  method tamaño()= habitantes.size()
  method potencialOfensivoTotal()= habitantes.sum{h => h.potencialOfensivo()}
  method diezMejores()= 0 
}

class Ciudad{
  const habitantes= #{}
  var potencialofensivo= self.potencialOfensivoTotal()
  method agregarPersonaje(unPersonaje){
    habitantes.add(unPersonaje)
  }

  method potencialOfensivoTotal()= habitantes.sum{h => h.potencialOfensivo()}
  method nosAtacan(unInvasor){
    if (self.potencialOfensivoTotal() < unInvasor.potencialOfensivoTotal() ){
      habitantes.removeAll()
      habitantes.addAll(unInvasor.diezMejores())
    }
  
    
  }
}

object aldeaChica{
  method cantHabitantes()= 1000
}
object aldeaMediana{
  method cantHabitantes()= 1500
}
object aldeaGrande{
  method cantHabitantes()= 2000
}