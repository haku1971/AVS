<%-- 
    Document   : newsdetail
    Created on : Mar 15, 2020, 11:59:52 AM
    Author     : quang
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="Entity.News"%>
<%@page import="Entity.Comment"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    </head>
    <body>

        <%
            ArrayList<Comment> listallcommentbynewid = (ArrayList<Comment>) request.getAttribute("listallcommentbynewid");
            News news = (News) request.getAttribute("news");
        %>
        <p><%=news.getNewID()%></p>
        <p>Title: <%=news.getNewtittles()%> </p>
        <p>Content: <%=news.getNewcontent()%> <br>


            <% for (int i = 0; i < listallcommentbynewid.size(); i++) {
            %>
        <br><hr>
        <%= "User " + listallcommentbynewid.get(i).getUser().getUsername()%>
        <%=listallcommentbynewid.get(i).getContent()%>  <br>
        <%= "Vào lúc: " + listallcommentbynewid.get(i).getDatetime()%><br>

        <form method="POST" action="CommentController2">            
            <input type="hidden" name="commentid" value="<%=listallcommentbynewid.get(i).getCommentid()%>" />
            <input  type="hidden" name="newsid" value="<%=news.getNewID()%>" />       
            <input type="submit" name ="Edit" value="Edit" onclick="edit();" />   
        </form>

        <form  method="POST" action="CommentController">            
            <input type="hidden" name="commentid" value="<%=listallcommentbynewid.get(i).getCommentid()%>" />
            <input  type="hidden" name="newsid" value="<%=news.getNewID()%>" />       
            <input type="submit" name="Delete" value="Delete" />         
        </form>

        <%

            }
        %>
     
        <form  method="POST" action="CommentController">
            <%Date date = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String strdate = formatter.format(date);
            %>
            <input type="hidden" name="strdate" value="<%=strdate%>" />
            <input type="hidden" name="newsid" value="<%=news.getNewID()%> " />
            <tr><textarea width="500" name="commentcontent"></textarea></tr>
        <tr><input type="submit" name="postodb" value="Post comment" /></tr>         
</form>



</body>
</html>
