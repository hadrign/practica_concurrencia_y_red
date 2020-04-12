## Practica concurrencia y red

### Notas:

- En la parte del detalle de usuarios en mi usuario el campo can_edit_username me viene a false siempre con lo que suponemos que la aprte de comunicación con el servirdor de Discpurse para esa parte funciona correctamente.
- El resto de ejercicios están probados.
- Cuando se borra un topic se recarga la tabla de topics pero este no desaparece hasta que pasan 24 horas ya que Discourse lo marca así. También se recarga esta tabla cada vez que se regresa de una pestaña distinta hacia esta para ver si lastest topics se ha modificado
