<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" import="database.*" import="java.util.*"
	errorPage=""%>
<%
/*if(session.getAttribute("name")!=null)
{
  String name=(String) session.getAttribute("name");
}*/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SALES</title>
</head>
<body>
	<%     try{
		   System.out.println("Over here");
		   Class.forName("org.postgresql.Driver");
		   System.out.println("nope");
		   Connection conn = null;
		   conn = DriverManager.getConnection(
					"jdbc:postgresql://localhost:5432/postgres", "postgres", "password");
		   conn.setAutoCommit(false);
 %>
	<center>

		<center>
			<table width="100%">
				<tr>
					<form>
						<select id="cust" name="cust">
							<option selected="selected" value="customers">Customers</option>
							<option value="states">States</option>
						</select> <select id="state" name="state">
							<option selected="selected">All</option>
							<option>Alabama</option>
							<option>Alaska</option>
							<option>Arizona</option>
							<option>Arkansas</option>
							<option>California</option>
							<option>Colorado</option>
							<option>Connecticut</option>
							<option>Delaware</option>
							<option>Florida</option>
							<option>Georgia</option>
							<option>Hawaii</option>
							<option>Idaho</option>
							<option>Illinois</option>
							<option>Indiana</option>
							<option>Iowa</option>
							<option>Kansas</option>
							<option>Kentucky</option>
							<option>Louisiana</option>
							<option>Maine</option>
							<option>Maryland</option>
							<option>Massachusetts</option>
							<option>Michigan</option>
							<option>Minnesota</option>
							<option>Mississippi</option>
							<option>Missouri</option>
							<option>Montana</option>
							<option>Nebraska</option>
							<option>Nevada</option>
							<option>New Hampshire</option>
							<option>New Jersey</option>
							<option>New Mexico</option>
							<option>New York</option>
							<option>North Carolina</option>
							<option>North Dakota</option>
							<option>Ohio</option>
							<option>Oklahoma</option>
							<option>Oregon</option>
							<option>Pennsylvania</option>
							<option>Rhode Island</option>
							<option>South Carolina</option>
							<option>South Dakota</option>
							<option>Tennessee</option>
							<option>Texas</option>
							<option>Utah</option>
							<option>Vermont</option>
							<option>Virginia</option>
							<option>Washington</option>
							<option>West Virginia</option>
							<option>Wisconsin</option>
							<option>Wyoming</option>
						</select> <select>
							<option selected="selected">All</option>
							<%
							try{
								ResultSet rs=null;
								Statement state=conn.createStatement();
								rs=state.executeQuery("SELECT name FROM categories");
								while(rs.next()){
									%><option><%=rs.getString("name")%>
							</option>
							<% 
								}
							}
						catch (SQLException sqle) {
							System.out.println("gets into categories search");
						    out.println(sqle.getMessage());
						}
						%>
						</select> <select name="age">
							<option selected="selected">All</option>
							<option>12-18</option>
							<option>18-45</option>
							<option>45-65</option>
							<option>65+</option>
						</select>
					</form>
				</tr>
			</table>
		</center>
		<%
conn.setAutoCommit(true);
 conn.close();
} catch (SQLException sqle) {
	System.out.println("at the very end here");
    out.println(sqle.getMessage());
} catch (Exception e) {
	System.out.println("Is an exection");
    out.println(e.getMessage());
}
%>
	
</body>
</html>
