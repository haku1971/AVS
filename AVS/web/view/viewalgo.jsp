<%-- 
    Document   : viewalgo
    Created on : Mar 19, 2020, 9:15:51 PM
    Author     : Ukah
--%>

<%@page import="Model.Category"%>
<%@page import="DAO.UserDAO"%>
<%@page import="Model.User"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="Model.Algorithm"%>
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
            Algorithm algo = (Algorithm) request.getAttribute("algo");
            Boolean addnew = (Boolean) request.getAttribute("addnew");
            ArrayList<Category> listalgocategory = (ArrayList<Category>) request.getAttribute("listalgocategory");
            String errormessage = (String) request.getAttribute("errormessage");
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
            <div class="adminright">

                <div class="algoinfomation">
                    <%if (addnew) {%>
                    <!--trang addnew-->
                    <% if (errormessage != null) {%>
                    <div class="errormess"><%=errormessage%></div>
                    <%}%>
                    <div class="algoid">Add Algorithm:</div>
                    <br>
                    <form method="POST" action="manage" onsubmit="return validate();">
                        <input type="hidden" name="managetype" value="addalgo">
                        <div class="modify">
                            <div style="display: inline-block;">Name: </div> 
                            <div style="display: block; margin-bottom: 20px;"><input id="algoname" type="text" name="algoname" value=""></div>
                        </div>
                        <div class="modify">                        
                            <div>Category: </div>
                            <div style="margin-bottom: 20px;">
                                <input type="hidden" name="category" id="inputcategory" value="1">
                                <select id="selectcategory" onchange="changeCategory(this)">
                                    <% for (int i = 0; i < listalgocategory.size(); i++) {%>
                                    <option value="<%=listalgocategory.get(i).getCategoryID()%>"><%=listalgocategory.get(i).getCategoryName()%></option>
                                    <%}%>
                                </select></div>
                        </div>
                        <div class="modify">
                            <div>Resource: </div> <div style="margin-bottom: 20px;"><input type="text" name="resource" value=""></div>
                        </div>  

                        <br>
                        <div class="modifyleft"><div>Code Java:  </div> <div><textarea name="codejava" rows="10" cols="60" ></textarea></div></div>
                        <div class="modifyright"><div>Code C++:  </div> <div><textarea name="codecpp" rows="10" cols="60" ></textarea></div></div>
                        <div class="modifyleft"><div>Code JS:  </div> <div><textarea name="codejs" rows="10" cols="60" ></textarea></div></div>
                        <div class="modifyright"><div>Description: </div> <div><textarea id="description" name="description" rows="10" cols="60" ></textarea></div></div>
                        <br>
                        <div class="modifyleftlast">
                            <input id="but" type="submit" value="Save">
                        </div>
                    </form>
                    <div class="modifyrightlast">
                        <a href="admin?category=algorithm"><button id="but1">Cancel</button></a>
                    </div>
                    <%} else {
                        String action = algo.getDeleted() == 0 ? "Delete" : "Restore";%>
                    <!--trang view-->

                    <div class="algoid">Algorithm ID: <%=algo.getAlgoID()%></div>
                    <div> Added Time: <%=algo.getAlgoDatetime()%></div>

                    <br>
                    <form method="POST" action="manage" onsubmit="return validate();">
                        <input type="hidden" name="managetype" value="editalgo">
                        <input type="hidden" name="algoid" value="<%=algo.getAlgoID()%>" >
                        <div class="modify">
                            <div style="display: inline-block;">Name: </div> 
                            <div style="display: block; margin-bottom: 20px;"><input id="algoname" type="text" name="algoname" value="<%=algo.getAlgoName()%>"></div>
                        </div>
                        <div class="modify">
                            <div>Category: </div>
                            <div style="margin-bottom: 20px;">
                                <input type="hidden" name="category" id="inputcategory" value="<%=algo.getCategoryID()%>">
                                <select id="selectcategory" onchange="changeCategory(this)">
                                    <% for (int i = 0; i < listalgocategory.size(); i++) {%>
                                    <option value="<%=listalgocategory.get(i).getCategoryID()%>"><%=listalgocategory.get(i).getCategoryName()%></option>
                                    <%}%>
                                </select></div>
                        </div>
                        <div class="modify">
                            <div>Resource: </div> <div style="margin-bottom: 20px;"><input type="text" name="resource" value="<%=algo.getAlgoResource()%>"></div>
                        </div>  
                        <br>
                        <div class="modifyleft"><div>Code Java:  </div> <div><textarea name="codejava" rows="10" cols="60" ><%=algo.getAlgoCodeJava()%></textarea></div></div>
                        <div class="modifyright"><div>Code C++:  </div> <div><textarea name="codecpp" rows="10" cols="60" ><%=algo.getAlgoCodeCplus()%></textarea></div></div>
                        <div class="modifyleft"><div>Code JS:  </div> <div><textarea name="codejs" rows="10" cols="60" ><%=algo.getAlgoCodeJS()%></textarea></div></div>
                        <div class="modifyright"><div>Description: </div> <div><textarea id="description" name="description" rows="10" cols="60" ><%=algo.getAlgoDescription()%></textarea></div></div>
                        <br>
                        <div class="modifyleftlast">
                            <input id="but" type="submit" value="Save">
                        </div>
                    </form>
                    <div class="modifyrightlast">

                        <form style="display: inline-block" method="POST" action="manage" onsubmit="return confirm('<%=action%> this algorithm?');">
                            <input id="but" type="submit" <%if (algo.getDeleted() == 1) {%>value="Restore"<%} else {%>value="Delete"<%}%>>
                            <input type="hidden" name="managetype" <%if (algo.getDeleted() == 1) {%>value="restorealgo"<%} else {%>value="deletealgo"<%}%>>
                            <input type="hidden" name="algoid" value="<%=algo.getAlgoID()%>" >
                        </form>
                        <a href="admin?category=algorithm"><button id="but1">Back</button></a>
                    </div>
                    <br>

                    <script>
                        document.getElementById("selectcategory").selectedIndex = <%=algo.getCategoryID()%> - 1;
                    </script>
                    <%}%>
                </div>
            </div>
            <%@include file="footer.jsp" %>    
        </div>


    </body>
    <script>
        function changeCategory(element) {
            document.getElementById("inputcategory").value = element.options[element.selectedIndex].value;
        }

        function validate() {
            let namevalue = document.getElementById("algoname").value.trim();
            let descriptionvalue = document.getElementById("description").value.trim();
            if (namevalue === "") {
                alert('Name can not be empty!');
                return false;
            } else if (descriptionvalue === "") {
                alert('Description can not be empty!');
                return false;
            } else {
                return confirm('Do you really want to save change?');
            }
        }

    </script>
</html>
