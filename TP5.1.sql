#..........................partie 1.......................
# Créer la base de données
create database if not exists Gestion_des_notes;
#Créer les tables
create table Filiere(
CodeFil varchar(5) ,
LibelléFil varchar(150) not null,
primary key (CodeFil)
);

create table etudiant(
codeEt varchar(8) primary key,
sexe char(1) check (sexe in ('F','M')),
NomEt varchar(50) not null ,
PrenomEt varchar(50),
DateNais date ,
TelMobil varchar(10) check (TelMobil like '06%'),
Email varchar(50)  unique check (Email like '%@%'),
CodeFil varchar(5)  ,
foreign key (CodeFil) references filiere(CodeFil) on update cascade on delete set null 
);
create table Module (
NumMod int primary key auto_increment,
LibelleMod varchar(200) unique not null,
NbrHeures int 
);
create table examen(
codeEt varchar(8),
NumMod int,
DateEX date  default '2022-06-15',
NoteEx decimal (4,2) check (NoteEx between 0 and 20),
primary key (codeEt,NumMod),
foreign key (codeEt) references etudiant(codeEt),
foreign key (NumMod) references module(NumMod) 
);
insert into filiere values
('F-1','Génie Informatique'),
('F-2','Génie Elécrique'),
('F-3','Génie Mécanique'),
('F-4','Génie Industriel'),
('F-5','Génie Commerce'),
('F-6','Génie Marketing');
insert into module (LibelleMod,NbrHeures) values 
('Algorithmique',50),
('Algèbre',30),
('Analyse',30),
('TEC',36),
('Mecanique de Fluide',50),
('Chimie indistruel',40),
('POO',50),
('Base De Données',50);
insert into etudiant values
('E-001','M','Raji','Ali','2000-05-25','0667526325','ragi@gmail.com','F-1');
insert into etudiant values
('E-002','F','Dani','Salma','1999-04-06','0658478596','dani@gmail.com','F-1');
insert into etudiant values
('E-003','M','Fellah','Amine','1998-01-17','0652145289','fellah@gmail.fr','F-5');
insert into etudiant values
('E-004','F','Berrou','leila','2000-09-15','0672524158','berrou@gmail.fr','F-4'),
('E-005','F','Sakhi','Asma','1997-05-14','0660656417','sakhi@gmail.com','F-2'),
('E-006','F','Malki','Marwa','1998-01-20','0668741952','malki@gmail.fr','F-3');
insert into examen (codeEt,NumMod,NoteEx) values
('E-001',1,15),
('E-002',8,14.25),
('E-003',4,16),
('E-004',7,13.25),
('E-004',6,17),
('E-005',2,12.75),
('E-005',1,8.5);
insert into examen values ('E-005',7, '2000-07-10',8.5);
#............................questions ........................
#Quel est le nombre total d’étudiants 
SELECT count(*) FROM ETUDIANT ;
SELECT count(*)  as 'nombre total des étudiants' FROM ETUDIANT ;
#Quelles sont, parmi l’ensemble des notes, la note la plus haute et la note la plus basse
SELECT MIN(NoteEx) as 'note minimale', MAX(NoteEx) as 'note maximale' FROM examen;
#le nombre des etudiants qui sont inscrit dans la filiere Génie Informatique
select count(*) as 'nombre etudiant Génie Informatique'  from etudiant where CodeFil='F-1'  ;
#la moyenne de chaque etudiant
select  E.codeEt,E.NomEt, avg(Ex.NoteEx) as MoyenneEt  from   etudiant E,examen Ex
where E.codeEt=Ex.codeEt
group by Ex.codeEt ;

#afficher les notes des etudiantes filles concernat chaque module
select  E.NomET,E.PrenomEt , M.LibelleMod, Ex.NoteEx from examen EX,etudiant E,module M 
where E.codeEt=Ex.codeEt  and Ex.NumMod=M.NumMod and E.sexe='F';
#afficher les notes des etudiants garçons concernat chaque module
select  E.NomET,E.PrenomEt , M.LibelleMod, Ex.NoteEx from examen EX,etudiant E,module M 
where E.codeEt=Ex.codeEt  and Ex.NumMod=M.NumMod and E.sexe='M';
#aficher le nombre des etudiant inscrit dans chaque filiere
select   F.LibelléFil, count(*) as 'nombre etudiant' from filiere  F,etudiant E 
where E.CodeFil=F.CodeFil
group by LibelléFil;
#pour chaque filiere afficher les etudiant qui sont inscrit
select   E.NomEt,E.PrenomEt,F.LibelléFil  from filiere  F,etudiant E 
where E.CodeFil=F.CodeFil;
#ou bien
select   etudiant.NomEt,etudiant.PrenomEt,filiere.LibelléFil  from filiere ,etudiant 
where etudiant.CodeFil=filiere.CodeFil;

