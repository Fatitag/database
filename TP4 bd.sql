create database if not exists Gestion_pilotes;
use Gestion_pilotes;
create table Pilote(
PLId varchar(25) primary key,
PLNom varchar(20) not null,
PLPrenom varchar(20) not null,
Ville varchar(20) ,
Salaire decimal (8,2)
);
create table Avion(
AVId varchar(25) primary key,
AVNom varchar(20) not null,
AVType varchar(20) not null,
Capacité int not null,
localisation varchar(20) not null
);
create table vol(
VOLNum int auto_increment primary key,
PLId varchar(25),
AVId varchar(25),
VILLEDEP varchar(20) ,
VILLEARR varchar(20) ,
JourDep date not null,
JourAr date not null,
HEUREDEP time not null,
HEUREARR time not null,
foreign key (PLId) references pilote(PLId) on update cascade on delete set null ,
foreign key (AVId) references avion(AVId) on update cascade on delete set null 
);
insert into  pilote values 
('P-1','Dupuis','Antoine','Paris',20000),
('P-2','Simon','Georges','Nice',25000),
('P-3','François','Luc','Marseille',18000),
('P-4','André','Georges','Lyon',30000),
('P-5','Arthur','Louis','Paris',23000),
('P-6','Mathieu','François','Nice',19000),
('P-7','Mathieu','François',NULL,19000);
insert into pilote (PLId,PLNom,PLPrenom,Salaire) values 
('P-8','JHON','MICHEL',19000);
insert into  avion values 
('A-1','A310','Airbus','400','Paris'),
('A-2','A319','Airbus','320','Nice'),
('A-3','A320','Airbus','280','Paris'),
('A-4','A330','Airbus','300','Paris'),
('A-5','A340','Airbus','290','Lyon'),
('A-6','ART42','ART','420','Nice'),
('A-7','ART72','ART','300','Nice'),
('A-8','Boeing 737','Boeing','300','Nice');
insert into vol  (PLId,AVId,VILLEDEP,VILLEARR, JourDep,HEUREDEP,JourAr,HEUREARR) values 
('P-1','A-1','Paris','Madrid','2022-07-14','20:00:00','2022-07-15',' 05:00:00'),
('P-1','A-3','Paris','casablanca','2022-09-10', '17:30:00','2022-09-10',' 23:00:00'),
('P-4','A-4','Lyon','Londre','2022-07-14','20:00:00','2022-07-15',' 05:00:00'),
('P-3','A-7','Nice','Paris','2022-07-14', '20:00:00','2022-07-15',' 05:00:00'),
('P-6','A-2','Paris','Madrid','2022-07-14','20:00:00','2022-07-15',' 05:00:00');
#Q3
select  * from pilote ;
#Q4
#select p.PLNom as 'Nom pilote', Ville as ' ville pilote' from pilote p;
select PLNom,ville from pilote;
#q5
select PLId as identificateur , PLNom as Nom from pilote;
#Q6
# as alea d'atribut
select VILLEDEP as ville_de_départ from vol;
#Q7
select PLNom  'Nom_Pilote' from pilote where ville='paris';
#select PLNom as Nom_Pilote from pilote where ville='paris';
#Q8
select PLNom as Nom_Pilote from pilote where Salaire>25000;
#Q9
select PLNom from pilote where ville is null;
#Q10
select * from avion where AVNom in ('A310','A320','A330','A340');
#Q11
select PLNom as Nom_Pilote from pilote where Salaire  between 20000 and 25000;
#Q12
select  capacité from avion where AVType='Airbus';
#ou bien 
select * from avion where AVNom like 'A%';
#Q13 
select * from avion where AVNom  not in ('A310','A320','A330','A340');
#Q14
select * from vol where VILLEDEP='NICE' and  VILLEARR='Paris';
#Q15
select * from vol where VILLEDEP is not null and HEUREDEP< '20:00:00';
#Q16
select   avg(salaire) as salaire_moy from pilote where  Ville='paris';
#Q17
select count(*) as Nombre_Vol from vol where VILLEDEP='paris';