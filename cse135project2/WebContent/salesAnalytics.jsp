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
		   //System.out.println("Over here");
		   Class.forName("org.postgresql.Driver");
		   //System.out.println("nope");
		   Connection conn = null;
		   conn = DriverManager.getConnection(
					"jdbc:postgresql://localhost:5432/postgres", "postgres", "password");
		   conn.setAutoCommit(false);
 %>
	<center>
		<form action="salesAnalytics.jsp" method="post">
			<table>
				<tr>
					<td align="center"><select id="cust" name="cust">
							<option selected="selected" value="customers">Customers</option>
							<option value="states">States</option>
					</select></td>
				</tr>
				<td align="center">State <select id="state" name="state">
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
				</select> Category <select id="categories" name="categories">
						<option selected="selected">All</option>
						<%
							try{
								ResultSet rs=null;
								Statement state=conn.createStatement();
								rs=state.executeQuery("SELECT name FROM categories");
								while(rs.next()){
									%><option><%=rs.getString("name")%>
						</option>
						<% //System.out.println("maybe here");
								}
							}
						catch (SQLException se) {
							System.out.println("gets into categories search");
						    out.println(se.getMessage());
						}
						%>
				</select> Age <select name="age">
						<option selected="selected">All</option>
						<option>12-18</option>
						<option>18-45</option>
						<option>45-65</option>
						<option>65+</option>
				</select>
				</td>
				</tr>
				<tr>
					<td align="center"><input type="submit" name="value"
						value="Run Query" /></td>
				</tr>
			</table>
		</form>
	</center>
	<% 
		int productsDis=0;
		String newTable=request.getParameter("age");
		String cat=request.getParameter("categories");
		
		if(newTable!=null){
			%><table border="1">
		<%
			try{
				ResultSet rs=null;
				Statement s=conn.createStatement();
				String que=null;
				if(!cat.equals("All")){
					que="SELECT products.name,products.id FROM products join categories on products.cid=categories.id"+ 
							"WHERE products.id>0 " +
							"AND products.id<11 AND categories.name= "+"\""+cat+"\""+" ORDER BY products.id";
				}
				else{
					System.out.println("dance");
					que="SELECT products.name, products.id FROM products WHERE products.id>0" +
							" AND products.id<11  ORDER BY products.id";
				}
				System.out.println("pls be here abc");
				rs=s.executeQuery(que);
				System.out.println(que);
				System.out.println("error after this");
				if(rs.next()){
					%><tr><th></th>
		<%
				for(int i=1;i<=10;i++){
					if(Integer.parseInt(rs.getString("id"))==i){
						%><th><%=rs.getString("name") %></th>
		<% 
						rs.next();
				}
					else{
						%><th></th>
		<%
					}
				}
			}
				%></tr><% 
				
				%></table><%
			}
			catch (SQLException sqle) {
				
			    out.println(sqle.getMessage());
			}
		}
	%>
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
