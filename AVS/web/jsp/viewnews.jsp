<%-- 
    Document   : viewnews
    Created on : Mar 20, 2020, 9:17:00 PM
    Author     : Ukah
--%>

<%@page import="Entity.News"%>
<%@page import="Model.UserModel"%>
<%@page import="Entity.User"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="Entity.Algorithm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/Visual.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />

        <%
            News news = (News) request.getAttribute("news");
            Boolean addnews = (Boolean) request.getAttribute("addnew");
            String action = news.getDeleted() == 0 ? "Delete" : "Restore";
        %>
    </head>

    <body>
        <%@include file="header.jsp" %> 

        <div class="banner">
            <h1>Welcome to Algorithm Visualize System</h1>
            <h5>The noblest pleasure is the joy of understanding</h5>
        </div>
        <div class="main">
            <%@include file="adminleft.jsp" %> 
            <div class="right">

                <div class="newsinfomation">
                    <%if (addnews) {%>
                    <!--trang addnew-->
                    <form method="POST" action="manage" enctype="multipart/form-data" onsubmit="return validate();">
                        <input type="hidden" name="managetype" value="addnews">
                        <div>Title: </div> <div><input id="title" type="text" name="title" value=""></div>
                        <div>Content:  </div> <div><textarea id="content" name="content" rows="10" cols="30" ></textarea></div>
                        <div>Source: </div> <div><input type="text" name="source" value=""></div>
                        <br>
                        <div>Image: <input type="file" name="image"></div>
                        <br>
                        <input type="submit" value="Save">
                    </form>
                    <a href="admin?category=news"><button>Cancel</button></a>
                    <%} else {%>
                    <!--trang view-->
                    <div class="algoid">News ID: <%=news.getNewsID()%></div>
                    <form method="POST" action="manage" enctype="multipart/form-data" onsubmit="return validate();">
                        <input type="hidden" name="newsid" value="<%=news.getNewsID()%>" >
                        <input type="hidden" name="managetype" value="editnews">
                        <input type="hidden" name="imageurl" value="<%=news.getNews_Imgs()%>" >
                        <div>Title: </div> <div><input id="title" type="text" name="title" value="<%=news.getNewstittles()%>"></div>
                        <div>Content:  </div> 
                        <div>
                            <textarea id="content" name="content" rows="10" cols="30" >
                                <%=news.getNewscontent()%>
                            </textarea>
                        </div>
                        <div>Source: </div> <div><input type="text" name="source" value="<%=news.getNewsresource()%>"></div>

                        <div>Image: <% if (!(news.getNews_Imgs() == null || news.getNews_Imgs().equals("null"))) {%>
                            <img src="<%=news.getNews_Imgs()%>"><%}%> 
                            <input id="file" type="file" name="image">
                        </div>
                        <input type="submit" value="Save">
                    </form>
                    <a href="admin?category=news"><button>Back</button></a>
                    <form method="POST" action="manage" onsubmit="return confirm('<%=action%> this news?');">
                        <input type="hidden" name="managetype" <%if (news.getDeleted() == 1) {%>value="restorenews"<%} else {%>value="deletenews"<%}%>>
                        <input type="hidden" name="newsid" value="<%=news.getNewsID()%>" >
                        <input type="submit" <%if (news.getDeleted() == 1) {%>value="Restore"<%} else {%>value="Delete"<%}%>>
                    </form>
                    <%}%>
                </div>
            </div>
            <%@include file="footer.jsp" %>    

    </body>
    <script>
        function validate() {
            let titlevalue = document.getElementById("title").value;
            let contentvalue = document.getElementById("content").value;
            if (titlevalue === "") {
                alert('Title can not be empty!');
                return false;
            } else if (contentvalue === "") {
                alert('Content can not be empty!');
                return false;
            } else {
                return validatePictureFile();
                return confirm('Do you really want to save change?');
            }
        }

        function validatePictureFile() {
            var input, file;
            input = document.getElementById("file");
            file = input.files[0];
            let fileextension = file.name.split('.')[file.name.split('.').length - 1];
            if (!(fileextension === "jpg" || fileextension === "png")) {
                alert("Only .jpg or .png file allow!");
                return false;
            }
            if (file.size > 10000000) { //10MB
                alert("File size must be < 10MB");
                return false;
            }
            return confirm('Do you really want to save change?');
        }

    </script>
</html>
