use tienda;
----------------------------------------------------

--
-- Estructura de tabla para la tabla `boleta`
--

CREATE TABLE boleta (
  num_bol varchar(8) NOT NULL,
  cod_cli varchar(6) NOT NULL foreign KEY references client(cod_cli),
  pre_tot varchar(10) NOT NULL,
  fecha varchar(15) NOT NULL,
  PRIMARY KEY (num_bol),
  
);



-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE client (
	
  cod_cli varchar(6) NOT NULL,
 nom_cli varchar(30) NOT NULL,
  ape_cli varchar(30) NOT NULL,
  sexo_cli varchar(1) NOT NULL,
  dni_cli varchar(8) NOT NULL,
  tel_cli varchar(9) NOT NULL,
  ruc_cli varchar(11) NOT NULL,
  email_cli varchar(30) NOT NULL,
  dir_cli varchar(30) NOT NULL,
  PRIMARY KEY (cod_cli)
) 
select *from client

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleboleta`
--

CREATE TABLE detalleboleta(
  num_bol varchar(8) NOT NULL foreign KEY references boleta(num_bol),
  cod_pro varchar(6) NOT NULL foreign KEY references producto(cod_pro),
  des_pro varchar(30) NOT NULL,
  cant_pro varchar(3) NOT NULL,
  pre_unit varchar(10) NOT NULL,
  pre_venta varchar(10) NOT NULL
) 

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallefactura`
--

CREATE TABLE detallefactura(
 num_fac varchar(8) NOT NULL foreign key references factura(num_fac),
  cod_pro varchar(6) NOT NULL foreign KEY references producto(cod_pro),
  des_pro varchar(30) NOT NULL,
  cant_pro varchar(3) NOT NULL,
  pre_unit varchar(10) NOT NULL,
  pre_tot varchar(10) NOT NULL
) 

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE factura (
  num_fac varchar(8) NOT NULL,
  cod_cli varchar(6) NOT NULL foreign key references  client(cod_cli),
  ruc_cli varchar(11) NOT NULL,
  subtotal varchar(10) NOT NULL,
  igv varchar(40) NOT NULL,
  total varchar(20) NOT NULL,
  fec_fac varchar(20) NOT NULL,
  PRIMARY KEY (num_fac),
  
) 

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--
drop table producto
CREATE TABLE producto (
  cod_pro varchar(6) NOT NULL,
  descripcion varchar(30) NOT NULL,
  precio varchar(10) NOT NULL,
  Stock varchar(10) NOT NULL,
  PRIMARY KEY (cod_pro)
) 
select * from client 
--
create procedure spProducto
 @cod_pro varchar(6),
  @descripcion varchar(30),
  @precio varchar(10),
  @Stock varchar(10)
as
insert into producto(cod_pro,descripcion,precio,Stock) values(@cod_pro,@descripcion,@precio,@Stock);
--

--
-- Filtros para la tabla `boleta`
--
ALTER TABLE boleta
  ADD CONSTRAINT boleta_ibfk_1 FOREIGN KEY (cod_cli) REFERENCES cliente (cod_cli) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalleboleta`
--
ALTER TABLE detalleboleta
  ADD CONSTRAINT detalleboleta_ibfk_1 FOREIGN KEY (num_bol) REFERENCES boleta (num_bol) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT detalleboleta_ibfk_2 FOREIGN KEY (cod_pro) REFERENCES producto (cod_pro) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detallefactura`
--
ALTER TABLE detallefactura
  ADD CONSTRAINT detallefactura_ibfk_1 FOREIGN KEY (num_fac) REFERENCES factura (num_fac) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT detallefactura_ibfk_2 FOREIGN KEY (cod_pro) REFERENCES producto (cod_pro) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `factura`
--
ALTER TABLE factura
  ADD CONSTRAINT factura_ibfk_1 FOREIGN KEY (cod_cli) REFERENCES cliente (cod_cli) ON DELETE CASCADE ON UPDATE CASCADE;
  /*******************************************
  PROCEDIMIENTOS ALMACENADOS*/
  /*CLIENTE*/
  create  procedure spCLient
  (
  @cod_cli varchar(6),
  @nom_cli varchar(30),
  @ape_cli varchar(30),
  @sexo_cli varchar(1),
  @dni_cli varchar(8),
  @tel_cli varchar(9),
  @ruc_cli varchar(11),
  @email_cli varchar(30),
  @dir_cli varchar(30) 
  )
  as
  insert into client(cod_cli,nom_cli,ape_cli,sexo_cli,dni_cli,tel_cli,ruc_cli,email_cli,dir_cli) values (@cod_cli,@nom_cli,@ape_cli,@sexo_cli,@dni_cli,@tel_cli,@ruc_cli,@email_cli,@dir_cli);

  EXEC spCLient'CC0010','diego','maradona','M','75155655','87558544','00000000','diego.es@gmail.com','argentina'
GO
/**************************************************************/
create proc consulclient
as 
select * from client 
where cod_cli = 'CC0001'

exec consulclient
/*****************************************************************/
create procedure actualizaProdu1
  @cod_cli varchar(6),
 @nom_cli varchar(30),
  @ape_cli varchar(30),
  @sexo_cli varchar(1),
  @dni_cli varchar(8),
  @tel_cli varchar(9),
  @ruc_cli varchar(11),
  @email_cli varchar(30),
  @dir_cli varchar(30) 
as 
begin
update client set nom_cli=@nom_cli,ape_cli=@ape_cli,sexo_cli=@sexo_cli,dni_cli=@dni_cli,tel_cli=@tel_cli,ruc_cli=@ruc_cli,email_cli=@email_cli,dir_cli=@dir_cli
where cod_cli=@cod_cli
end
go
exec actualizaProdu1'CC0010','diego','maradona','M','75155655','87558544','00000000','diego.es@gmail.com','peru'
/***************************************************************/
create procedure edclient
as 
select * from client
where
nom_cli <> 'I'
UPDATE 
 set nom_cli = 'I'
end
/***************************************************************/
/*************************BOLETA*******************************/
CREATE PROCEDURE insrboleta
  @num_bol varchar(8),
  @cod_cli varchar(6), 
  @pre_tot varchar(10),
  @fecha varchar(15)
  as 
  insert into boleta(num_bol,cod_cli,pre_tot,fecha) values (@num_bol,@cod_cli,@pre_tot,@fecha)
  select * from boleta
  exec insrboleta '00000009','CC0009','15.02','18/08/2018'
  /*******************************************************************/
  create procedure consultboleta
  as 
  select * from boleta
  where num_bol='00000003'

  exec consultboleta
  /*********************************************************************/
  create procedure actuboleta
    @num_bol varchar(8),
  @cod_cli varchar(6), 
  @pre_tot varchar(10),
  @fecha varchar(15)
  as 
  begin
  update boleta set num_bol=@num_bol,cod_cli=@cod_cli,pre_tot=@pre_tot,fecha=@fecha
 where num_bol=@num_bol
end
go

exec actuboleta '00000001','CC0001','15.0','15/08/18'
/*************************************************************************/
/*************************************************************************/
/*************************************************************************/
/********DETALLEBOLETA***************/
create procedure inserDetalebol
  @num_bol varchar(8),
  @cod_pro varchar(6),
  @des_pro varchar(30),
  @cant_pro varchar(3),
  @pre_unit varchar(10),
  @pre_venta varchar(10)
  as
  insert into detalleboleta(num_bol,cod_pro,des_pro,cant_pro,pre_unit,pre_venta) values (@num_bol,@cod_pro,@des_pro,@cant_pro,@pre_unit,@pre_venta)
  select * from detalleboleta
  exec inserDetalebol '00000006','CP0003','nastiflu','100','0.50','200'
  /*******************************************************************/
   create procedure consultdetallboleta
  as 
  select * from detalleboleta
  where num_bol='00000003'

  exec consultboleta
  /**********************************************************************/
    create procedure actudetalleboleta
    @num_bol varchar(8),
   @cod_pro varchar(6),
  @des_pro varchar(30),
  @cant_pro varchar(3),
  @pre_unit varchar(10),
  @pre_venta varchar(10)
  as 
  begin
  update detalleboleta set num_bol=@num_bol,cod_pro=@cod_pro,des_pro=@des_pro,cant_pro=@cant_pro,pre_unit=@pre_unit,pre_venta=@pre_venta
 where num_bol=@num_bol
end
go

exec actudetalleboleta '00000006','CP0003','nastiflu','100','0.50','208'
/***********************************************************************/
/***********************************************************************/
/************DETALLEFACTURA**********************************************/
CREATE PROCEDURE insdetallefac
 @num_fac varchar(8),
  @cod_pro varchar(6),
  @des_pro varchar(30),
  @cant_pro varchar(3),
  @pre_unit varchar(10),
    @pre_tot varchar(10)
	as
	insert into detallefactura(num_fac,cod_pro,des_pro,cant_pro,pre_unit,pre_tot) values (@num_fac,@cod_pro,@des_pro,@cant_pro,@pre_unit,@pre_tot)
select * from detallefactura
exec insdetallefac '00000003','CP0004','APRONAX','88','80','50.0'
/*************************************************************************/
create procedure seledetallfact
as
select * from detallefactura
where num_fac='00000001'
exec seledetallfact
/**************************************************************************/
create procedure upddetallefac
 @num_fac varchar(8),
  @cod_pro varchar(6),
  @des_pro varchar(30),
  @cant_pro varchar(3),
  @pre_unit varchar(10),
    @pre_tot varchar(10)
	as
	begin
	update detallefactura set num_fac=@num_fac,cod_pro=@cod_pro,des_pro=@des_pro,cant_pro=@cant_pro,pre_unit=@pre_unit,pre_tot=@pre_tot
	where num_fac=@num_fac
	end
	go
	exec upddetallefac '00000001','CP0003','nastiflu','8','8','50.0'
	/*************************************************************************/
	/*************************************************************************/
	/*************************************************************************/
	/*********************FACTURA********************************************/
CREATE PROCEDURE SPFACTURA
 @num_fac varchar(8),
  @cod_cli varchar(6),
  @ruc_cli varchar(11),
  @subtotal varchar(10),
  @igv varchar(40),
  @total varchar(20),
  @fec_fac varchar(20)
  as
  insert into factura(num_fac,cod_cli,ruc_cli,subtotal,igv,total,fec_fac) values (@num_fac,@cod_cli,@ruc_cli,@subtotal,@igv,@total,@fec_fac)
  select * from factura
  exec SPFACTURA'00000003','CC0003','111111111','85.0','8.3','50.0','18/05/18'
  /******************************************************************************/
  create procedure SPFACTURA1
as
select * from factura
where num_fac='00000001'
exec SPFACTURA1
/*************************************************************************************/
CREATE PROCEDURE SP_FACTURA
 @num_fac varchar(8),
  @cod_cli varchar(6),
  @ruc_cli varchar(11),
  @subtotal varchar(10),
  @igv varchar(40),
  @total varchar(20),
  @fec_fac varchar(20)
  AS
  BEGIN
  UPDATE factura set num_fac=@num_fac,cod_cli=@cod_cli,ruc_cli=@ruc_cli,subtotal=@subtotal,igv=@igv,total=@total,fec_fac=@fec_fac
  where num_fac=@num_fac
	end
	go
	EXEC SP_FACTURA '00000001','CC0003','1444411111','85.0','8.3','50.0','18/05/18'