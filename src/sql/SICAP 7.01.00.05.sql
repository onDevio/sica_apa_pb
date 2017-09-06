//SCP-2383
//se lanza esta sentencia para que el calculo de gastos trate las tarifas F como D, ya que la F deja de existir

update musaat_coef_c set tabla = 'D' where tabla = 'F';