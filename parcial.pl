% loft(anio)
% casa(metrosCuadrados)
% departamento(ambientes, banios)
% barrio(Nombre, Barrio)
% viveEn(Nombre, Propiedad)

viveEn(juan, casa(120)).
viveEn(nico, departamento(3,2)).
viveEn(alf, departamento(3,1)).
viveEn(julian, loft(2000)).
viveEn(vale, departamento(4,1)).
viveEn(fer, casa(110)).

barrio(alf, almagro).
barrio(juan, almagro).
barrio(nico, almagro).
barrio(julian, almagro).
barrio(vale, flores).
barrio(fer, flores).

valor(juan, 150000).
valor(nico, 80000).
valor(alf, 75000).
valor(julian, 140000).
valor(vale, 95000).
valor(fer, 60000).


%% Funciones intermedias

lugarCopado(casa(Metros)):-
    Metros > 100.

lugarCopado(departamento(Ambientes, _)):-
    Ambientes > 3.

lugarCopado(departamento(_, Banios)):-
    Banios > 1.

lugarCopado(loft(Anio)):-
    Anio > 2015.

lugarBarato(casa(Metros)):-
    Metros < 90.

lugarBarato(departamento(Ambientes, _)):-
    Ambientes < 3.

lugarBarato(loft(Anio)):-
    Anio < 2005.

viveEnUnLugarCopado(Nombre):-
    viveEn(Nombre, Lugar),
    lugarCopado(Lugar).

viveEnUnLugarBarato(Nombre):-
    viveEn(Nombre, Lugar),
    lugarBarato(Lugar).

puedoComprar(Nombre, Plata):-
    valor(Nombre, Precio),
    Plata >= Precio.

sublista([], []).
sublista([_|Cola], Sublista):-sublista(Cola,Sublista).
sublista([Cabeza|Cola], [Cabeza|Sublista]):-sublista(Cola,Sublista).

%%

barrioCopado(Barrio):-
    barrio(_, Barrio),
    forall(barrio(Nombre, Barrio), viveEnUnLugarCopado(Nombre)).

barrioCaro(Barrio):-
    barrio(_, Barrio),
    forall(barrio(Nombre, Barrio), not(viveEnUnLugarBarato(Nombre))).

comprar(Plata, Casas, PlataRestante):-
    findall(Nombre, puedoComprar(Nombre, Plata), ListaTotal),
    sublista(ListaTotal, Casas),
    maplist(valor, Casas, ListaPrecios),
    sumlist(ListaPrecios, CostoTotal),
    PlataRestante is Plata - CostoTotal,
    PlataRestante >= 0.