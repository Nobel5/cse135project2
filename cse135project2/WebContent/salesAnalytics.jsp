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
						<input type="hidden" name="newTable" value="new"></input>
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
		String newTable=request.getParameter("newTable");
		String cust=request.getParameter("cust");
		String age = request.getParameter("age");
		String cat=request.getParameter("categories");
		System.out.println("Cat is "+ cat);
		String lastname=request.getParameter("lastname");
		System.out.println(lastname);
		String num=request.getParameter("num");
		String states=request.getParameter("state");
		System.out.println("into first statements");
		if(newTable!=null){
			
			%>
				<table border="1">
<tr>
			<th width="10%"></th>
			<%
			// Column headers
			try {
				String selectedType = request.getParameter("cust");
				String selectedState = request.getParameter("state");
				String selectedCategory = request.getParameter("categories");
				String selectedAge = request.getParameter("age");
				ResultSet colRs = null;
				Statement colSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
				        ResultSet.CONCUR_READ_ONLY);
				String colQuery = null;
				String colCategory = "";
				String colState = "";
				String colAge = "";
				if (!selectedState.equals("All")) {
					colState = " AND (users.state='"+selectedState+"')";
				}
				if (!selectedAge.equals("All")) {
					int minAge = Integer.parseInt(selectedAge.substring(0,2));
					if (minAge == 65) {
						colAge = " AND (users.age>=65)";
					} else {
						int maxAge = Integer.parseInt(selectedAge.substring(3,5));
						colAge = " AND (users.age>="+minAge+") AND (users.age<="+maxAge+")";
					}
				}
				if (!selectedCategory.equals("All")) {
					colCategory = " AND (categories.name='"+selectedCategory+"')";
				}
				colQuery = "SELECT products.name,products.id, SUM(sales.quantity*sales.price) AS total"
						+ " FROM products LEFT OUTER JOIN (sales JOIN users ON (sales.uid=users.id)"
						+ colState + colAge
						+ ") ON (products.id=sales.pid) JOIN categories ON (products.cid=categories.id)"
						+ colCategory
						+ " WHERE products.id>0 AND products.id<11"
						+ " GROUP BY products.id ORDER BY products.id";
				//System.out.println(colQuery);
				
				colRs = colSt.executeQuery(colQuery);
				for (int i=1; i<=10; i++) {
			%>
			<th width="9%">
				<%
					if (colRs.next()) {
						if(colRs.getInt("id")==i){
						String productsName = colRs.getString("name");
						if (productsName.length() <= 10) {
				%> <%=productsName%><br>($<%=colRs.getInt("total")%>)<%
						} else {
				%> <%=productsName.substring(0,10)%><br>($<%=colRs.getInt("total")%>)<%
						}
						}
						else
							colRs.previous();
					}
				%>
			</th>
			<%
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
			%>
		</tr>
		<% 
		try{
		ResultSet rTotal=null;
		ResultSet matrix=null;
		String last;
		Statement mTotal=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
		        ResultSet.CONCUR_READ_ONLY);
		Statement sTotal=conn.createStatement();
		String total="SELECT users.name, SUM(sales.quantity*sales.price) as sq "+
		"FROM users LEFT OUTER JOIN sales ON sales.uid=users.id "+
		"LEFT OUTER JOIN products on products.id = sales.pid";
		String mat="SELECT users.name, products.name,products.id,sum(sales.quantity*sales.price) AS pi "+
		" FROM users LEFT OUTER JOIN sales on sales.uid=users.id LEFT OUTER JOIN products on sales.pid=products.id ";
		if(!cat.equals("All")){
			total=total+" LEFT OUTER JOIN categories on categories.id = products.cid ";
			mat=mat+" LEFT OUTER JOIN categories on categories.id = products.cid ";
			System.out.println("adds categories into from");
		}
		int d=0;
		String where=" WHERE (";
		String and=" AND ";
		
		int gag=0;
		String comb="";
		
		if(!age.equals("All")&&!age.equals("65+")){
			System.out.println("if 1");
			gag=1;
			comb=where+"users.age > "+age.substring(0,2)+and+"users.age <= "+age.substring(3);
			d=1;
			if(!states.equals("All")){
				comb=comb+and+" users.state ="+"\'"+states+"\' ";
			}
			if(!cat.equals("All")){
				comb=comb+and+" categories.name="+"\""+cat+"\" ";		
			}
		}
		else if(!age.equals("All")&&age.equals("65+")){
			System.out.println("if 2");
			gag=1;
			comb=where+"users.age > "+age.substring(0,2);
			d=1;
			if(!states.equals("All")){
				comb=comb+and+" users.state ="+"\'"+states+"\' ";
			}
			if(!cat.equals("All")){
				comb=comb+and+" categories.name="+"\'"+cat+"\'";		
			}
		}
		else if(age.equals("All")&&(!states.equals("All"))){
			System.out.println("if 3");
			gag=1;
			comb=where+" users.state ="+"\'"+states+"\' ";
			d=1;
			if(!cat.equals("All")){
				comb=comb+and+" categories.name="+"\'"+cat+"\' ";		
			}
		}
		else if(age.equals("All")&&states.equals("All")&&(!cat.equals("All"))){
			System.out.println("gets into the cat area work now pls");
			gag=1;
			comb=where+" categories.name="+"\'"+cat+"\' ";
			d=1;
		}
		else
			System.out.println("gets into final else");
		String nextTable;
		String nextTwenty;
		
		if(d==1){
			nextTable=mat+comb+
					 ") OR sales.id IS NULL  GROUP BY users.name,products.id, products.name "+
						" ORDER BY users.name,products.id,products.name ASC ";
			mat=mat+comb+and+" products.id>=1 AND products.id<=10) OR sales.id IS NULL  "+
					 " GROUP BY users.name,products.id, products.name "+
						" ORDER BY users.name,products.id,products.name ASC "+" LIMIT 200";
			
		}
		else{
			nextTable=mat+comb+
					 "  GROUP BY users.name,products.id, products.name "+
						" ORDER BY users.name,products.id,products.name ASC ";
			mat=mat+comb+where+" products.id>=1 AND products.id<=10) OR sales.id IS NULL "+
		 " GROUP BY users.name,products.id, products.name "+
			" ORDER BY users.name,products.id,products.name ASC "+" LIMIT 200";
			
		}
		if(gag==1)
			comb=comb+") OR sales.id IS NULL ";
		String fir=comb+" GROUP BY users.name ORDER BY users.name LIMIT 20";
		nextTwenty=total+comb+" GROUP BY users.name ORDER BY users.name ";
		
		/////////////////////////////////////
		String colW="SELECT users.name , SUM(sales.quantity*sales.price) AS sq "+
		"FROM users LEFT OUTER JOIN(sales JOIN ";
		String matrixW="SELECT users.name,products.id , SUM(sales.quantity*sales.price) AS pi "+
				"FROM users LEFT OUTER JOIN(sales JOIN ";
		if(cust.equals("states")){
			colW="SElECT states.name,SUM(sales.quantity*sales.price) AS sq"+
		" FROM states LEFT OUTER JOIN(users LEFT OUTER JOIN(sales JOIN ";
			matrixW="SElECT states.name,products.id,SUM(sales.quantity*sales.price) AS pi"+
					" FROM states LEFT OUTER JOIN(users LEFT OUTER JOIN(sales JOIN ";
		}
		String query="";
		if(!cat.equals("All")){
			query+=" (products JOIN categories ON (products.cid=categories.id)AND(categories.name=\'"+cat +"\'))";
		}
		else{
			query+=" products";
		}
		query+=" ON sales.pid=products.id) ON sales.uid=users.id"; //"WHERE true";
		if(cust.equals("states")){
			query+=") on users.state=states.name";
			
		}
		query+=" WHERE true";
		if(!states.equals("All")){
		 	query+=" AND users.state=\'"+states+"\' ";
		}
		if(!age.equals("All")&&!age.equals("65+")){
			query+=" AND users.age>="+age.substring(0,2)+" AND users.age<= "+age.substring(3)+" ";
		}
		else if(!age.equals("All")&&age.equals("65+")){
			query+=" AND users.age>="+age.substring(0,2)+" ";
		}
		String tempColW;
		String tempMatW;
		if(!cust.equals("states")){
		 tempColW=colW+query+" GROUP BY users.name ORDER BY users.name ASC";
		 tempMatW=matrixW+query+" GROUP BY users.name, products.id ORDER BY users.name, products.id ASC";
		colW+=query+" GROUP BY users.name ORDER BY users.name ASC LIMIT 20";
		
		matrixW+=query+" GROUP BY users.name, products.id ORDER BY users.name, products.id ASC LIMIT 200";
		}
		else{
			tempColW=colW+query+" GROUP BY states.name ORDER BY states.name ASC";
			tempMatW=matrixW+query+" GROUP BY states.name, products.id ORDER BY states.name, products.id ASC";
			colW+=query+" GROUP BY states.name ORDER BY states.name ASC LIMIT 20";
			
			matrixW+=query+" GROUP BY states.name, products.id ORDER BY states.name, products.id ASC LIMIT 200";
		}
		
		
			
		
		/////////////////////////////////////
		System.out.println("STATEMENT 1\n"+colW);
		rTotal=sTotal.executeQuery(colW);
		System.out.println("STATEMENT 2\n"+matrixW);
		matrix=mTotal.executeQuery(matrixW);
		System.out.println("gets to that nice spot");
		last="";
		for(int i=1;i<=20;i++){
			if(rTotal.next()){
				last=rTotal.getString("name");
			%>
			<tr>
			<th><%=rTotal.getString("name") %><br>($<%=rTotal.getInt("sq") %>)</th>
			<%
				
				for(int j=1;j<=10;j++){
					if(matrix.next()){
						if(matrix.getString("name").equals(rTotal.getString("name"))){
							if(matrix.getInt("id")==j){
								System.out.println("if 1");
								%><td><%=matrix.getString("pi") %></td><% 
							}
							else{
								%><td>0</td><%
								System.out.println(matrix.getString("name"));
								System.out.println("else 1");
								if(j!=10)
								matrix.previous();
							}
						}
						else{
							System.out.println(matrix.getString("name"));
							
							matrix.previous();
							System.out.println("else 2");
							%><td>0</td><%
						}
					}
					else
					%><td>0</td><%
				}
			%>
			
			</tr>
			
			<% }
			else{
				break;
			}
			
		}
		rTotal=sTotal.executeQuery(total+fir);
		matrix=mTotal.executeQuery(mat);
		System.out.println("past the new stuff");
	    conn.setAutoCommit(true);
		conn.setAutoCommit(false);  
		Statement pie=conn.createStatement();
		Statement pieEater=conn.createStatement();
		Statement productSt = conn.createStatement();
		try{
			pie.executeUpdate("DROP TABLE tempMatrix");
			pieEater.executeUpdate("DROP TABLE tempCol");
			productSt.executeUpdate("DROP TABLE IF EXISTS tempProduct");
			
		}catch (SQLException sqle) {
			out.println(sqle.getMessage());
		}
		conn.setAutoCommit(true);
		conn.setAutoCommit(false);  
		
		System.out.println("begin");
		Statement f=conn.createStatement();
		Statement g=conn.createStatement();
		Statement h = conn.createStatement();
		f.executeUpdate("CREATE TABLE tempMatrix("+
		" name TEXT, "+
				"  pid         INTEGER, "+
		" total INTEGER );");
		//System.out.println("1");
		g.executeUpdate("CREATE TABLE tempCol("+
				" name TEXT, "+
				" total INTEGER );");
		//System.out.println("2");
		h.executeUpdate("CREATE TABLE tempProduct(name TEXT, id INTEGER, total INTEGER)");
		System.out.println("STATEMENT 3\n"+tempColW);
		conn.setAutoCommit(true);
		conn.setAutoCommit(false);
		Statement status=conn.createStatement();
		ResultSet bob=status.executeQuery(tempColW);
		System.out.println("STATEMENT 4\n"+tempMatW);
		Statement st=conn.createStatement();
		ResultSet sam=st.executeQuery(tempMatW);
		//System.out.println("3");
		while(bob.next()){
			String name=bob.getString("name");
			String sum=bob.getString("sq");
			if(bob.getString("sq")==null){
				sum="0";
			}
			//System.out.println("INSERT INTO tempCol(name,total) VALUES(\""+name+"\","+sum+")");
			sTotal.execute("INSERT INTO tempCol(name,total) VALUES(\'"+name+"\',"+sum+")");
			//System.out.println("past it");
		}
		System.out.println("4");
		while(sam.next()){
			String name=sam.getString("name");
			String pid= sam.getString("id");
			String sum=sam.getString("pi");
			Statement gg=conn.createStatement();
			//System.out.println("INSERT INTO tempMatrix(name,pid,total) VALUES(\""+name+"\","+pid+","+sum+")");
			gg.executeUpdate("INSERT INTO tempMatrix(name,pid,total) VALUES(\'"+name+"\',"+pid+","+sum+")");
			
		}
		System.out.println("5");
		////////////
		String selectedType = request.getParameter("cust");
				String selectedState = request.getParameter("state");
				String selectedCategory = request.getParameter("categories");
				String selectedAge = request.getParameter("age");
				Statement colSt = conn.createStatement();
				String colQuery = null;
				String colCategory = "";
				String colState = "";
				String colAge = "";
				if (!selectedState.equals("All")) {
					colState = " AND (users.state='"+selectedState+"')";
				}
				if (!selectedAge.equals("All")) {
					int minAge = Integer.parseInt(selectedAge.substring(0,2));
					if (minAge == 65) {
						colAge = " AND (users.age>=65)";
					} else {
						int maxAge = Integer.parseInt(selectedAge.substring(3,5));
						colAge = " AND (users.age>="+minAge+") AND (users.age<="+maxAge+")";
					}
				}
				if (!selectedCategory.equals("All")) {
					colCategory = " AND (categories.name='"+selectedCategory+"')";
				}
				colQuery = "SELECT products.name, products.id, SUM(sales.quantity*sales.price) AS total"
						+ " FROM products LEFT OUTER JOIN (sales JOIN users ON (sales.uid=users.id)"
						+ colState + colAge
						+ ") ON (products.id=sales.pid) JOIN categories ON (products.cid=categories.id)"
						+ colCategory
						+ " GROUP BY products.id ORDER BY products.id";
				//System.out.println(colQuery);
		ResultSet productRs = colSt.executeQuery(colQuery);
		while(productRs.next()) {
			Statement productSt3 = conn.createStatement();
			String pName = productRs.getString("name");
			int pTotal = productRs.getInt("total");
			int pId = productRs.getInt("id");
			productSt3.executeUpdate("INSERT INTO tempProduct(name,id,total) VALUES (\'"+pName+"\',"+pId+","+pTotal+")");
		}
		
		%>
			</table>
			<form action="salesAnalytics.jsp" method="post">
			<input type="hidden" name="lastname" value="<%=last%>"></input>
			<input type="hidden" name="num" value="1"></input>
			<input type="hidden" name="age" value="<%=age%>"></input>
			<input type="hidden" name="state" value="<%=cat%>"></input>
			<input type="hidden" name="categories" value="<%=cat%>"></input>
			<button type="submit">Next 20 names</button>
			</form>
			<form action="salesAnalytics.jsp" method="post">
			<input type="hidden" name="lastname" value=""></input>
			<input type="hidden" name="num" value="11"></input>
			<input type="hidden" name="age" value="<%=age%>"></input>
			<input type="hidden" name="state" value="<%=cat%>"></input>
			<input type="hidden" name="categories" value="<%=cat%>"></input>
			<button type="submit">Next 10 products</button>
			</form>
		<%
		
		
		
				%>
	
	<%
			}
			catch (SQLException sqle) {
				
			    out.println(sqle.getMessage());
			}
		}
		else if(lastname!=null){
			try{
				%><table border="1"> <%
				//System.out.println("gets into part 2");
				ResultSet rq=null;
				Statement sss=conn.createStatement();
				String que=null;
				int n=Integer.parseInt(num);
				n+=10;
				System.out.println(n+" =n ");
				/*
				if(!cat.equals("All")){
					que="SELECT products.name,products.id FROM products join categories on products.cid=categories.id"+ 
							"WHERE products.id>="+ num+
							" AND products.id<"+n +" AND categories.name= "+"\'"+cat+"\'"+" ORDER BY products.id";
				}
				else{
					System.out.println("dance");
					que="SELECT products.name, products.id FROM products WHERE products.id>="+num +
							" AND products.id<"+n+ "  ORDER BY products.id";
				}
				
				System.out.println("pls be here abc");
				*/
				que = "SELECT tempProduct.name, tempProduct.id, tempProduct.total FROM tempProduct"
					+ " WHERE tempProduct.id>="+num+" AND tempProduct.id<"+n;
				rq=sss.executeQuery(que);
				System.out.println("Statement que: "+que);
				System.out.println("error after this");
				int rab=0;
				if(rq.next()){
					System.out.println("gets to here");
					%><tr><th></th>

			<%
				for(int i=1;i<=10;i++){
					if(Integer.parseInt(rq.getString("id"))==i-1+Integer.parseInt(num)){
						%><th><%=rq.getString("name") %><br>$(<%=rq.getInt("total") %>)</th>
			<% 
					boolean r=rq.next();
					if(!r&&i!=10){
						rab=1;
						break;
					}
				}
					else{
						%><th></th>
			<%
					}
				}
			%></tr><% 
			}
				
				String last="";
				String first;
				ResultSet rw=null;
				ResultSet m=null;
				Statement sta=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
				        ResultSet.CONCUR_READ_ONLY);
				Statement nnn=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
				        ResultSet.CONCUR_READ_ONLY);
				String queryTempMatrix="SELECT name,pid,total FROM tempMatrix "+
					"WHERE pid >= "+num+" AND pid < "+n+" AND name>"+"\'"+lastname+"\'"+" LIMIT 200";
				String queryTempCol="SELECT name,total FROM tempCol "+
						"WHERE name>"+"\'"+lastname+"\'"+" LIMIT 20";
				rw=sta.executeQuery(queryTempMatrix);
				m=nnn.executeQuery(queryTempCol);
				System.out.println("gets done");
				for(int i=1;i<=20;i++){
					if(m.next()){
						last=m.getString("name");
						
					%>
					<tr>
					<th><%=m.getString("name") %><br>$(<%=m.getString("total") %>)</th>
					<%
						
						for(int j=1;j<=10;j++){
							if(rw.next()){
								if(rw.getString("name").equals(m.getString("name"))){
									//System.out.println("here");
									if(rw.getInt("pid")==j-1+Integer.parseInt(num)){
										%><td><%=rw.getString("total") %></td><% 
									}
									else{
										%><td>0</td><%
										rw.previous();
									}
									//System.out.println("nope sorry dude");
								}
								else{
									rw.previous();
									%><td>0</td><%
								}
							}
							else
							%><td>0</td><%
						}
					%>
					
					</tr>
					
					<% }
					else{
						break;
					}
					
				}
				//here start here
				
				%>
				</table>
				<%if(!last.equals("")){ %>
			<form action="salesAnalytics.jsp" method="post">
			<input type="hidden" name="lastname" value="<%=last%>"></input>
			<input type="hidden" name="num" value="<%=num%>"></input>
			<input type="hidden" name="age" value="<%=age%>"></input>
			<input type="hidden" name="state" value="<%=states%>"></input>
			<input type="hidden" name="categories" value="<%=cat%>"></input>
			<button type="submit">Next 20 names</button>
			</form>
			<%}
				if(rab!=1){	%>
			<form action="salesAnalytics.jsp" method="post">
			<input type="hidden" name="lastname" value="<%=lastname%>"></input>
			<input type="hidden" name="num" value="<%=n %>"></input>
			<input type="hidden" name="age" value="<%=age%>"></input>
			<input type="hidden" name="state" value="<%=states%>"></input>
			<input type="hidden" name="categories" value="<%=cat%>"></input>
			<button type="submit">Next 10 products</button>
			</form>
		
		<% }
				
			}
			catch (SQLException sqle) {
				System.out.println("part 2 work pls");
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
	System.out.println("Is an execption");
    out.println(e.getMessage());
}
%>

</body>
</html>



