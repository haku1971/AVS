<%-- 
    Document   : newdetail2
    Created on : Mar 15, 2020, 12:51:36 PM
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
    <body>
        <%
            ArrayList<Comment> listallcommentbynewid = (ArrayList<Comment>) request.getAttribute("listallcommentbynewid");
            News news = (News) request.getAttribute("news");
            int commentid = (Integer) request.getAttribute("commentid");
        %>

        <p>Title: <%=news.getNewtittles()%> </p>
        <p>Content: <%=news.getNewcontent()%> <br>

            <!--phần bên dưới là comment-->     
            <% for (int i = 0; i < listallcommentbynewid.size(); i++) {
            %>

            <%= "User:  " + listallcommentbynewid.get(i).getUser().getUsername()%><br>
            <%= "Vào lúc: " + listallcommentbynewid.get(i).getDatetime()%><br>
            <% if (listallcommentbynewid.get(i).getCommentid() == commentid) {%>    
        <form method="POST" action="CommentController">           
            <input id="content" type="text" name="commentcontentedit" value="<%=listallcommentbynewid.get(i).getContent()%>" /> <br>
            <input type="hidden" name="commentid" value="<%=listallcommentbynewid.get(i).getCommentid()%>" />
            <input  type="hidden" name="newsid" value="<%=news.getNewID()%>" />       
            <input id="save" type="submit" name ="save" value="Save" /> 
            <input type="submit" name ="cancel" value="Cancel"  />  
        </form>
        <% } else {%>
        <%=listallcommentbynewid.get(i).getContent()%>   <br>
        <form method="POST" action="CommentController2">            
            <input type="hidden" name="commentid" value="<%=listallcommentbynewid.get(i).getCommentid()%>" />
            <input  type="hidden" name="newsid" value="<%=news.getNewID()%>" />       
            <input type="submit" name ="Edit" value="Edit"/>   
        </form>
        <form method="POST" action="CommentController">            
            <input type="hidden" name="commentid" value="<%=listallcommentbynewid.get(i).getCommentid()%>" />
            <input  type="hidden" name="newsid" value="<%=news.getNewID()%>" />       
            <input type="submit" name="Delete" value="Delete" />         
        </form>
        <% }%>


        <%

            }
        %>
        <script>
            $('#content').keyup(function () {
                // Get the Login Name value and trim it
                var name = $('#content').val();
                console.log(name);
                // Check if empty of not
                if (name.length < 1) {
                    console.log("<1");
                   $("#save").attr("disabled", true);
                }else {
                    console.log(">1");
                    $("#save").attr("disabled", false);
                }

            });

        </script>
        <table>       
            <form method="POST" action="CommentController">
                <%Date date = new Date();
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    String strdate = formatter.format(date);
                %>
                <input type="hidden" name="strdate" value="<%=strdate%>" />
                <input type="hidden" name="newsid" value="<%=news.getNewID()%>" />
                <tr><input id="username" type="text" name="" value="" /></tr>
                <tr><textarea width="500" name="commentcontent"></textarea></tr>
                <tr><input type="submit" name="postodb" value="Post comment" /></tr>         
            </form>
        </table>

    </body>
</html>
