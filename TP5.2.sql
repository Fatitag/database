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
('P-6','Mathieu','François',NULL,19000);
insert into pilote (PLId,PLNom,PLPrenom,Salaire) values 
('P-7','JHON','MICHEL',19000);
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
#select p.PLNom as Nom, Ville from pilote p;
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
select *from avion where  AVNom in ('A310','A320','A330','A340');
#Q11
select * from avion where AVNom  not in ('A310','A320','A330','A340');
select PLNom as Nom_Pilote from pilote where Salaire  between 20000 and 25000;
select  Capacité from avion where AVType='Airbus';
select  Capacité from avion where AVNom like 'A%';
select  Capacité from avion where AVType Like 'Airbus';
select * from avion where AVNom  not in ('A310','A320','A330','A340');
select * from vol where VILLEDEP='NICE' and  VILLEARR='Paris';
select * from vol where VILLEDEP is not null and HEUREDEP< '20:00:00';
#Q14
select   avg(salaire) as salaire_moy from pilote where  Ville='paris';
#Q15
select count(*) as Nombre_Vol from vol where VILLEDEP='paris';
#Q18 	Trouver le nom des pilotes effectuant des vols au départ de Paris sur des Airbus.
select  P.PLNom    from pilote P, vol V, avion A
where  P.PLId = V.PLId and V.AVId=A.AVId
and V.VILLEDEP='Paris'
and A.AVType='Airbus';
select  distinct P.PLNom  as Nom_pilote  from pilote P
where  P.PLId in ( select V.PLId  from vol V where  V.VILLEDEP='Paris'
and V.AVId in (select A.AVId from avion A where  A.AVType='Airbus')
);
#jointure ensembliste
select  P.PLNom  as Nom_pilote  from pilote P
where  P.PLId in( select V.PLId  from vol V where  V.VILLEDEP='Paris'
and V.AVId in(select A.AVId from avion A where  A.AVType='Airbus')
);
select  P.PLNom   from pilote P inner join  vol V on P.PLId = V.PLId 
inner join  avion A on V.AVId=A.AVId
and V.VILLEDEP='Paris'
and A.AVType='Airbus';
select  P.PLNom  as Nom_pilote  from pilote P  join  vol V on P.PLId = V.PLId 
join  avion A on V.AVId=A.AVId
and V.VILLEDEP='Paris'
and A.AVType='Airbus';
#Q19 19.	Quels sont les avions localisés dans la même ville que l’avion numéro 3.
select  A.* from avion A where A.localisation in( select localisation from avion
 where AVId='A-3');
 select  * from avion where localisation =( select localisation from avion
 where AVId='A-3');
 #Q20 20.	Quels sont les pilotes dont le salaire est plus élevé que le salaire moyen des pilotes ?
select * from pilote  where salaire >  (select avg(salaire) from pilote);
#Q21 21.	Quels sont les noms des pilotes en service au départ de Paris ?
select distinct P.PLNom from pilote P, vol V
where P.PLId=V.PLId and V.VILLEDEP='Paris';
select distinct P.PLNom from pilote P inner join  vol V on P.PLId=V.PLId where V.VILLEDEP='Paris';
#Q22 22.	Quels sont les noms des pilotes niçois qui gagnent plus que tous les pilotes parisiens ?
select distinct PLNom from pilote where 
ville='Nice' and
salaire > ( select max(salaire) from pilote where ville='paris');
select distinct PLNom from pilote 
where ville='Nice'
and salaire >  all ( select salaire from pilote where ville='paris');
#Q23.	Donner le nom des pilotes niçois qui gagnent plus qu’au moins un pilote parisien.
select distinct P.PLNom from Pilote P 
where P.ville='Nice' 
and salaire > ( select min(salaire) from pilote where ville='paris');
select distinct P.PLNom from Pilote P 
where P.ville='Nice' 
and salaire > any( select salaire from pilote where ville='paris');
#Q24.	Rechercher les pilotes ayant même adresse et même salaire que André.
select P.* from pilote P 
where P.salaire=(select P.salaire from pilote P where P.PLNom='André')
and P.ville=(select P.ville from pilote P where P.PLNom='André'); 
#pour ne pas afficher les information de André
select P.* from pilote P 
where P.salaire=(select P.salaire from pilote P where P.PLNom='André')
and P.ville=(select P.ville from pilote P where P.PLNom='André')
and P.PLNom not like'André'; 

#Q25.	Donner la liste des pilotes parisiens par ordre de salaire décroissant puis par ordre alphabétique des noms.
select P.* from pilote P
where P.ville='Paris' 
order by P.salaire desc, P.PLNom asc;

#Q26.	Donner la liste des  pilotes  qui ont les trois premiers salaires
select P.* from pilote P
order by P.salaire desc limit 3 ;
#Q27 	Quel est le nombre de vols effectués par chacun des pilotes ?
select   V.PLId ,count(*) from vol V 
group by V.PLId;
select   P.PLNom as 'Nom pilote' ,count(*)  as ' nombre de vol' from vol V, pilote P 
where P.PLId=V.PLId 
group by P.PLID;
select   P.PLNom ,count(*)   from vol V, pilote P
where P.PLId=V.PLId 
group by P.PLNom;
select   P.PLNom ,count(*)   from vol V join pilote P
on P.PLId=V.PLId 
group by  P.PLId,P.PLNom;#pour ne pas avoir une confusion si on a deux pilote de meme nom
# Q28 Trouver le nombre de vols par pilote et par avion.
select   V.PLId ,count(*),V.AVId from vol V 
group by V.PLId, V.AVId;
#si on veut afficher les noms
select  distinct P.PLNom ,A.AVNom,count(*)   from vol V, pilote P,Avion A
where P.PLId=V.PLId  and V.AVId=A.AVId
group by P.PLNom,A.AVNom;












