#..........................partie 1.......................
# Créer la base de données
create database if not exists TP3_Gestion_Examens;
#Créer les tables
create table Filiere(
CodeFil varchar(5) ,
LibelléFil varchar(150),
primary key (CodeFil)
);

create table etudiant(
codeEt varchar(8) primary key,
sexe char(1),
NomEt varchar(50) not null ,
PrenomEt varchar(50),
DateNais date ,
TeleFixe varchar(10),
TelMobil varchar(10),
Email varchar(50) unique ,
CodeFiliere varchar(5)  ,
foreign key (CodeFiliere) references filiere(CodeFil) on update cascade on delete set null 
);
create table Module (
NumMod int primary key auto_increment,
LibelleMod varchar(200)
);
create table examen(
CodeETud varchar(8),
NumMO int,
DateEX date ,
NoteEx decimal (4,2),
primary key (CodeETud,NumMo)
);
alter table examen add constraint foreign key (CodeETud) references etudiant(codeEt);
alter table examen add constraint foreign key (NumMO) references module(NumMod) ;
alter table module add constraint unique (LibelleMod);
# Q 3 :Modifier la table module
alter table module add NbrHeures int ;
# Q 4:
alter table filiere modify LibelléFil varchar(150) not null;
#Q 5
alter table module modify LibelleMod varchar(200) not null;
#Q 6
alter table examen modify DateEX date default '2022-06-15';
#Q 6
alter table etudiant modify TelMobil varchar(10) unique;
alter table etudiant add constraint  unique (TeleFixe);
#Q7
alter table examen add constraint check (NoteEx between 0 and 20);
#Q8
alter table etudiant add constraint check (sexe in ('F','M'));
#alter table etudiant add constraint check (sexe='F'or sexe='M');
#Q9
alter table etudiant add constraint check (TelMobil like '06%');
#Q10
alter table etudiant add constraint check (Email like '%@%');
alter table etudiant drop TeleFixe;
# ............................ partie 2...........................
# Q1
insert into filiere values
('F-1','Génie Informatique'),
('F-2','Génie Elécrique'),
('F-3','Génie Mécanique'),
('F-4','Génie Industriel'),
('F-5','Génie Commerce'),
('F-6','Génie Marketing');
# table module on va pas inserer le numero de module car il est auto increment AI
insert into module (LibelleMod,NbrHeures) values 
('Algorithmique',50),
('Algèbre',30),
('Analyse',30),
('TEC',36),
('Mecanique de Fluide',50),
('Chimie indistruel',40),
('POO',50),
('Base De Données',50);
#delete  from module;
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
#DELETE FROM etudiant WHERE (`codeEt` = 'E-004'); pour supprimer 
#DELETE FROM etudiant WHERE (`codeEt` = 'E-005');
#DELETE FROM etudiant WHERE (`codeEt` = 'E-006');
# la table examen : si on  insere pas  la date d'examen  ,la  date d'examen par defaut va etre inserée automatiquement
insert into examen (CodeEtud,NumMO,NoteEx) values
('E-001',1,15),
('E-002',8,14.25),
('E-003',4,16),
('E-004',7,13.25),
('E-004',6,17),
('E-005',2,12.75),
('E-005',1,8.5);
# bien sur on peut inserer une autre date 
insert into examen values ('E-005',7, '2000-07-10',8.5);
insert into examen values ('E-005',7, '2022-12-10',12.5);# erreur car c'est la meme clé primaire
#................Partie3.....................
#Q 2
update examen set DateEx=DateEx + interval 3 month where NumMO in( 1,2,3,4);
#Q 3
update examen set DateEx=DateEx + interval 3 month +  interval 15 day  
where NumMO in( 6,7,8);
#Q 4
update examen set NoteEx = NoteEx - 2  where  
CodeETud in (select CodeEt from etudiant where sexe='F');


#Q 5
update module set NbrHeures=20 where NumMod not in 
(select distinct NumMO from examen where DateEX between '2022-01-01' and '2022-12-31');
#Q6
update examen set NoteEx=NoteEx+2 where NumMo=1
#jointure
            and   CodeETud in ( select E.codeEt from etudiant E,filiere F  where E.CodeFiliere=F.CodeFil and LibelléFil='Génie Elécrique') ;
#Q7
delete from filiere where CodeFil not in (select  distinct CodeFiliere from etudiant);
#Q8
delete from etudiant where  codeEt not in 
(select distinct CodeETud from examen 
where DateEX between curdate()  - interval 2 year and curdate()+ interval 1 year);
