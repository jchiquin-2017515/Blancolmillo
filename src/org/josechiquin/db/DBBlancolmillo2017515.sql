Drop database if exists DBBlancolmillo2017515;
Create database DBBlancolmillo2017515;

Use DBBlancolmillo2017515;

Create table Pacientes(
	codigoPaciente int not null,
    nombresPaciente varchar(50) not null,
    apellidosPaciente varchar(50) not null,
    sexo char not null,
    fechaNacimiento date not null,
    direccionPaciente varchar(100) not null,
    telefonoPersonal varchar(8) not null,
    fechaPrimeraVisita date,
    primary key PK_codigoPaciente (codigoPaciente)
);

Create table Especialidades(
	codigoEspecialidad int not null auto_increment,
    descripcion varchar(100) not null,
    primary key PK_codigoEspecialidad (codigoEspecialidad)
);

Create table Medicamentos(
	codigoMedicamento int not null auto_increment,
    nombreMedicamento varchar(100) not null,
    primary key PK_codigoMedicamento (codigoMedicamento)
);

Create table Doctores(
	numeroColegiado int not null,
    nombresDoctor varchar(50) not null,
    apellidosDoctor varchar(50) not null,
    telefonoContacto varchar(8) not null,
    codigoEspecialidad int not null,
    primary key PK_numeroColegiado (numeroColegiado),
    constraint FK_Doctores_Especialidades foreign key (codigoEspecialidad)
		references Especialidades (codigoEspecialidad)
);

Create table Recetas(
	codigoReceta int not null auto_increment,
    fechaReceta date not null,
    numeroColegiado int not null,
    primary key PK_codigoReceta (codigoReceta),
    constraint FK_Recetas_Doctores foreign key (numeroColegiado)
		references Doctores (numeroColegiado)
);

Create table Citas(
	codigoCita int not null auto_increment,
    fechaCita date not null,
    horaCita time not null,
    tratamiento varchar(150),
    descripCondActual varchar(255) not null,
    codigoPaciente int not null,
    numeroColegiado int not null,
    primary key PK_codigoCita (codigoCita),
    constraint FK_Citas_Pacientes foreign key (codigoPaciente)
		references Pacientes (codigoPaciente),
	constraint FK_Citas_Doctores foreign key (numeroColegiado)
		references Doctores (numeroColegiado)
);

Create table DetalleReceta(
	codigoDetalleReceta int not null auto_increment,
    dosis varchar(100) not null,
    codigoReceta int not null,
    codigoMedicamento int not null,
    primary key PK_codigoDetalleReceta (codigoDetalleReceta),
    constraint FK_DetalleReceta_Recetas foreign key (codigoReceta)
		references Recetas (codigoReceta),
	constraint FK_DetalleReceta_Medicamentos foreign key (codigoMedicamento)
		references Medicamentos (codigoMedicamento)
);

-- --------------------------------------------------------------------------------------------------
-- -------------------------------- PROCEDIMIENTOS ALMACENADOS --------------------------------------

-- -------------------------------- PACIENTES --------------------------------------
-- -------------------------------- Agregar Paciente --------------------------------------
Delimiter $$
	Create procedure sp_AgregarPaciente (in codigoPaciente int, in nombresPaciente varchar (50), in apellidosPaciente varchar(50), in sexo 
		char, in fechaNacimiento date, in direccionPaciente varchar(100), telefonoPersonal varchar(8), in fechaPrimeraVisita date) 
        Begin
			Insert into Pacientes (codigoPaciente, nombresPaciente, apellidosPaciente, sexo,
			fechaNacimiento ,direccionPaciente, telefonoPersonal, fechaPrimeraVisita)
			values (codigoPaciente, nombresPaciente, apellidosPaciente, upper(sexo),
			fechaNacimiento ,direccionPaciente, telefonoPersonal, fechaPrimeraVisita);
        End$$
Delimiter ;

call sp_AgregarPaciente(1002, 'Jose Daniel', 'Chiquin Montenegro', 'm', '2004-05-28', 'San Jose Pinula', '51693605', now());
-- -------------------------------- Listar Paciente --------------------------------------
Delimiter $$
	Create procedure sp_ListarPacientes()
		Begin 
			Select
				P.codigoPaciente,
				P.nombresPaciente,
				P.apellidosPaciente,
				P.sexo,
				P.fechaNacimiento,
				P.direccionPaciente,
				P.telefonoPersonal,
				P.fechaPrimeraVisita
            From Pacientes P;
		End$$
Delimiter ;

call sp_ListarPacientes();
-- -------------------------------- Buscar Paciente --------------------------------------
Delimiter $$
	Create procedure sp_BuscarPaciente(in codPaciente int)
		Begin
			Select 
				P.codigoPaciente,
				P.nombresPaciente,
				P.apellidosPaciente,
				P.sexo,
				P.fechaNacimiento,
				P.direccionPaciente,
				P.telefonoPersonal,
				P.fechaPrimeraVisita
            from Pacientes P
				where codigoPaciente = codPaciente;
		End$$
Delimiter ;

call sp_BuscarPaciente(1001);
-- -------------------------------- Eliminar Paciente --------------------------------------
Delimiter $$
	Create procedure sp_EliminarPaciente (in codPaciente int)
		Begin
			delete from Pacientes 
				where codigoPaciente = codPaciente;
		End$$
Delimiter ;

call sp_EliminarPaciente(1001);
call sp_ListarPacientes();
-- -------------------------------- Editar Paciente --------------------------------------
Delimiter $$
	Create procedure sp_EditarPaciente(in codPaciente int, in nombPaciente varchar(50), in apPaciente varchar(50),
		in sx char, in fechaNac date, in dirPaciente varchar(100),in telPersonal varchar(8),in fechaPV date)
        Begin 
			Update Pacientes P
				set
				P.nombresPaciente = nombPaciente,
				P.apellidosPaciente = apPaciente,
				P.sexo = sx,
				P.fechaNacimiento = fechaNac,
				P.direccionPaciente = dirPaciente,
				P.telefonoPersonal = telPersonal,
				P.fechaPrimeraVisita = fechaPV
                where codigoPaciente = codPaciente;
		End$$
Delimiter ;

call sp_EditarPaciente(1001,'Jose Daniel', 'Chiquin Montenegro', 'm', '2004-05-28', 'C San Jose Pinula', '51693605', now());
call sp_ListarPacientes();
-- -------------------------------- ESPECIALIDADES --------------------------------------
-- -------------------------------- Agregar Especialidad --------------------------------------
Delimiter $$
	Create procedure sp_AgregarEspecialidad(in descripcion varchar(100))
        Begin
			Insert into Especialidades (descripcion)
			values (descripcion);
        End$$
Delimiter ;

call sp_AgregarEspecialidad('Cardiólogo');
call sp_AgregarEspecialidad('Dermatología');
call sp_AgregarEspecialidad('Gastroenterelogía');
-- -------------------------------- Listar Especialidades --------------------------------------
Delimiter $$
	Create procedure sp_ListarEspecialidades()
		Begin 
			Select
				E.codigoEspecialidad,
                E.descripcion
            From Especialidades E;
		End$$
Delimiter ;

call sp_ListarEspecialidades();
-- -------------------------------- Buscar Especialidad --------------------------------------
Delimiter $$
	Create procedure sp_BuscarEspecialidad(in codEspecialidad int)
		Begin
			Select 
				E.codigoEspecialidad,
                E.descripcion
            from Especialidades E
				where codigoEspecialidad = codEspecialidad;
		End$$
Delimiter ;

call sp_BuscarEspecialidad(1);
-- -------------------------------- Eliminar Especialidad --------------------------------------
Delimiter $$
	Create procedure sp_EliminarEspecialidad(in codEspecialidad int)
		Begin
			delete from Especialidades 
				where codigoEspecialidad = codEspecialidad;
		End$$
Delimiter ;


-- -------------------------------- Editar Especialidad --------------------------------------
Delimiter $$
	Create procedure sp_EditarEspecialidad(in codEspecialidad int, in descrip varchar(50))
        Begin 
			Update Especialidades E
				set 
                E.descripcion = descrip
                where E.codigoEspecialidad = codEspecialidad;
		End$$
Delimiter ;


-- -------------------------------- MEDICAMENTOS --------------------------------------
-- -------------------------------- Agregar Medicamento --------------------------------------
Delimiter $$
	Create procedure sp_AgregarMedicamento(in nombreMedicamento varchar(100)) 
        Begin
			Insert into Medicamentos (nombreMedicamento)
			values (nombreMedicamento);
        End$$
Delimiter ;

call sp_AgregarMedicamento('Ibuprofeno');
-- -------------------------------- Listar Medicamento --------------------------------------
Delimiter $$
	Create procedure sp_ListarMedicamentos()
		Begin 
			Select
				M.codigoMedicamento,
                M.nombreMedicamento
            From Medicamentos M;
		End$$
Delimiter ;

call sp_ListarMedicamentos();
-- -------------------------------- Buscar Medicamento --------------------------------------
Delimiter $$
	Create procedure sp_BuscarMedicamento(in codMedicamento int)
		Begin
			Select 
				M.codigoMedicamento,
                M.nombreMedicamento
            from Medicamentos M
				where codigoMedicamento = codMedicamento;
		End$$
Delimiter ;

call sp_BuscarMedicamento(1);
-- -------------------------------- Eliminar Medicamento --------------------------------------
Delimiter $$
	Create procedure sp_EliminarMedicamento (in codMedicamento int)
		Begin
			delete from Medicamentos 
				where codigoMedicamento = codMedicamento;
		End$$
Delimiter ;


-- -------------------------------- Editar Medicamento --------------------------------------
Delimiter $$
	Create procedure sp_EditarMedicamento(in codMedicamento int, in nombMedicamento varchar(50))
        Begin 
			Update Medicamentos M
				set
                M.nombreMedicamento = nombMedicamento
                where M.codigoMedicamento = codMedicamento;
		End$$
Delimiter ;

-- -------------------------------- DOCTORES --------------------------------------
-- -------------------------------- Agregar Doctor --------------------------------------
Delimiter $$
	Create procedure sp_AgregarDoctor(in numeroColegiado int, in nombresDoctor varchar(50), in apellidosDoctor varchar(50),
    in telefonoContacto varchar(8), in codigoEspecialidad int) 
        Begin
			Insert into Doctores (numeroColegiado,nombresDoctor,apellidosDoctor,telefonoContacto,codigoEspecialidad)
			values (numeroColegiado,nombresDoctor,apellidosDoctor,telefonoContacto,codigoEspecialidad);
        End$$
Delimiter ;

call sp_AgregarDoctor(135791, 'Estuardo José', 'Pérez López', '23456789', 1);
-- -------------------------------- Listar Doctores --------------------------------------
Delimiter $$
	Create procedure sp_ListarDoctores()
		Begin 
			Select
				D.numeroColegiado,
                D.nombresDoctor,
                D.apellidosDoctor,
                D.telefonoContacto,
                D.codigoEspecialidad
            From Doctores D;
		End$$
Delimiter ;

call sp_ListarDoctores();
-- -------------------------------- Buscar Doctor --------------------------------------
Delimiter $$
	Create procedure sp_BuscarDoctor(in numCole int)
		Begin
			Select 
				D.numeroColegiado,
                D.nombresDoctor,
                D.apellidosDoctor,
                D.telefonoContacto,
                D.codigoEspecialidad
            from Doctores D
				where numeroColegiado = numCole;
		End$$
Delimiter ;

call sp_BuscarDoctor(135791);
-- -------------------------------- Eliminar Doctor --------------------------------------
Delimiter $$
	Create procedure sp_EliminarDoctor (in numCole int)
		Begin
			delete from Doctores 
				where numeroColegiado = numCole;
		End$$
Delimiter ;


-- -------------------------------- Editar Doctor --------------------------------------
Delimiter $$
	Create procedure sp_EditarDoctor(in numCole int, in nombDoc varchar(50), in apeDoc varchar(50), in teleCon varchar(8))
        Begin 
			Update Doctores D
				set
                D.nombresDoctor = nomDoc,
                D.apellidosDoctor = apeDoc,
                D.telefonoContacto = teleCon
                where D.numeroColegiado = numCole;
		End$$
Delimiter ;