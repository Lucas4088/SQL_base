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

drop table if exists Plac�wka;

drop table if exists Wydawnictwo;

drop table if exists Wypozyczenie;

/*==============================================================*/
/* Table: Autor                                                 */
/*==============================================================*/
create table Autor
(
   AutorID              int not null comment 'Numer porz�dkowy autora
            ',
   Imie                 varchar(20) not null comment 'Nazwa nadawana przez rodzicow',
   Nazwisko             varchar(20) not null comment 'Dziedziczone rodzinnie',
   Kraj                 varchar(20) comment 'Miejsce pochodzenia autora',
   primary key (AutorID)
);

alter table Autor comment 'Encja opisuj�ca osob� odpowiedzialn� b�d� wsp�odpowiedziala';

/*==============================================================*/
/* Table: Autorstwo                                             */
/*==============================================================*/
create table Autorstwo
(
   KsiazkaID            int not null comment 'Numer porz�dkowy ksi��ki',
   AutorID              int not null comment 'Numer porz�dkowy autora
            ',
   primary key (KsiazkaID, AutorID)
);

/*==============================================================*/
/* Table: Egzemplarz                                            */
/*==============================================================*/
create table Egzemplarz
(
   Sygnatura            char(8) not null comment 'Jednoznaczny parametr wyr�naj�cy dany egzemplarz w ksi�gozbiorze
            ',
   KsiazkaID            int comment 'Numer porz�dkowy ksi��ki',
   PlacowkaID           int,
   NosnikID             int comment 'Numer porz�dkowy
            ',
   LiczbaStron          int comment 'Liczba poszceg�lnych stron w danym egzemplarzu',
   TypOkladki           char(1) default 'm' comment 'Typ ok�adki w jaki jest dany egzemplarz oprawiony
            Mo�e by� mi�kka albo twarda ok�adka',
   primary key (Sygnatura)
);

alter table Egzemplarz comment 'Encja opisujaca poszczeg�lny fizyczny obiekt danej ksi��ki';

/*==============================================================*/
/* Table: Gatunek                                               */
/*==============================================================*/
create table Gatunek
(
   GatunekID            int not null comment 'Numer porz�dkowy ',
   Gatunek              varchar(30),
   primary key (GatunekID)
);

alter table Gatunek comment 'Encja opisuj�ca gatunek literacki, charakterystyczny dla ka�';

/*==============================================================*/
/* Table: HistoriaWypozyczen                                    */
/*==============================================================*/
create table HistoriaWypozyczen
(
   HistoriaWypozyczenID int not null comment 'Atrybut porz�dkowy dla tej encji
            ',
   KontoID              int comment 'Numer porz�dkowy bibliotecznych kont klienckich',
   Sygnatura            char(8) comment 'Jednoznaczny parametr wyr�naj�cy dany egzemplarz w ksi�gozbiorze
            ',
   DataWypozyczenia     date comment 'Data wypo�yczenia danego egzemplarzu ksi�zki przez klienta',
   DataZwrotu           date comment 'Data zwr�cenia danego egzemplarza
            ',
   primary key (HistoriaWypozyczenID)
);

alter table HistoriaWypozyczen comment 'Encja opisujaca egzempalarz, ktore ju� zostaly zwrocone i ka';

/*==============================================================*/
/* Table: Jezyk                                                 */
/*==============================================================*/
create table Jezyk
(
   JezykID              int not null comment 'Numer porz�dkowy j�zyka
            ',
   Jezyk                varchar(20) not null comment 'J�zyk charakterystyczny dla napisanej ksi��ki
            ',
   primary key (JezykID)
);

alter table Jezyk comment 'Encja opisujaca j�zyk w jakim zosta�a napisana dana Ksi��ka';

/*==============================================================*/
/* Table: Kara                                                  */
/*==============================================================*/
create table Kara
(
   KaraID               int not null comment 'Numer porz�dkowy danej kary',
   KontoID              int comment 'Numer porz�dkowy bibliotecznych kont klienckich',
   WypozyczenieID       int,
   DataNa�o�enia        date not null comment 'Data na�o�enia kary na klienta',
   Warto��Jednostkowa   float(2,2) comment 'Warto�� kary za dzie� zw�oki z oddaniem',
   primary key (KaraID)
);

alter table Kara comment 'Encja opisuj�ca wszyskie kary ponak�adane na poszceg�lnych k';

/*==============================================================*/
/* Table: Klient                                                */
/*==============================================================*/
create table Klient
(
   PESEL                char(11) not null comment 'Pesel jest to unikalny numer przypisywany po narodzinach',
   Imie                 varchar(20) not null comment 'Nazwa nadawana przez rodzicow',
   Nazwisko             varchar(20) not null comment 'Dziedziczone rodzinnie',
   Miejscowosc          varchar(20) not null comment 'Fizyczna lokalizacja na mapie',
   Ulica                varchar(20) not null comment 'Nazwa ulicy przy kt�ej zameldowany jest klient
            ',
   NumerDomu            varchar(4) not null comment 'Numer domu klienta
            ',
   NumerMieszkania      varchar(4) comment 'Numer mieszkania klienta
            ',
   KodPocztowy          varchar(6) not null comment 'Kod pocztowy zameldowania klienta',
   primary key (PESEL)
);

alter table Klient comment 'Osoba wypo�yczajaca w bibliotece';

/*==============================================================*/
/* Table: KontoBiblioteczne                                     */
/*==============================================================*/
create table KontoBiblioteczne
(
   KontoID              int not null comment 'Numer porz�dkowy bibliotecznych kont klienckich',
   PESEL                char(11) comment 'Pesel jest to unikalny numer przypisywany po narodzinach',
   DoZaplaty            float(5,2),
   LiczbaWypEgzemplarzy char(29) default '0',
   NumerKontaBankowego  char(29) comment 'Numer Konta bankowego do wszelkich p�atno�ci bibliotecznych',
   DataZalozenia        timestamp comment 'Data zalozenia konta biblitecznego
            ',
   primary key (KontoID)
);

alter table KontoBiblioteczne comment 'Encja opisujaca biblioteczne konto poszczeg�lnego klienta';

/*==============================================================*/
/* Table: Ksiazka                                               */
/*==============================================================*/
create table Ksiazka
(
   KsiazkaID            int not null comment 'Numer porz�dkowy ksi��ki',
   GatunekID            int not null comment 'Numer porz�dkowy ',
   NazwaWydawnictwa     varchar(40) not null,
   JezykID              int not null comment 'Numer porz�dkowy j�zyka
            ',
   Tytul                varchar(50) not null comment 'Atrybut opisuj�cy tytul danej ksi�zki',
   primary key (KsiazkaID)
);

alter table Ksiazka comment 'Encja opisuj�ca pi�mienny utw�r literacki';

/*==============================================================*/
/* Table: Nosnik                                                */
/*==============================================================*/
create table Nosnik
(
   NosnikID             int not null comment 'Numer porz�dkowy
            ',
   Typ                  char(1) not null default 'k',
   primary key (NosnikID)
);

alter table Nosnik comment 'Encja opisuj�ca form� w jakiej mo�na wypo�yczycz dany egzemp';

/*==============================================================*/
/* Table: Plac�wka                                              */
/*==============================================================*/
create table Plac�wka
(
   PlacowkaID           int not null,
   MiejscowoscPl        varchar(40) not null,
   MaxPojemnosc         int not null,
   primary key (PlacowkaID)
);

alter table Plac�wka comment 'Encja opisuj�ca plac�wk� biblioteczna';

/*==============================================================*/
/* Table: Wydawnictwo                                           */
/*==============================================================*/
create table Wydawnictwo
(
   NazwaWydawnictwa     varchar(40) not null,
   Miejscowosc          varchar(20) not null comment 'Fizyczna lokalizacja na mapie',
   primary key (NazwaWydawnictwa)
);

alter table Wydawnictwo comment 'Instytuacja odpowiedzialna za wydanie ksi��ki na rynek';

/*==============================================================*/
/* Table: Wypozyczenie                                          */
/*==============================================================*/
create table Wypozyczenie
(
   WypozyczenieID       int not null,
   KaraID               int comment 'Numer porz�dkowy danej kary',
   KontoID              int not null comment 'Numer porz�dkowy bibliotecznych kont klienckich',
   Sygnatura            char(8) comment 'Jednoznaczny parametr wyr�naj�cy dany egzemplarz w ksi�gozbiorze
            ',
   DataWypozyczenia     date not null comment 'Data wypo�yczenia danego egzemplarzu ksi�zki przez klienta',
   DataZwrotu           date comment 'Data zwr�cenia danego egzemplarza
            ',
   TerminZwrotu         date not null comment 'Przewidywany termin zwrotu
            ',
   CzyPrzedluzona       int comment 'Czy u�ytkownik przed�u�y� wypo�yczenie
            ',
   primary key (WypozyczenieID)
);

alter table Wypozyczenie comment 'Encja opisuj�ca transakcj� wypo�yczenia danego egzemplarzu k';

alter table Autorstwo add constraint FK_Autor foreign key (KsiazkaID)
      references Ksiazka (KsiazkaID) on delete restrict on update restrict;

alter table Autorstwo add constraint FK_Dzielo foreign key (AutorID)
      references Autor (AutorID) on delete restrict on update restrict;

alter table Egzemplarz add constraint FK_Ufizycznienie foreign key (NosnikID)
      references Nosnik (NosnikID) on delete restrict on update restrict;

alter table Egzemplarz add constraint FK_Umiejscowienie foreign key (PlacowkaID)
      references Plac�wka (PlacowkaID) on delete restrict on update restrict;

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

