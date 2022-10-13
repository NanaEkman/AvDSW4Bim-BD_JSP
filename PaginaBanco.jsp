<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<title>Registro de animais adotados</title>
</head>
<body>

<%
//============ Escolher operação (INSERT, SELECT, UPDATE, DELETE) ============
String operacao = "SELECT";

String banco, usuario, senha;

Connection conexao = null;
PreparedStatement cmd = null;
ResultSet rs;

int id;
String nome, cpf, raca, data;
double peso;


try{
	
	banco = "jdbc:mysql://localhost/registro_adocao";
	usuario = "root";
	senha = "";
	
	Class.forName("com.mysql.jdbc.Driver");
	
	conexao = DriverManager.getConnection(banco, usuario, senha);
	
} catch(Exception ex) {
	out.print("Erro: "+ ex.getMessage());
	return;
}

if(operacao.equals("INSERT")) {
	
	try{
		
		//============ Preencher as informações ============
		nome = "miau"; 
		raca = "vira-lata";
		peso = 8.5;
		cpf = "123.456.789-00";
		data = "2022-10-13";
		
		cmd = conexao.prepareStatement("INSERT INTO adocao(nome, raca, peso, cpf, data) VALUES('"+ nome +"', '"+ raca +"', "+ peso +", '"+ cpf +"', '"+ data +"')");
		
		cmd.executeUpdate();
		
		out.println("Inserção efetuada com sucesso!");
		
	} catch(Exception ex) {
		out.print("Erro: "+ ex.getMessage());
		return;
	}
	
} else if(operacao.equals("SELECT")) {

	%>

	<table class="table table-hover table-dark">
	  <thead>
	    <tr>
	      <th scope="col">#</th>
	      <th scope="col">Nome</th>
	      <th scope="col">Raça</th>
	      <th scope="col">Peso</th>
	      <th scope="col">CPF do dono</th>
	      <th scope="col">Data de adoção</th>
	    </tr>
	  </thead>
	  <tbody>

	<%
	
	try{
		
		cmd = conexao.prepareStatement("SELECT * FROM adocao");
		
		rs = cmd.executeQuery();
		
		if(rs.next()){
			
			do {				
				%>				
			    <tr>
			      <% //id
			      out.print("<td scope='col'>"+ rs.getInt("id") +"</td>"); %>
			      <% //nome
			      out.print("<td scope='col'>"+ rs.getString("nome") +"</td>"); %>
			      <% //raça
			      out.print("<td scope='col'>"+ rs.getString("raca") +"</td>"); %>
			      <% //peso
			      out.print("<td scope='col'>"+ rs.getDouble("peso") +"</td>"); %>
			      <% //cpf
			      out.print("<td scope='col'>"+ rs.getString("cpf") +"</td>"); %>
			      <% //data
			      out.print("<td scope='row'>"+ rs.getDate("data") +"</td>"); %>
			    </tr>
			    <%
			} while(rs.next());
			
		}	
	%>
	  </tbody>
	</table>
	<%
		
	} catch(Exception ex) {
		out.print("Erro: "+ ex.getMessage());
		return;
	}


} else if(operacao.equals("UPDATE")) {
	
	try{
		
		//============ Preencher as informações ============
		id = 4;
		nome = "auau"; 
		raca = "golden";
		peso = 30.8;
		cpf = "123.456.789-00";
		data = "2022-10-13";
		
		cmd = conexao.prepareStatement("UPDATE adocao SET nome='"+ nome +"', raca='"+ raca +"', peso="+ peso +", cpf='"+ cpf +"',data='"+ data +"' WHERE id="+ id);
		
		cmd.executeUpdate();
		
		out.println("Atualização efetuada com sucesso!");
		
	} catch(Exception ex) {
		out.print("Erro: "+ ex.getMessage());
		return;
	}
	
} else if(operacao.equals("DELETE")) {
	
	try{
		
		id = 3;
		
		cmd = conexao.prepareStatement("DELETE FROM adocao WHERE id="+ id);
		
		cmd.executeUpdate();
		
		out.println("Exclusão efetuada com sucesso!");
		
	} catch(Exception ex) {
		out.print("Erro: "+ ex.getMessage());
		return;
	}
	
} else {
	out.print("Opção inválida");
}

%>

</body>
</html>