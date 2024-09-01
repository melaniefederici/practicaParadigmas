%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUNTO 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% juego(nombre, genero).
juego(counterStrike, accion()).
juego(callOfDuty, accion()).
% juego(nombre, genero(usuariosActivos)).
juego(calabozosYDragones, rol(100)).
juego(minecraft, rol(20)).
% juego(nombre, genero(nivel, dificultad)).
juego(tetris, puzzle(15, facil)).
juego(crucigrama, puzzle(30, medio)).

% precio(juego, precio)
precio(counterStrike, 2000).
precio(calabozosYDragones, 3500).
precio(tetris, 2100).

% descuento(juego, porcentaje).
descuento(counterStrike, 55).
descuento(tetris, 70).
descuento(crucigrama, 80).

% usuario(nombre, suJuego).
usuario(melanie, [calabozosYDragones, minecraft]).
usuario(candela, [counterStrike, minecraft, callOfDuty]).

% planeaAdquirir(nombre, paraQuien, juegosAadquirir).
planeaAdquirir(melanie, melanie, [counterStrike]).
planeaAdquirir(melanie, candela, [tetris, crucigrama, calabozosYDragones]).
planeaAdquirir(candela, melanie, [tetris, crucigrama]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUNTO 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cuantoSale(Juego, Precio) :-
    (descuento(Juego, _),
    precioEnOferta(Juego, Precio));
    precio(Juego, Precio).
    
precioEnOferta(Juego, PrecioFinal) :-
    precio(Juego, Precio),
    descuento(Juego, Descuento),
    PrecioFinal is Precio - Precio * Descuento / 100.

% % % % % % % % % % % % % % % % % % % % %

tieneUnBuenDescuento(Juego) :-
    descuento(Juego, Descuento),
    Descuento > 50.

% % % % % % % % % % % % % % % % % % % % %

esPopular(juego(_, accion)).

esPopular(Juego) :-
    juego(Juego, rol(UsersActivos)),
    UsersActivos > 1000000.

esPopular(Juego) :-
    juego(Juego, puzzle(_, facil));
    juego(Juego, puzzle(25, _)).

esPopular(minecraft, _).
esPopular(counterStrike, _).

% % % % % % % % % % % % % % % % % % % % %

adictoALosDescuentos(Usuario) :-
    usuario(Usuario, _),
    forall(juegosAadquirir(Usuario, Juego), tieneUnBuenDescuento(Juego)).

juegosAadquirir(Usuario, Juego) :-
    planeaAdquirir(Usuario, _, Juegos), 
    member(Juego, Juegos).

% % % % % % % % % % % % % % % % % % % % %

fanatico(Usuario, Genero) :-
    usuario(Usuario, Juegos),
    findall(Usuario, juegosDelGenero(Juegos, Genero), JuegosPorGenero),
    length(JuegosPorGenero, Cantidad),
    Cantidad >= 2.

juegosDelGenero(Juegos, Genero) :- 
    juego(Juego, GeneroDelJuego),
    member(Juego, Juegos),
    genero(Genero, GeneroDelJuego).

genero(accion, accion()).
genero(rol, rol(_)).
genero(puzzle, puzzle(_, _)).
    
% % % % % % % % % % % % % % % % % % % % %

monotematico(Usuario) :-
    usuario(Usuario, Juegos),
    forall(member(Juego, Juegos), (juego(Juego, GeneroDelJuego), genero(Genero, GeneroDelJuego))).

% % % % % % % % % % % % % % % % % % % % 

buenosAmigos(Usuario1, Usuario2) :-
    planeaAdquirir(Usuario1, Usuario2, _),
    planeaAdquirir(Usuario2, Usuario1, _).
