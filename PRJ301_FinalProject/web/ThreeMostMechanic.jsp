<%-- 
    Document   : ThreeMostMechanic
    Created on : Feb 27, 2025, 8:09:41 PM
    Author     : LENOVO
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.Mechanic"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>THREE MOST MECHANIC</h1>
        <%
//            ArrayList<Mechanic> list = (ArrayList<Mechanic>) session.getAttribute("LIST_MECHANIC");
            HashMap<Mechanic, Integer> map = (HashMap<Mechanic, Integer>) session.getAttribute("MAP_MECHANIC");
        %>
        <table>
            <tr>
                <th>Mechanic ID</th>
                <th>Mechanic Name</th>
                <th>Total</th>
            </tr>
            <%                if (map != null && !map.isEmpty()) {
                    for (Map.Entry<Mechanic, Integer> mechicMap : map.entrySet()) {
                        Mechanic mechanic = mechicMap.getKey();
                        int total = mechicMap.getValue();

            %>
            <tr>
                <td><%=mechanic.getId()%></td>
                <td><%=mechanic.getName()%></td>
                <td><%=total%></td>
            </tr>
            <%
                    }
                }
            %>
    </body>
</table>
</html>
