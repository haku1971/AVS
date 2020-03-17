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
            Cookie cookie[] = request.getCookies();
            int age = cookie[0].getMaxAge();
            String username = "";
            String userid = "";

            for (Cookie ck : cookie) {
                if (ck.getName().equals("username")) {
                    username = ck.getValue();
                }
                if (ck.getName().equals("userid")) {
                    userid = ck.getValue();
                }
                if (age == 0) {
                    username = "";
                }
            }
        %>
        <%="id cua duong la:" + userid%>

        <%
            ArrayList<Comment> listallcommentbynewid = (ArrayList<Comment>) request.getAttribute("listallcommentbynewid");
            News news = (News) request.getAttribute("news");
        %>

        <p>Title: <%=news.getNewtittles()%> </p>
        <p>Content: <%=news.getNewcontent()%> <br>
        <hr>
        <% if (!listallcommentbynewid.isEmpty()) { %>
        <% for (int i = 0; i < listallcommentbynewid.size(); i++) {
                int commentid = listallcommentbynewid.get(i).getCommentid();
        %>
        <br><hr>
        <div id="<%=i%>">
            <%= "User " + listallcommentbynewid.get(i).getUser().getUsername()%>
            <p id="<%=commentid%>">   
                <%=listallcommentbynewid.get(i).getContent()%> 
            </p> 

            <br>
            <div> <%= "Vào lúc: " + listallcommentbynewid.get(i).getDatetime()%></div>

            <% if (username.equals(listallcommentbynewid.get(i).getUser().getUsername())) {%> 

            <form>            
                <input id="txtedit_<%=commentid%>" type="text" name="commentcontentedit" value="<%=listallcommentbynewid.get(i).getContent()%>" />
                <input type="hidden" name="commentid" value="<%=commentid%>" />
                <input  type="hidden" name="newsid" value="<%=news.getNewID()%>" />                      
            </form>
            <input id="save_<%=commentid%>" type="submit" name ="save" onclick="savecomment(<%=commentid%>);" value="Save"  />
            <input id="cancel_<%=commentid%>" type="submit" name ="cancel" onclick="cancel(<%=commentid%>)" value="Cancel" />
            <input id="edit_<%=commentid%>"  type="submit" name ="Edit" value="Edit" onclick="edit(<%=commentid%>);" />   



            <form  method="POST">            
                <input type="hidden" name="commentid" value="<%=commentid%>" />
                <input  type="hidden" name="newsid" value="<%=news.getNewID()%>" />       
            </form>
            <input id="delete_<%=commentid%>" type="submit" name="Delete" value="Delete" onclick="btndelete(<%=i%>,<%=commentid%>,<%=news.getNewID()%>);"/>
        <%--    <% } else if (username.equals("duongph")) {
            %>
            <input id="delete_<%=commentid%>" type="submit" name="Delete" value="Delete" onclick="btndelete(<%=i%>,<%=commentid%>,<%=news.getNewID()%>);"/>
            <% }%>
        --%>
            <script>
                function setSaveButtonStatus(btn_position, status) {
                    document.getElementById('save_' + btn_position).style.visibility = status;
                }
                function setCancelButtonStatus(btn_position, status) {
                    document.getElementById('cancel_' + btn_position).style.visibility = status;
                }
                function setTxteditStatus(btn_position, status) {
                    document.getElementById("txtedit_" + btn_position).style.visibility = status;
                }
                function setDeleteButtonStatus(btn_position, status) {
                    document.getElementById('delete_' + btn_position).style.visibility = status;
                }
                function setEditButtonStatus(btn_position, status) {
                    document.getElementById('edit_' + btn_position).style.visibility = status;
                }

                $('#txtedit_<%=commentid%>').keyup(function () {
                    // Get the Login Name value and trim it
                    var name = $('#txtedit_<%=commentid%>').val();
                    console.log(name);
                    // Check if empty of not
                    if (name.length < 1) {
                        $("#save_<%=commentid%>").attr("disabled", true);
                    } else {
                        $("#save_<%=commentid%>").attr("disabled", false);
                    }
                });


                setSaveButtonStatus(<%=commentid%>, 'hidden');
                setCancelButtonStatus(<%=commentid%>, 'hidden');
                setTxteditStatus(<%=commentid%>, 'hidden');

                function edit(commentid) {
                    setDeleteButtonStatus(commentid, "hidden");
                    setTxteditStatus(commentid, "visible");
                    setSaveButtonStatus(commentid, "visible");
                    setCancelButtonStatus(commentid, "visible");
                    setEditButtonStatus(commentid, "hidden");

                    document.getElementById(commentid).style.visibility = 'hidden';
                }
                function btndelete(divpositiontodelete, commentid, newsid) {
                    $.ajax({
                        type: "post",
                        url: "DeleteCommentServlet", //this is my servlet
                        data: {newsid: newsid, commentid: commentid},
                    });
                    var div = document.getElementById(divpositiontodelete);
                    div.remove();
                }

                function cancel(commentid) {
                    setDeleteButtonStatus(commentid, "visible");
                    setTxteditStatus(commentid, "hidden");
                    setSaveButtonStatus(commentid, "hidden");
                    setCancelButtonStatus(commentid, "hidden");
                    setEditButtonStatus(commentid, "visible");
                    //   document.getElementById("txtedit_" + commentid).value= content;
                    document.getElementById(commentid).style.visibility = 'visible';

                }
            </script>
            <% }%> <!--check nguoi dang dang nhap co comment nao -->
        </div>
        <% }
        } else { //chua co comment nao
            
        %>

        <%= "Don't have any comment. let be the first comment!!! "%>
        <%}
        %>


    <div>
        <form  method="POST" action="CommentController">
            <%Date date = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String strdate = formatter.format(date);
            %>
            <input type="hidden" name="strdate" value="<%=strdate%>" />
            <input type="hidden" name="newsid" value="<%=news.getNewID()%> " />
            <tr><textarea id="txtsavedb" width="500" name="commentcontent"></textarea></tr>
            <input type="submit" id="postcomment" name="postodb" value="Post comment" />       
        </form>
    </div>
    <script>
        $('#txtsavedb').keyup(function () {
            // Get the Login Name value and trim it
            var name = $('#txtsavedb').val();
            console.log(name);
            // Check if empty of not
            if (name.length < 1) {
                console.log(' <1');
                $('#postcomment').attr("disabled", true);
            } else {
                $('#postcomment').attr("disabled", false);
            }
        });
        function savecomment(commentid) {
            setSaveButtonStatus(commentid, "hidden");
            setDeleteButtonStatus(commentid, "visible");
            setTxteditStatus(commentid, "hidden");
            setCancelButtonStatus(commentid, "hidden");
            setEditButtonStatus(commentid, "visible");
            var txt_edit_content = document.getElementById("txtedit_" + commentid).value;
            document.getElementById(commentid).innerHTML = txt_edit_content;
            document.getElementById(commentid).style.visibility = 'visible';
            console.log(txt_edit_content);
            $.ajax({
                type: "post",
                url: "DeleteCommentServlet", //this is my servlet
                data: {commentcontentedit: txt_edit_content, commentid: commentid},
                success: function (msg) {
                    $('#output').append(msg);
                }
            });
        }
    </script>


</body>
</html>
