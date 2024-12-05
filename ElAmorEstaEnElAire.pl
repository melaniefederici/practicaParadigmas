% Pto 1

persona(pedro, 30, masculino).
persona(juana, 22, femenino).
persona(mariana, 19, noBinario).

leInteresa(pedro, femenino).
leInteresa(pedro, masculino).
leInteresa(juana, masculino).

edadesQueAcepta(pedro, rangoDeEdad(21, 31)).
edadesQueAcepta(juana, rangoDeEdad(22, 57)).

cosasQueLeGusta(pedro, [salirACaminar, cocinar, viajar, leer, dormir]).
cosasQueLeGusta(juana, [hacerseLasUnias, leer, cocinar, escucharMusica, salirDeJoda]).

cosasQueLeDisgusta(pedro, [hacerEjercicio, limpiar, manejar, irAlDentista, peliculasDeSuspenso]).
cosasQueLeDisgusta(juana, [genteSucia, tejer, genteImpuntual, hacerEjercicio, berenjenas]).


% Pto 2

tienePerfilIncompleto(Persona) :-
    mayorDeEdad(Persona),
    not(perfilIncompleto(Persona)).

mayorDeEdad(Persona) :-
    persona(Persona, Edad, _),
    Edad > 18.

perfilIncompleto(Persona) :-
    persona(Persona, _, _),
    leInteresa(Persona, _),
    edadesQueAcepta(Persona, _),
    cosasQueLeDisgusta(Persona, Disgustos),
    length(Disgustos, 5),
    cosasQueLeGusta(Persona, Gustos),
    length(Gustos, 5).

almaLibre(Persona) :-
    persona(Persona, _, _),
    forall((persona(OtraPersona, _, Genero), Persona \= OtraPersona), leInteresa(Persona, Genero)).

almaLibre(Persona) :-
    edadesQueAcepta(Persona, rangoDeEdad(Min, Max)),
    rangoAmplio(Max, Min).

rangoAmplio(Max, Min) :-
    Rango is Max - Min,
    Rango >= 30.
    
quiereLaHerencia(Persona) :-
    persona(Persona, Edad, _),
    edadesQueAcepta(Persona, rangoDeEdad(Min, _)),
    rangoAmplio(Min, Edad).

indeseable(Persona) :-
    persona(Persona, _, _),
    not(pretendiente(_, Persona)).

pretendiente(Pretendiente, Persona) :- 
    aceptablePara(Pretendiente, Persona),
    gustosEnComun(Pretendiente, Persona, Gustos),
    Pretendiente \= Persona,
    length(Gustos, Cuantos),
    Cuantos >= 1.

aceptablePara(Pretendiente, Persona) :-
    persona(Persona, Edad, Genero),
    leInteresa(Pretendiente, Genero),
    edadesQueAcepta(Pretendiente, rangoDeEdad(Min, Max)),
    between(Min, Max, Edad).

gustosEnComun(Persona1, Persona2, Gustos) :-
    cosasQueLeGusta(Persona1, Gustos1),
    cosasQueLeGusta(Persona2, Gustos2),
    intersection(Gustos1, Gustos2, Gustos).

hayMatch(Persona1, Persona2) :-
    pretendiente(Persona1, Persona2),
    pretendiente(Persona2, Persona1).

trianguloAmoroso(Persona1, Persona2, Persona3) :-
    pretendiente(Persona1, Persona2),
    pretendiente(Persona2, Persona3),
    pretendiente(Persona3, Persona1),
    not(hayMatches(Persona1, Persona2, Persona3)).

hayMatches(Persona1, Persona2, Persona3) :-
    hayMatch(Persona1, Persona2),
    hayMatch(Persona2, Persona3),
    hayMatch(Persona3, Persona1).

unoParaElOtro(Persona1, Persona2) :-
    hayMatch(Persona1, Persona2),
    seToleran(Persona1, Persona2),
    seToleran(Persona2, Persona1).
    
seToleran(Persona1, Persona2) :-
    cosasQueLeGusta(Persona1, Cosas1),
    cosasQueLeDisgusta(Persona2, Cosas2),
    forall(member(Cosa, Cosas1), not(member(Cosa, Cosas2))).

indiceDeAmor(pedro, juana, 9).
indiceDeAmor(pedro, juana, 8).
indiceDeAmor(pedro, juana, 7).
indiceDeAmor(pedro, juana, 8).

indiceDeAmor(juana, pedro, 5).
indiceDeAmor(juana, pedro, 2).
indiceDeAmor(juana, pedro, 1).
indiceDeAmor(juana, pedro, 4).

promedioIndices(Persona1, Persona2, Promedio) :-
    indiceDeAmor(Persona1, Persona2, _),
    findall(Indice, indiceDeAmor(Persona1, Persona2, Indice), Indices),
    sum_list(Indices, Suma),
    length(Indices, Cantidad),
    Promedio is Suma / Cantidad.

desbalance(Persona1, Persona2) :-
    promedioIndices(Persona1, Persona2, Promedio1),
    promedioIndices(Persona2, Persona1, Promedio2),
    Promedio1 > 2 * Promedio2.

ghosteaA(Persona1, Persona2) :-
    indiceDeAmor(Persona2, Persona1, _),
    not(indiceDeAmor(Persona1, Persona2, _)).




    

    
    