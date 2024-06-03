create database Db_CDS;
use Db_CDS;

create table Tb_Artista( /*1*/
	Cod_Art int not null,
    Nome_Art varchar(100) not null unique, /*Aceita numeros e letras*/
    constraint Pk_Cod_Art primary key (Cod_Art) /*Primary key*/
    );
    
create table Tb_Gravadora( /*2*/
	Cod_Grav int not null, /*PK*/
    Nome_Grav varchar(50) not null unique, 
    constraint Pk_Cod_Grav primary key (Cod_Grav)
    );    
    
create table Tb_Categoria( /*3*/
	Cod_Cat int not null, /*PK*/
    Nome_Cat varchar(50) not null unique, 
    constraint Pk_Cod_Cat primary key (Cod_Cat)
    );    
    
create table Tb_Estado( /*4*/
	Sigla_Est varchar(2) not null /*PK*/,
    Nome_Est varchar(50) not null unique, 
    constraint Pk_Sigla_Est primary key (Sigla_Est)
    );
    
drop table Tb_Estado;

create table Tb_Cidade( /*5*/
	Cod_Cid int not null /*PK*/,
    Nome_cid varchar(100) not null,
    Fk_Sigla_Est varchar(2) not null,
    constraint Pk_Cod_Cid primary key (Cod_Cid),
	constraint Fk_Sigla_Est foreign key (Fk_Sigla_Est) references Tb_Estado (Sigla_Est)
    ); 
    
create table Tb_Cliente( /*6*/
	Cod_Cli int not null /*PK*/,
    Nome_Cliente varchar(100) not null,
    End_Cli varchar(200) not null,
    Renda_Cli decimal(10,2) not null default 0 check (Renda_Cli >= 0),
    Sexo_Cli enum ('M', 'F') default 'F',
    Fk_Cod_Cid int not null,
    constraint Pk_Cod_Cli primary key (Cod_Cli),
    constraint Fk_Cod_Cid foreign key (Fk_Cod_Cid) references Tb_Cidade (Cod_Cid)
    ); 
    
create table tb_Conjuge( /*7*/
		Cod_Cli int not null,
		primary key (Cod_Cli),
		foreign key (Cod_Cli) references tb_Cliente (Cod_Cli),
        Nome_Conj varchar(100) not null,
        Renda_Conj decimal(10,2) not null default 0 check (Renda_Conj >= 0),
        Sexo_Conj char(1) not null default 'F' check (Sexo_Conj in ('F', 'M'))
   );

    
create table Tb_Funcionario( /*8*/
	Cod_Func int not null /*PK*/,
    Nome_Func varchar(100) not null,
    End_Func varchar(200) not null,
    Sal_Func decimal(10,2) not null default 0 check (Sal_Func >=0),
    Sexo_Conj enum ('M', 'F') default 'M',
    constraint Pk_Cod_Func primary key (Cod_Func)
    );
    
create table Tb_Dependente (
	Cod_Dep int not null /*PK*/,
    Fk_Cod_Func int not null /*FK*/,
    Nome_Dep varchar(100) not null,
    Sexo_Dep enum('F', 'M') default 'M',
    constraint Pk_Cod_Dep primary key (Cod_Dep),
    constraint Fk_Cod_Func foreign key (Fk_Cod_Func) references Tb_Funcionario (Cod_Func)
);

create table Tb_Titulo (
	Cod_Tit int not null /*PK*/,
    Fk_Cod_Cat int not null /*FK*/,
    Fk_Cod_Grav int not null,
    Nome_CD varchar(100) not null unique,
    Val_CD decimal(10,2) not null check (Val_CD > 0),
    Qtd_Estq int not null check (Qtd_Estq >=0),
    constraint Pk_Cod_Tit primary key (Cod_Tit),
    constraint Fk_Cod_Cat foreign key (Fk_Cod_Cat) references Tb_Categoria (Cod_Cat),
    constraint Fk_Cod_Grav foreign key (Fk_Cod_Grav) references Tb_Gravadora (Cod_Grav)
);

create table Tb_Pedido (
	Num_Ped int not null /*PK*/,
    Fk_Cod_Cli int not null /*FK*/,
    Cod_Func int not null /*FK*/,
    Data_Ped datetime not null,
    Val_Ped decimal (10,2) not null check (Val_Ped >=0) default 0,
    constraint Pk_Num_Ped primary key (Num_Ped),
    constraint Fk_Cod_Cli foreign key (Fk_Cod_Cli) references Tb_Cliente (Cod_Cli),
	constraint Cod_Func foreign key (Cod_Func) references Tb_Funcionario (Cod_Func)
);

create table Titulo_Pedido (
	Fk_Num_Ped int not null /*FK*/,
    Fk_Cod_Tit int not null /*FK*/,
    Qtd_CD int not null check (Qtd_CD >=1),
    Val_CD decimal(10,2) not null check (Val_CD >0)
);

create table Tb_Titulo_Artista (
	Fk_Cod_Tit int not null /*FK*/,
    Fk_Cod_Art int not null /*FK*/,
    constraint Fk_Cod_Tit foreign key (Fk_Cod_Tit) references Tb_Titulo (Cod_Tit),
    constraint Fk_Cod_Art foreign key (Fk_Cod_Art) references Tb_Artista (Cod_Art)
);


