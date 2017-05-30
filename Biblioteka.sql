/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     21.01.2017 14:51:46                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_AUTORSTW_AUTOR_KSIAZKA') then
    alter table Autorstwo
       delete foreign key FK_AUTORSTW_AUTOR_KSIAZKA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_AUTORSTW_DZIELO_AUTOR') then
    alter table Autorstwo
       delete foreign key FK_AUTORSTW_DZIELO_AUTOR
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EGZEMPLA_RELATIONS_PLACÓWKA') then
    alter table Egzemplarz
       delete foreign key FK_EGZEMPLA_RELATIONS_PLACÓWKA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EGZEMPLA_UFIZYCZNI_NOSNIK') then
    alter table Egzemplarz
       delete foreign key FK_EGZEMPLA_UFIZYCZNI_NOSNIK
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EGZEMPLA_USZCZEGOL_KSIAZKA') then
    alter table Egzemplarz
       delete foreign key FK_EGZEMPLA_USZCZEGOL_KSIAZKA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_HISTORIA_RELATIONS_KONTOBIB') then
    alter table HistoriaWypozyczen
       delete foreign key FK_HISTORIA_RELATIONS_KONTOBIB
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_HISTORIA_RELATIONS_EGZEMPLA') then
    alter table HistoriaWypozyczen
       delete foreign key FK_HISTORIA_RELATIONS_EGZEMPLA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KARA_NADANIEKA_WYPOZYCZ') then
    alter table Kara
       delete foreign key FK_KARA_NADANIEKA_WYPOZYCZ
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KARA_POSIADANI_KONTOBIB') then
    alter table Kara
       delete foreign key FK_KARA_POSIADANI_KONTOBIB
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KONTOBIB_RELATIONS_KLIENT') then
    alter table KontoBiblioteczne
       delete foreign key FK_KONTOBIB_RELATIONS_KLIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KSIAZKA_CHARAKTER_GATUNEK') then
    alter table Ksiazka
       delete foreign key FK_KSIAZKA_CHARAKTER_GATUNEK
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KSIAZKA_U¯YTYJÊZY_JEZYK') then
    alter table Ksiazka
       delete foreign key FK_KSIAZKA_U¯YTYJÊZY_JEZYK
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KSIAZKA_WYDANIE_WYDAWNIC') then
    alter table Ksiazka
       delete foreign key FK_KSIAZKA_WYDANIE_WYDAWNIC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_WYPOZYCZ_NADANIEKA_KARA') then
    alter table Wypozyczenie
       delete foreign key FK_WYPOZYCZ_NADANIEKA_KARA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_WYPOZYCZ_PRZYDZIEL_KONTOBIB') then
    alter table Wypozyczenie
       delete foreign key FK_WYPOZYCZ_PRZYDZIEL_KONTOBIB
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_WYPOZYCZ_WYPOZYCZE_EGZEMPLA') then
    alter table Wypozyczenie
       delete foreign key FK_WYPOZYCZ_WYPOZYCZE_EGZEMPLA
end if;

drop index if exists Autor.Autor_PK;

drop table if exists Autor;

drop index if exists Autorstwo.Dzielo_FK;

drop index if exists Autorstwo.Autor_FK;

drop index if exists Autorstwo.Autorstwo_PK;

drop table if exists Autorstwo;

drop index if exists Egzemplarz.Relationship_12_FK;

drop index if exists Egzemplarz.Ufizycznienie_FK;

drop index if exists Egzemplarz.Uszczegolowienie_FK;

drop index if exists Egzemplarz.Egzemplarz_PK;

drop table if exists Egzemplarz;

drop index if exists Gatunek.Gatunek_PK;

drop table if exists Gatunek;

drop index if exists HistoriaWypozyczen.Relationship_14_FK;

drop index if exists HistoriaWypozyczen.Relationship_13_FK;

drop index if exists HistoriaWypozyczen.HistoriaWypozyczen_PK;

drop table if exists HistoriaWypozyczen;

drop index if exists Jezyk.Jezyk_PK;

drop table if exists Jezyk;

drop index if exists Kara.PosiadanieKary_FK;

drop index if exists Kara.NadanieKary2_FK;

drop index if exists Kara.Kara_PK;

drop table if exists Kara;

drop index if exists Klient.Klient_PK;

drop table if exists Klient;

drop index if exists KontoBiblioteczne.Relationship_11_FK;

drop index if exists KontoBiblioteczne.KontoBiblioteczne_PK;

drop table if exists KontoBiblioteczne;

drop index if exists Ksiazka.U¿ytyJêzyk_FK;

drop index if exists Ksiazka.Charakterystyka_FK;

drop index if exists Ksiazka.Wydanie_FK;

drop index if exists Ksiazka.Ksiazka_PK;

drop table if exists Ksiazka;

drop index if exists Nosnik.Nosnik_PK;

drop table if exists Nosnik;

drop index if exists Placówka.Placówka_PK;

drop table if exists Placówka;

drop index if exists Wydawnictwo.Wydawnictwo_PK;

drop table if exists Wydawnictwo;

drop index if exists Wypozyczenie.NadanieKary_FK;

drop index if exists Wypozyczenie.Przydzielenie_FK;

drop index if exists Wypozyczenie.WypozyczenieEgzemplarza_FK;

drop index if exists Wypozyczenie.Wypozyczenie_PK;

drop table if exists Wypozyczenie;

/*==============================================================*/
/* Table: Autor                                                 */
/*==============================================================*/
create table Autor 
(
   AutorID              integer                        not null DEFAULT AUTOINCREMENT ,
   Imie                 varchar(20)                    not null,
   Nazwisko             varchar(20)                    not null,
   Kraj                 varchar(20)                    null,
   constraint PK_AUTOR primary key (AutorID)
);

comment on table Autor is 
'Encja opisuj¹ca osobê odpowiedzialn¹ b¹dŸ wspó³odpowiedzialan¹ za napisanie ksi¹¿ki';

comment on column Autor.AutorID is 
'Numer porz¹dkowy autora
';

comment on column Autor.Imie is 
'Nazwa nadawana przez rodzicow';

comment on column Autor.Nazwisko is 
'Dziedziczone rodzinnie';

comment on column Autor.Kraj is 
'Miejsce pochodzenia autora';

/*==============================================================*/
/* Index: Autor_PK                                              */
/*==============================================================*/
create unique index Autor_PK on Autor (
AutorID ASC
);

/*==============================================================*/
/* Table: Autorstwo                                             */
/*==============================================================*/
create table Autorstwo 
(
   KsiazkaID            integer                        not null DEFAULT AUTOINCREMENT,
   AutorID              integer                        not null,
   constraint PK_AUTORSTWO primary key  (KsiazkaID, AutorID)
);

comment on column Autorstwo.KsiazkaID is 
'Numer porz¹dkowy ksi¹¿ki';

comment on column Autorstwo.AutorID is 
'Numer porz¹dkowy autora
';

/*==============================================================*/
/* Index: Autorstwo_PK                                          */
/*==============================================================*/
create unique  index Autorstwo_PK on Autorstwo (
KsiazkaID ASC,
AutorID ASC
);

/*==============================================================*/
/* Index: Autor_FK                                              */
/*==============================================================*/
create index Autor_FK on Autorstwo (
KsiazkaID ASC
);

/*==============================================================*/
/* Index: Dzielo_FK                                             */
/*==============================================================*/
create index Dzielo_FK on Autorstwo (
AutorID ASC
);

/*==============================================================*/
/* Table: Egzemplarz                                            */
/*==============================================================*/
create table Egzemplarz 
(
   Sygnatura            char(8)                        not null,
   KsiazkaID            integer                        null,
   PlacowkaID           integer                        null,
   NosnikID             integer                        null,
   LiczbaStron          integer                        null,
   TypOkladki           char(1)                        null default 'm',
   constraint PK_EGZEMPLARZ primary key (Sygnatura)
);

comment on table Egzemplarz is 
'Encja opisujaca poszczególny fizyczny obiekt danej ksi¹¿ki';

comment on column Egzemplarz.Sygnatura is 
'Jednoznaczny parametr wyró¿naj¹cy dany egzemplarz w ksiêgozbiorze
';

comment on column Egzemplarz.KsiazkaID is 
'Numer porz¹dkowy ksi¹¿ki';

comment on column Egzemplarz.NosnikID is 
'Numer porz¹dkowy
';

comment on column Egzemplarz.LiczbaStron is 
'Liczba poszcególnych stron w danym egzemplarzu';

comment on column Egzemplarz.TypOkladki is 
'Typ ok³adki w jaki jest dany egzemplarz oprawiony
Mo¿e byæ miêkka albo twarda ok³adka';

/*==============================================================*/
/* Index: Egzemplarz_PK                                         */
/*==============================================================*/
create unique index Egzemplarz_PK on Egzemplarz (
Sygnatura ASC
);

/*==============================================================*/
/* Index: Uszczegolowienie_FK                                   */
/*==============================================================*/
create index Uszczegolowienie_FK on Egzemplarz (
KsiazkaID ASC
);

/*==============================================================*/
/* Index: Ufizycznienie_FK                                      */
/*==============================================================*/
create index Ufizycznienie_FK on Egzemplarz (
NosnikID ASC
);

/*==============================================================*/
/* Index: Relationship_12_FK                                    */
/*==============================================================*/
create index Relationship_12_FK on Egzemplarz (
PlacowkaID ASC
);

/*==============================================================*/
/* Table: Gatunek                                               */
/*==============================================================*/
create table Gatunek 
(
   GatunekID            integer                        not null DEFAULT AUTOINCREMENT,
   Gatunek              varchar(30)                    null,
   constraint PK_GATUNEK primary key (GatunekID)
);

comment on table Gatunek is 
'Encja opisuj¹ca gatunek literacki, charakterystyczny dla ka¿dej ksi¹zki';

comment on column Gatunek.GatunekID is 
'Numer porz¹dkowy ';

/*==============================================================*/
/* Index: Gatunek_PK                                            */
/*==============================================================*/
create unique index Gatunek_PK on Gatunek (
GatunekID ASC
);

/*==============================================================*/
/* Table: HistoriaWypozyczen                                    */
/*==============================================================*/
create table HistoriaWypozyczen 
(
   HistoriaWypozyczenID integer                        not null DEFAULT AUTOINCREMENT,
   KontoID              integer                        null,
   Sygnatura            char(8)                        null,
   constraint PK_HISTORIAWYPOZYCZEN primary key (HistoriaWypozyczenID)
);

comment on table HistoriaWypozyczen is 
'Encja opisujaca egzempalarz, ktore ju¿ zostaly zwrocone i kary za nich zosta³y uiszczone';

comment on column HistoriaWypozyczen.HistoriaWypozyczenID is 
'Atrybut porz¹dkowy dla tej encji
';

comment on column HistoriaWypozyczen.KontoID is 
'Numer porz¹dkowy bibliotecznych kont klienckich';

comment on column HistoriaWypozyczen.Sygnatura is 
'Jednoznaczny parametr wyró¿naj¹cy dany egzemplarz w ksiêgozbiorze
';

/*==============================================================*/
/* Index: HistoriaWypozyczen_PK                                 */
/*==============================================================*/
create unique index HistoriaWypozyczen_PK on HistoriaWypozyczen (
HistoriaWypozyczenID ASC
);

/*==============================================================*/
/* Index: Relationship_13_FK                                    */
/*==============================================================*/
create index Relationship_13_FK on HistoriaWypozyczen (
KontoID ASC
);

/*==============================================================*/
/* Index: Relationship_14_FK                                    */
/*==============================================================*/
create index Relationship_14_FK on HistoriaWypozyczen (
Sygnatura ASC
);

/*==============================================================*/
/* Table: Jezyk                                                 */
/*==============================================================*/
create table Jezyk 
(
   JezykID              integer                        not null DEFAULT AUTOINCREMENT,
   Jezyk                varchar(20)                    not null,
   constraint PK_JEZYK primary key (JezykID)
);

comment on table Jezyk is 
'Encja opisujaca jêzyk w jakim zosta³a napisana dana Ksi¹¿ka
';

comment on column Jezyk.JezykID is 
'Numer porz¹dkowy jêzyka
';

comment on column Jezyk.Jezyk is 
'Jêzyk charakterystyczny dla napisanej ksi¹¿ki
';

/*==============================================================*/
/* Index: Jezyk_PK                                              */
/*==============================================================*/
create unique index Jezyk_PK on Jezyk (
JezykID ASC
);

/*==============================================================*/
/* Table: Kara                                                  */
/*==============================================================*/
create table Kara 
(
   KaraID               integer                        not null DEFAULT AUTOINCREMENT,
   KontoID              integer                        null,
   WypozyczenieID       integer                        null,
   DataNa³o¿enia        date                           not null,
   WartoœæJednostkowa   numeric(2,2)                   null,
   constraint PK_KARA primary key (KaraID)
);

comment on table Kara is 
'Encja opisuj¹ca wszyskie kary ponak³adane na poszcególnych klientów
';

comment on column Kara.KaraID is 
'Numer porz¹dkowy danej kary';

comment on column Kara.KontoID is 
'Numer porz¹dkowy bibliotecznych kont klienckich';

comment on column Kara.DataNa³o¿enia is 
'Data na³o¿enia kary na klienta';

comment on column Kara.WartoœæJednostkowa is 
'Wartoœæ kary za dzieñ zw³oki z oddaniem';

/*==============================================================*/
/* Index: Kara_PK                                               */
/*==============================================================*/
create unique index Kara_PK on Kara (
KaraID ASC
);

/*==============================================================*/
/* Index: NadanieKary2_FK                                       */
/*==============================================================*/
create index NadanieKary2_FK on Kara (
WypozyczenieID ASC
);

/*==============================================================*/
/* Index: PosiadanieKary_FK                                     */
/*==============================================================*/
create index PosiadanieKary_FK on Kara (
KontoID ASC
);

/*==============================================================*/
/* Table: Klient                                                */
/*==============================================================*/
create table Klient 
(
   PESEL                char(11)                       not null,
   Imie                 varchar(20)                    not null,
   Nazwisko             varchar(20)                    not null,
   Miejscowosc          varchar(20)                    not null,
   Ulica                varchar(20)                    not null,
   NumerDomu            varchar(4)                     not null,
   NumerMieszkania      varchar(4)                     null,
   KodPocztowy          varchar(6)                     not null,
   constraint PK_KLIENT primary key  (PESEL)
);

comment on table Klient is 
'Osoba wypo¿yczajaca w bibliotece';

comment on column Klient.PESEL is 
'Pesel jest to unikalny numer przypisywany po narodzinach';

comment on column Klient.Imie is 
'Nazwa nadawana przez rodzicow';

comment on column Klient.Nazwisko is 
'Dziedziczone rodzinnie';

comment on column Klient.Miejscowosc is 
'Fizyczna lokalizacja na mapie';

comment on column Klient.Ulica is 
'Nazwa ulicy przy któej zameldowany jest klient
';

comment on column Klient.NumerDomu is 
'Numer domu klienta
';

comment on column Klient.NumerMieszkania is 
'Numer mieszkania klienta
';

comment on column Klient.KodPocztowy is 
'Kod pocztowy zameldowania klienta';

/*==============================================================*/
/* Index: Klient_PK                                             */
/*==============================================================*/
create unique  index Klient_PK on Klient (
PESEL ASC
);

/*==============================================================*/
/* Table: KontoBiblioteczne                                     */
/*==============================================================*/
create table KontoBiblioteczne 
(
   KontoID              integer                        not null DEFAULT AUTOINCREMENT,
   PESEL                char(11)                       null,
   DoZaplaty            numeric(5,2)                   null,
   LiczbaWypEgzemplarzy char(29)                       null,
   NumerKontaBankowego  char(29)                       null,
   DataZalozenia        timestamp                      null,
   constraint PK_KONTOBIBLIOTECZNE primary key (KontoID)
);

comment on table KontoBiblioteczne is 
'Encja opisujaca biblioteczne konto poszczególnego klienta';

comment on column KontoBiblioteczne.KontoID is 
'Numer porz¹dkowy bibliotecznych kont klienckich';

comment on column KontoBiblioteczne.PESEL is 
'Pesel jest to unikalny numer przypisywany po narodzinach';

comment on column KontoBiblioteczne.NumerKontaBankowego is 
'Numer Konta bankowego do wszelkich p³atnoœci bibliotecznych';

comment on column KontoBiblioteczne.DataZalozenia is 
'Data zalozenia konta biblitecznego
';

/*==============================================================*/
/* Index: KontoBiblioteczne_PK                                  */
/*==============================================================*/
create unique index KontoBiblioteczne_PK on KontoBiblioteczne (
KontoID ASC
);

/*==============================================================*/
/* Index: Relationship_11_FK                                    */
/*==============================================================*/
create index Relationship_11_FK on KontoBiblioteczne (
PESEL ASC
);

/*==============================================================*/
/* Table: Ksiazka                                               */
/*==============================================================*/
create table Ksiazka 
(
   KsiazkaID            integer                        not null DEFAULT AUTOINCREMENT,
   GatunekID            integer                        not null,
   NazwaWydawnictwa     varchar(40)                    not null,
   JezykID              integer                        not null,
   Tytul                varchar(50)                    not null,
   constraint PK_KSIAZKA primary key (KsiazkaID)
);

comment on table Ksiazka is 
'Encja opisuj¹ca piœmienny utwór literacki';

comment on column Ksiazka.KsiazkaID is 
'Numer porz¹dkowy ksi¹¿ki';

comment on column Ksiazka.GatunekID is 
'Numer porz¹dkowy ';

comment on column Ksiazka.JezykID is 
'Numer porz¹dkowy jêzyka
';

comment on column Ksiazka.Tytul is 
'Atrybut opisuj¹cy tytul danej ksi¹zki';

/*==============================================================*/
/* Index: Ksiazka_PK                                            */
/*==============================================================*/
create unique index Ksiazka_PK on Ksiazka (
KsiazkaID ASC
);

/*==============================================================*/
/* Index: Wydanie_FK                                            */
/*==============================================================*/
create index Wydanie_FK on Ksiazka (
NazwaWydawnictwa ASC
);

/*==============================================================*/
/* Index: Charakterystyka_FK                                    */
/*==============================================================*/
create index Charakterystyka_FK on Ksiazka (
GatunekID ASC
);

/*==============================================================*/
/* Index: U¿ytyJêzyk_FK                                         */
/*==============================================================*/
create index U¿ytyJêzyk_FK on Ksiazka (
JezykID ASC
);

/*==============================================================*/
/* Table: Nosnik                                                */
/*==============================================================*/
create table Nosnik 
(
   NosnikID             integer                        not null DEFAULT AUTOINCREMENT,
   Typ                  char(1)                        not null, 
   constraint PK_NOSNIK primary key (NosnikID)
);

comment on table Nosnik is 
'Encja opisuj¹ca formê w jakiej mo¿na wypo¿yczycz dany egzemplarz';

comment on column Nosnik.NosnikID is 
'Numer porz¹dkowy
';

/*==============================================================*/
/* Index: Nosnik_PK                                             */
/*==============================================================*/
create unique index Nosnik_PK on Nosnik (
NosnikID ASC
);

/*==============================================================*/
/* Table: Placówka                                              */
/*==============================================================*/
create table Placówka 
(
   PlacowkaID           integer                        not null DEFAULT AUTOINCREMENT,
   MiejscowoscPl        varchar(40)                    not null,
   constraint PK_PLACÓWKA primary key (PlacowkaID)
);

comment on table Placówka is 
'Encja opisuj¹ca placówkê biblioteczna';

/*==============================================================*/
/* Index: Placówka_PK                                           */
/*==============================================================*/
create unique index Placówka_PK on Placówka (
PlacowkaID ASC
);

/*==============================================================*/
/* Table: Wydawnictwo                                           */
/*==============================================================*/
create table Wydawnictwo 
(
   NazwaWydawnictwa     varchar(40)                    not null,
   Miejscowosc          varchar(20)                    not null,
   constraint PK_WYDAWNICTWO primary key (NazwaWydawnictwa)
);

comment on table Wydawnictwo is 
'Instytuacja odpowiedzialna za wydanie ksi¹¿ki na rynek';

comment on column Wydawnictwo.Miejscowosc is 
'Fizyczna lokalizacja na mapie';

/*==============================================================*/
/* Index: Wydawnictwo_PK                                        */
/*==============================================================*/
create unique index Wydawnictwo_PK on Wydawnictwo (
NazwaWydawnictwa ASC
);

/*==============================================================*/
/* Table: Wypozyczenie                                          */
/*==============================================================*/
create table Wypozyczenie 
(
   WypozyczenieID       integer                        not null DEFAULT AUTOINCREMENT,
   KaraID               integer                        null,
   KontoID              integer                        not null,
   Sygnatura            char(8)                        null,
   DataWypozyczenia     date                           not null,
   DataZwrotu           date                           null,
   constraint PK_WYPOZYCZENIE primary key (WypozyczenieID)
);

comment on table Wypozyczenie is 
'Encja opisuj¹ca transakcjê wypo¿yczenia danego egzemplarzu ksi¹zki';

comment on column Wypozyczenie.KaraID is 
'Numer porz¹dkowy danej kary';

comment on column Wypozyczenie.KontoID is 
'Numer porz¹dkowy bibliotecznych kont klienckich';

comment on column Wypozyczenie.Sygnatura is 
'Jednoznaczny parametr wyró¿naj¹cy dany egzemplarz w ksiêgozbiorze
';

comment on column Wypozyczenie.DataWypozyczenia is 
'Data wypo¿yczenia danego egzemplarzu ksi¹zki przez klienta';

comment on column Wypozyczenie.DataZwrotu is 
'Data zwrócenia danego egzemplarza
';

/*==============================================================*/
/* Index: Wypozyczenie_PK                                       */
/*==============================================================*/
create unique index Wypozyczenie_PK on Wypozyczenie (
WypozyczenieID ASC
);

/*==============================================================*/
/* Index: WypozyczenieEgzemplarza_FK                            */
/*==============================================================*/
create index WypozyczenieEgzemplarza_FK on Wypozyczenie (
Sygnatura ASC
);

/*==============================================================*/
/* Index: Przydzielenie_FK                                      */
/*==============================================================*/
create index Przydzielenie_FK on Wypozyczenie (
KontoID ASC
);

/*==============================================================*/
/* Index: NadanieKary_FK                                        */
/*==============================================================*/
create index NadanieKary_FK on Wypozyczenie (
KaraID ASC
);

alter table Autorstwo
   add constraint FK_AUTORSTW_AUTOR_KSIAZKA foreign key (KsiazkaID)
      references Ksiazka (KsiazkaID)
      on update restrict
      on delete restrict;

alter table Autorstwo
   add constraint FK_AUTORSTW_DZIELO_AUTOR foreign key (AutorID)
      references Autor (AutorID)
      on update restrict
      on delete restrict;

alter table Egzemplarz
   add constraint FK_EGZEMPLA_RELATIONS_PLACÓWKA foreign key (PlacowkaID)
      references Placówka (PlacowkaID)
      on update restrict
      on delete restrict;

alter table Egzemplarz
   add constraint FK_EGZEMPLA_UFIZYCZNI_NOSNIK foreign key (NosnikID)
      references Nosnik (NosnikID)
      on update restrict
      on delete restrict;

alter table Egzemplarz
   add constraint FK_EGZEMPLA_USZCZEGOL_KSIAZKA foreign key (KsiazkaID)
      references Ksiazka (KsiazkaID)
      on update restrict
      on delete restrict;

alter table HistoriaWypozyczen
   add constraint FK_HISTORIA_RELATIONS_KONTOBIB foreign key (KontoID)
      references KontoBiblioteczne (KontoID)
      on update restrict
      on delete restrict;

alter table HistoriaWypozyczen
   add constraint FK_HISTORIA_RELATIONS_EGZEMPLA foreign key (Sygnatura)
      references Egzemplarz (Sygnatura)
      on update restrict
      on delete restrict;

alter table Kara
   add constraint FK_KARA_NADANIEKA_WYPOZYCZ foreign key (WypozyczenieID)
      references Wypozyczenie (WypozyczenieID)
      on update restrict
      on delete restrict;

alter table Kara
   add constraint FK_KARA_POSIADANI_KONTOBIB foreign key (KontoID)
      references KontoBiblioteczne (KontoID)
      on update restrict
      on delete restrict;

alter table KontoBiblioteczne
   add constraint FK_KONTOBIB_RELATIONS_KLIENT foreign key (PESEL)
      references Klient (PESEL)
      on update restrict
      on delete restrict;

alter table Ksiazka
   add constraint FK_KSIAZKA_CHARAKTER_GATUNEK foreign key (GatunekID)
      references Gatunek (GatunekID)
      on update restrict
      on delete restrict;

alter table Ksiazka
   add constraint FK_KSIAZKA_U¯YTYJÊZY_JEZYK foreign key (JezykID)
      references Jezyk (JezykID)
      on update restrict
      on delete restrict;

alter table Ksiazka
   add constraint FK_KSIAZKA_WYDANIE_WYDAWNIC foreign key (NazwaWydawnictwa)
      references Wydawnictwo (NazwaWydawnictwa)
      on update restrict
      on delete restrict;

comment on foreign key Ksiazka.FK_KSIAZKA_WYDANIE_WYDAWNIC is 
'Wydanie';

alter table Wypozyczenie
   add constraint FK_WYPOZYCZ_NADANIEKA_KARA foreign key (KaraID)
      references Kara (KaraID)
      on update restrict
      on delete restrict;

alter table Wypozyczenie
   add constraint FK_WYPOZYCZ_PRZYDZIEL_KONTOBIB foreign key (KontoID)
      references KontoBiblioteczne (KontoID)
      on update restrict
      on delete restrict;

alter table Wypozyczenie
   add constraint FK_WYPOZYCZ_WYPOZYCZE_EGZEMPLA foreign key (Sygnatura)
      references Egzemplarz (Sygnatura)
      on update restrict
      on delete restrict;

