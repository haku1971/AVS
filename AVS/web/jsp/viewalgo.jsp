<%-- 
    Document   : viewalgo
    Created on : Mar 19, 2020, 9:15:51 PM
    Author     : Ukah
--%>

<%@page import="Entity.Category"%>
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
            Algorithm algo = (Algorithm) request.getAttribute("algo");
            Boolean addnew = (Boolean) request.getAttribute("addnew");
            ArrayList<Category> listalgocategory = (ArrayList<Category>) request.getAttribute("listalgocategory");
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

                <div class="algoinfomation">
                    <%if (addnew) {%>
                    <!--trang addnew-->
                    <form method="POST" action="manage" onsubmit="return validate();">
                        <input type="hidden" name="managetype" value="addalgo">

                        <div>Name: </div> <div><input id="algoname" type="text" name="algoname" value=""></div>
                        <div>Code Java:  </div> <div><textarea name="codejava" rows="10" cols="30" ></textarea></div>
                        <div>Code C++:  </div> <div><textarea name="codecpp" rows="10" cols="30" ></textarea></div>
                        <div>Code JS:  </div> <div><textarea name="codejs" rows="10" cols="30" ></textarea></div>
                        <div>Code Visualize:  </div> <div><textarea name="codevisual" rows="10" cols="30" ></textarea></div>
                        <div>Description: </div> <div><textarea id="description" name="description" rows="10" cols="30" ></textarea></div>
                        <div>Resource: </div> <div><input type="text" name="resource" value=""></div>
                        <div>Category: </div> <div>
                            <input type="hidden" name="category" id="inputcategory" value="1">
                            <select id="selectcategory" onchange="changeCategory(this)">
                                <% for (int i = 0; i < listalgocategory.size(); i++) {%>
                                <option value="<%=listalgocategory.get(i).getCategoryID()%>"><%=listalgocategory.get(i).getCategoryName()%></option>
                                <%}%>
                            </select></div>
                        <input type="submit" value="Save">
                    </form>

                    <a href="admin?category=algorithm"><button>Cancel</button></a>

                    <%} else {
                    String action = algo.getDeleted() == 0 ? "Delete" : "Restore";%>
                    <!--trang view-->

                    <div class="algoid">Algorithm ID: <%=algo.getAlgoID()%></div>
                    <div> Added Time: <%=algo.getAlgoDatetime()%></div>

                    <br>
                    <form method="POST" action="manage" onsubmit="return validate();">
                        <input type="hidden" name="managetype" value="editalgo">
                        <input type="hidden" name="algoid" value="<%=algo.getAlgoID()%>" >
                        <div class="modifyleft">
                            <div style="display: inline-block">Name: </div> 
                            <div style="display: block"><input id="algoname" type="text" name="algoname" value="<%=algo.getAlgoName()%>"></div>
                        </div>
                        <div class="modifyright">
                            <div>Category: </div>
                            <div>
                                <input type="hidden" name="category" id="inputcategory" value="<%=algo.getCategoryID()%>">
                                <select id="selectcategory" onchange="changeCategory(this)">
                                    <% for (int i = 0; i < listalgocategory.size(); i++) {%>
                                    <option value="<%=listalgocategory.get(i).getCategoryID()%>"><%=listalgocategory.get(i).getCategoryName()%></option>
                                    <%}%>
                                </select></div>
                        </div>
                        <br>
                        <br>
                        <div class="modifyleft"><div>Code Java:  </div> <div><textarea name="codejava" rows="10" cols="60" ><%=algo.getAlgoCodeJava()%></textarea></div></div>
                        <div class="modifyright"><div>Code C++:  </div> <div><textarea name="codecpp" rows="10" cols="60" ><%=algo.getAlgoCodeCplus()%></textarea></div></div>
                        <br>
                        <div class="modifyleft"><div>Code JS:  </div> <div><textarea name="codejs" rows="10" cols="60" ><%=algo.getAlgoCodeJS()%></textarea></div></div>
                        <div class="modifyright"><div>Code Visualize:  </div> <div><textarea name="codevisual" rows="10" cols="60" ><%=algo.getAlgoCodeVisual()%></textarea></div></div>
                        <br>
                        <div class="modifyleft"><div>Description: </div> <div><textarea id="description" name="description" rows="10" cols="60" ><%=algo.getAlgoDescription()%></textarea></div></div>
                        <div class="modifyrightlast">
                            <div>Resource: </div> <div><input type="text" name="resource" value="<%=algo.getAlgoResource()%>"></div>
                            <input type="submit" value="Save"  >
                        </div>
                    </form>
                    <div>
                        <a href="admin?category=algorithm"><button>Back</button></a>
                        <form method="POST" action="manage" onsubmit="return confirm('<%=action%> this algorithm?');">
                            <input type="hidden" name="managetype" <%if (algo.getDeleted() == 1) {%>value="restorealgo"<%} else {%>value="deletealgo"<%}%>>
                            <input type="hidden" name="algoid" value="<%=algo.getAlgoID()%>" >
                            <input type="submit" <%if (algo.getDeleted() == 1) {%>value="Restore"<%} else {%>value="Delete"<%}%>>
                        </form>
                    </div>
                    <br>

                    <script>
                        document.getElementById("selectcategory").selectedIndex = <%=algo.getCategoryID()%> - 1;
                    </script>
                    <%}%>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>    

    </body>
    <script>
        function changeCategory(element) {
            document.getElementById("inputcategory").value = element.options[element.selectedIndex].value;
        }

        function validate() {

            let namevalue = document.getElementById("algoname").value;
            let descriptionvalue = document.getElementById("description").value;
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
