<%-- 
    Document   : manage_Tracking
    Created on : Apr 2, 2020, 2:23:07 AM
    Author     : Asus
--%>

<%@page import="Entity.Tracking"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
            ArrayList<Tracking> alltrackinglist = (ArrayList<Tracking>) request.getAttribute("trackinglist");
            int totalpage = (Integer) request.getAttribute("totalpage");%>
    </head>
    <body>
        <table>
                        <tr>
                            <th>AlgoID</th>
                            <th>Total Time</th>
                            <th>Total People</th>

                        </tr>
                        <% for (int i = 0; i < alltrackinglist.size(); i++) {%> 
                        <tr>
                            <td><%=alltrackinglist.get(i).getAlgoID()%></td>
                            <td><%=alltrackinglist.get(i).getTotalTime()%></td>
                            <td><%=alltrackinglist.get(i).getTotalPeople()%></td>
                        </tr>
                        <%}%>
                    </table>
    </body>
</html>
