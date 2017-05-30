/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     20.02.2017 14:26:27                          */
/*==============================================================*/


drop table if exists Autor;

drop table if exists Autorstwo;

drop table if exists Egzemplarz;

drop table if exists Gatunek;

drop table if exists HistoriaWypozyczen;

drop table if exists Jezyk;

drop table if exists Kara;

drop table if exists Klient;

drop table if exists KontoBiblioteczne;

drop table if exists Ksiazka;

drop table if exists Nosnik;

drop table if exists Placówka;

drop table if exists Wydawnictwo;

drop table if exists Wypozyczenie;

/*==============================================================*/
/* Table: Autor                                                 */
/*==============================================================*/
create table Autor
(
   AutorID              int not null comment 'Numer porz¹dkowy autora
            ',
   Imie                 varchar(20) not null comment 'Nazwa nadawana przez rodzicow',
   Nazwisko             varchar(20) not null comment 'Dziedziczone rodzinnie',
   Kraj                 varchar(20) comment 'Miejsce pochodzenia autora',
   primary key (AutorID)
);

alter table Autor comment 'Encja opisuj¹ca osobê odpowiedzialn¹ b¹dŸ wspó³odpowiedziala';

/*==============================================================*/
/* Table: Autorstwo                                             */
/*==============================================================*/
create table Autorstwo
(
   KsiazkaID            int not null comment 'Numer porz¹dkowy ksi¹¿ki',
   AutorID              int not null comment 'Numer porz¹dkowy autora
            ',
   primary key (KsiazkaID, AutorID)
);

/*==============================================================*/
/* Table: Egzemplarz                                            */
/*==============================================================*/
create table Egzemplarz
(
   Sygnatura            char(8) not null comment 'Jednoznaczny parametr wyró¿naj¹cy dany egzemplarz w ksiêgozbiorze
            ',
   KsiazkaID            int comment 'Numer porz¹dkowy ksi¹¿ki',
   PlacowkaID           int,
   NosnikID             int comment 'Numer porz¹dkowy
            ',
   LiczbaStron          int comment 'Liczba poszcególnych stron w danym egzemplarzu',
   TypOkladki           char(1) default 'm' comment 'Typ ok³adki w jaki jest dany egzemplarz oprawiony
            Mo¿e byæ miêkka albo twarda ok³adka',
   primary key (Sygnatura)
);

alter table Egzemplarz comment 'Encja opisujaca poszczególny fizyczny obiekt danej ksi¹¿ki';

/*==============================================================*/
/* Table: Gatunek                                               */
/*==============================================================*/
create table Gatunek
(
   GatunekID            int not null comment 'Numer porz¹dkowy ',
   Gatunek              varchar(30),
   primary key (GatunekID)
);

alter table Gatunek comment 'Encja opisuj¹ca gatunek literacki, charakterystyczny dla ka¿';

/*==============================================================*/
/* Table: HistoriaWypozyczen                                    */
/*==============================================================*/
create table HistoriaWypozyczen
(
   HistoriaWypozyczenID int not null comment 'Atrybut porz¹dkowy dla tej encji
            ',
   KontoID              int comment 'Numer porz¹dkowy bibliotecznych kont klienckich',
   Sygnatura            char(8) comment 'Jednoznaczny parametr wyró¿naj¹cy dany egzemplarz w ksiêgozbiorze
            ',
   DataWypozyczenia     date comment 'Data wypo¿yczenia danego egzemplarzu ksi¹zki przez klienta',
   DataZwrotu           date comment 'Data zwrócenia danego egzemplarza
            ',
   primary key (HistoriaWypozyczenID)
);

alter table HistoriaWypozyczen comment 'Encja opisujaca egzempalarz, ktore ju¿ zostaly zwrocone i ka';

/*==============================================================*/
/* Table: Jezyk                                                 */
/*==============================================================*/
create table Jezyk
(
   JezykID              int not null comment 'Numer porz¹dkowy jêzyka
            ',
   Jezyk                varchar(20) not null comment 'Jêzyk charakterystyczny dla napisanej ksi¹¿ki
            ',
   primary key (JezykID)
);

alter table Jezyk comment 'Encja opisujaca jêzyk w jakim zosta³a napisana dana Ksi¹¿ka';

/*==============================================================*/
/* Table: Kara                                                  */
/*==============================================================*/
create table Kara
(
   KaraID               int not null comment 'Numer porz¹dkowy danej kary',
   KontoID              int comment 'Numer porz¹dkowy bibliotecznych kont klienckich',
   WypozyczenieID       int,
   DataNa³o¿enia        date not null comment 'Data na³o¿enia kary na klienta',
   WartoœæJednostkowa   float(2,2) comment 'Wartoœæ kary za dzieñ zw³oki z oddaniem',
   primary key (KaraID)
);

alter table Kara comment 'Encja opisuj¹ca wszyskie kary ponak³adane na poszcególnych k';

/*==============================================================*/
/* Table: Klient                                                */
/*==============================================================*/
create table Klient
(
   PESEL                char(11) not null comment 'Pesel jest to unikalny numer przypisywany po narodzinach',
   Imie                 varchar(20) not null comment 'Nazwa nadawana przez rodzicow',
   Nazwisko             varchar(20) not null comment 'Dziedziczone rodzinnie',
   Miejscowosc          varchar(20) not null comment 'Fizyczna lokalizacja na mapie',
   Ulica                varchar(20) not null comment 'Nazwa ulicy przy któej zameldowany jest klient
            ',
   NumerDomu            varchar(4) not null comment 'Numer domu klienta
            ',
   NumerMieszkania      varchar(4) comment 'Numer mieszkania klienta
            ',
   KodPocztowy          varchar(6) not null comment 'Kod pocztowy zameldowania klienta',
   primary key (PESEL)
);

alter table Klient comment 'Osoba wypo¿yczajaca w bibliotece';

/*==============================================================*/
/* Table: KontoBiblioteczne                                     */
/*==============================================================*/
create table KontoBiblioteczne
(
   KontoID              int not null comment 'Numer porz¹dkowy bibliotecznych kont klienckich',
   PESEL                char(11) comment 'Pesel jest to unikalny numer przypisywany po narodzinach',
   DoZaplaty            float(5,2),
   LiczbaWypEgzemplarzy char(29) default '0',
   NumerKontaBankowego  char(29) comment 'Numer Konta bankowego do wszelkich p³atnoœci bibliotecznych',
   DataZalozenia        timestamp comment 'Data zalozenia konta biblitecznego
            ',
   primary key (KontoID)
);

alter table KontoBiblioteczne comment 'Encja opisujaca biblioteczne konto poszczególnego klienta';

/*==============================================================*/
/* Table: Ksiazka                                               */
/*==============================================================*/
create table Ksiazka
(
   KsiazkaID            int not null comment 'Numer porz¹dkowy ksi¹¿ki',
   GatunekID            int not null comment 'Numer porz¹dkowy ',
   NazwaWydawnictwa     varchar(40) not null,
   JezykID              int not null comment 'Numer porz¹dkowy jêzyka
            ',
   Tytul                varchar(50) not null comment 'Atrybut opisuj¹cy tytul danej ksi¹zki',
   primary key (KsiazkaID)
);

alter table Ksiazka comment 'Encja opisuj¹ca piœmienny utwór literacki';

/*==============================================================*/
/* Table: Nosnik                                                */
/*==============================================================*/
create table Nosnik
(
   NosnikID             int not null comment 'Numer porz¹dkowy
            ',
   Typ                  char(1) not null default 'k',
   primary key (NosnikID)
);

alter table Nosnik comment 'Encja opisuj¹ca formê w jakiej mo¿na wypo¿yczycz dany egzemp';

/*==============================================================*/
/* Table: Placówka                                              */
/*==============================================================*/
create table Placówka
(
   PlacowkaID           int not null,
   MiejscowoscPl        varchar(40) not null,
   MaxPojemnosc         int not null,
   primary key (PlacowkaID)
);

alter table Placówka comment 'Encja opisuj¹ca placówkê biblioteczna';

/*==============================================================*/
/* Table: Wydawnictwo                                           */
/*==============================================================*/
create table Wydawnictwo
(
   NazwaWydawnictwa     varchar(40) not null,
   Miejscowosc          varchar(20) not null comment 'Fizyczna lokalizacja na mapie',
   primary key (NazwaWydawnictwa)
);

alter table Wydawnictwo comment 'Instytuacja odpowiedzialna za wydanie ksi¹¿ki na rynek';

/*==============================================================*/
/* Table: Wypozyczenie                                          */
/*==============================================================*/
create table Wypozyczenie
(
   WypozyczenieID       int not null,
   KaraID               int comment 'Numer porz¹dkowy danej kary',
   KontoID              int not null comment 'Numer porz¹dkowy bibliotecznych kont klienckich',
   Sygnatura            char(8) comment 'Jednoznaczny parametr wyró¿naj¹cy dany egzemplarz w ksiêgozbiorze
            ',
   DataWypozyczenia     date not null comment 'Data wypo¿yczenia danego egzemplarzu ksi¹zki przez klienta',
   DataZwrotu           date comment 'Data zwrócenia danego egzemplarza
            ',
   TerminZwrotu         date not null comment 'Przewidywany termin zwrotu
            ',
   CzyPrzedluzona       int comment 'Czy u¿ytkownik przed³u¿y³ wypo¿yczenie
            ',
   primary key (WypozyczenieID)
);

alter table Wypozyczenie comment 'Encja opisuj¹ca transakcjê wypo¿yczenia danego egzemplarzu k';

alter table Autorstwo add constraint FK_Autor foreign key (KsiazkaID)
      references Ksiazka (KsiazkaID) on delete restrict on update restrict;

alter table Autorstwo add constraint FK_Dzielo foreign key (AutorID)
      references Autor (AutorID) on delete restrict on update restrict;

alter table Egzemplarz add constraint FK_Ufizycznienie foreign key (NosnikID)
      references Nosnik (NosnikID) on delete restrict on update restrict;

alter table Egzemplarz add constraint FK_Umiejscowienie foreign key (PlacowkaID)
      references Placówka (PlacowkaID) on delete restrict on update restrict;

alter table Egzemplarz add constraint FK_Uszczegolowienie foreign key (KsiazkaID)
      references Ksiazka (KsiazkaID) on delete restrict on update restrict;

alter table HistoriaWypozyczen add constraint FK_archiwizacja foreign key (Sygnatura)
      references Egzemplarz (Sygnatura) on delete restrict on update restrict;

alter table HistoriaWypozyczen add constraint FK_posiadanie_ foreign key (KontoID)
      references KontoBiblioteczne (KontoID) on delete restrict on update restrict;

alter table Kara add constraint FK_NadanieKary2 foreign key (WypozyczenieID)
      references Wypozyczenie (WypozyczenieID) on delete restrict on update restrict;

alter table Kara add constraint FK_PosiadanieKary foreign key (KontoID)
      references KontoBiblioteczne (KontoID) on delete restrict on update restrict;

alter table KontoBiblioteczne add constraint FK_posiadanie foreign key (PESEL)
      references Klient (PESEL) on delete restrict on update restrict;

alter table Ksiazka add constraint FK_Charakterystyka foreign key (GatunekID)
      references Gatunek (GatunekID) on delete restrict on update restrict;

alter table Ksiazka add constraint FK_UzytyJezyk foreign key (JezykID)
      references Jezyk (JezykID) on delete restrict on update restrict;

alter table Ksiazka add constraint FK_Wydanie foreign key (NazwaWydawnictwa)
      references Wydawnictwo (NazwaWydawnictwa) on delete restrict on update restrict;

alter table Wypozyczenie add constraint FK_NadanieKary foreign key (KaraID)
      references Kara (KaraID) on delete restrict on update restrict;

alter table Wypozyczenie add constraint FK_Przydzielenie foreign key (KontoID)
      references KontoBiblioteczne (KontoID) on delete restrict on update restrict;

alter table Wypozyczenie add constraint FK_WypozyczenieEgzemplarza foreign key (Sygnatura)
      references Egzemplarz (Sygnatura) on delete restrict on update restrict;

