void appunti() 
{
  /** 
   * SOUND NULL SAFETY: 
   * Una variabile in dart NON può essere NULL. Da errore.
   * Per far sì che possa esserlo, aggiungere un '?'.
   * ex: int? variabile = null.
   */

  /** 
   * NULL AWARENESS OPERATOR: -> ?? <-
   * risultato = ((bweight ?? 0) * 65) / 100; 
   * SE risultato è un int? (nullable) non può essere moltiplicato per 0 
   * (o addizionato/sottratto...) bisogna evitare sia NULL e operazione con numero normale.
   * devo usare il null aw. op. e se NON è null il valore sara quello a sinistra(bweight), 
   * altrimenti se è NULL sara quello a destra, cioè zero. 
   * questo evita null * valore.
   */

  /** 
   * NON CI SONO ARRAYS, LISTE.
   */

  /** 
   * PUNTI
   * 1 punto (lista.add(x))
   * 2 punti (lista.add(x)..add(y)..add(z)) posso concatenare senza scrivere necessariamente tutto il nome della variabile.
   * 3 punti = spread operator e permettere di spreaddare o spargere una qualcosa usually lista dentro un altra per esempio:
   * lista = [1,2,3,4,5];
   * lista2 = [-3,-2,-1,0,  ...lista]
   * PER USARE SPREAD OPERATOR, QUELLO CHE VADO AD AGGIUNGERE DEV'ESSERE ITERABILE, 
   * CHE POSSO ACCEDERE CON INDICE!!(EX:LIST)
   */

  /** 
   * Nelle LISTE c'è la funzione .ForEach((element) {blocco di codice});
   * oppure  .ForEach((element) => funzione o 'expression'));
   * questa funzione imita un for in loop (o for each loop) metti nel elemento il singolo elemento della lista,
   * poi se vuoi eseguire un blocco di codice apri le graffe e scrivi, 
   * se vuoi una singola funzione tipo print(element), usa l'arrow, 
   * 'arrow functions expect a single expression, not a block.'
   * [Puoi comunque usare arrow sempre ma segna come inutilità].
   */

  /** 
   * SET
   * Set NON hanno valori UGUALI!! 
   * Non sono INDICIZZATI (puoi accederci con set.elementAt(index)) MA l'ordine non è garantito.
   * infatti l'ordine NON è STABILE, CAMBIA.
   * modi speciali di crearli: 
   * Set set2 = {1,2,3}; - cosi se voglio crearlo dinamico
   * var set2 = {}; -cosi NON SI PUò FARE. E' UNA MAPPA PER DART. allora... 
   * -> var set2 = <int>{};
   * var set2 = {1,2,'a'};
   */

  /** 
   * metodi speciali ig:
   * UNION:  
   * Set sett = {1,2,3,4}; 
   * Set sett2 = {4,5,6,7};
   * sett.union(sett2); Mi rida un set unendoli, ovviamente il 4 ci sarà 1 volta
   * INTERSECTION: 
   * sett.intersection(sett2); mi da un set con il 4. quindi valori in comune
   * DIFFERENCE: 
   * sett.difference(sett2); mi da un nuovo set col valore di sett, però senza i valori in comune
   * con sett2. quindi 1,2,3
   */

  /*
  OOP
  al posto di fare:

  class Esercizio 
  {
    String nome = "piegamenti";

    Esercizio(String nome){
      this.nome = nome;
    }
  }

  si puo minimizzare facendo

    Esercizio(this.nome);

  NON SERVE METTERE 'new'

  super = classe da cui eredito 
  class Ability
  {
    String name;
    int cooldown;
    int level = 1;
    
    void upgradeAbility() {level++; print("Upgraded ability $name, current level: $level current x: ");}

    Ability(this.name, this.cooldown);
    
  }

  class OffensiveAbility extends Ability
  {
    int damage;
    OffensiveAbility(String name, int cooldown, this.damage) : super(name,cooldown); metto nel super che è la classe madre il name e cooldown nuovo e li gestisce il costruttore madre

    @override
    void upgradeAbility() {level++; damage += 5; print("Upgraded ability $name, current level: $level | current damage: $damage");}
  }


  */

  


}
