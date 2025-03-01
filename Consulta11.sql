Consulta 11
- Listar el nombre de los encargados regionales (usando la tabla Sales.Person)
alter procedure name_encargados  as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @sql nvarchar(1000);
	declare @sql1 nvarchar(1000);
	declare @sqlt nvarchar(1000);
	declare @condicion varchar(200);

	declare @i int = 0;
	set @condicion =' where BusinessEntityID between 274 and 290';
	set  @nom_tabla='Person';

	while @i<2
	begin
		set @i = @i+1;
		select @servidor = servidor, @nom_bd = bd from diccionario_dist where id_fragmento = @i;
		
		if @servidor='LSERVER1'
		begin
			--print N'Aquí va la consulta para SQL Server'
			set @sql1 ='select * from openquery ('+ 
			@servidor + 
			',''Select Person.Person.FirstName, Person.Person.MiddleName, Person.Person.LastName ' + 
			'from '+
			@nom_bd + 
			'.Person.'+ 
			@nom_tabla + 
			@condicion;

		end
		else
			set @sql = 'Select Person.Person.FirstName, Person.Person.MiddleName, Person.Person.LastName ' + 
			' from '+
			@servidor + '.' + 
			@nom_bd + '.Person.'+ 
			@nom_tabla + 
			@condicion;
		
		set @sqlt = ''+@sql +' union '+ @sql1;
		exec sp_executesql @sqlt
		end 
end

exec name_encargados;
