
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="Model.Likenews"%>
<%@page import="Model.Likecomment"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="Model.News"%>
<%@page import="Model.Comment"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            ArrayList<Comment> listallcommentbynewid = (ArrayList<Comment>) request.getAttribute("listallcommentbynewid");
            News news = (News) request.getAttribute("news");
            HashMap<Integer, Integer> commentid_and_numberof_like = (HashMap<Integer, Integer>) request.getAttribute("commentid_and_numberof_like");
            ArrayList<Likecomment> listallvote = (ArrayList<Likecomment>) request.getAttribute("listallvote");
            ArrayList<Likenews> listalllikenewsbynewsid = (ArrayList<Likenews>) request.getAttribute("listalllikenewsbynewsid");
            int total_likenews = (Integer) request.getAttribute("total_likenews");
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=news.getNewstittles()%></title>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <script src="https://kit.fontawesome.com/5a03b2ca60.js" crossorigin="anonymous"></script>          


        <%@include file="header.jsp" %> 
        <style>
            .hiddeninputtag{
                display: none;
            }
            .show {
                margin-left: 5px;
                display: block;
                overflow: auto;
                border:solid 1px;
                width:400px;
                height: 50px;
            }
            .likecounter1{           
                pointer-events:none;
                border: none;
                width: auto;
                background-color: #edf0f4;
                height: 15px;
                text-align: left;
                font-family: cursive;
                font-weight: bold;
            }

            .likecounter1a{           
                pointer-events:none;
                border: none;
                background-color: #edf0f4;
                font-family: cursive;
                font-weight: bold;
                margin-top: 15px;
                float: left;

            }

            .likecounter2{           
                pointer-events:none;
                border: none;
                width: auto;
                background-color: #edf0f4;
                height: 15px;
                margin-left: 20px;
            }

            .likecounter2b{        
                display: inline-block;
                pointer-events:none;
                border: none;
                width: 10px;
                background-color: #edf0f4;
                height: 15px;
                /*margin-left: 20px;*/
                margin-bottom: 0px;

            }

            .likecounter2a{           
                pointer-events:none;
                border: none;
                width: auto;
                background-color: #edf0f4;
                height: 15px;
                text-align: center;
                font-family: cursive;
                font-weight: bold;
                margin-top: 30px;
                float: left;
                margin-left: -109px;
            }

            .likecounter2c{           
                pointer-events:none;
                border: none;
                width: auto;
                background-color: #edf0f4;
                height: 15px;

            }

            .likecounter2d{
                pointer-events: none;
                border: none;
                width: auto;
                background-color: #edf0f4;
                height: 15px;
                /* text-align: center; */
                font-family: cursive;
                font-weight: bold;
                margin-top: 21px;
                float: left;
                margin-left: -7px;
            }
            #heart{

                float: left;
            }
            .like_unlike {
                float: left;
                margin-top: 40px;
                position: absolute;
                margin-left: 3px;
            }
            #time_cmt {
                font-size: 10px;
                color: gray;
                margin-bottom: 10px;
                margin-top: 0px;
            }

            .likeicon{
                margin-left: 15px;
            }
        </style>
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
                    userid = "";
                }
            }
        %>




        <%if (request.getAttribute("banstatus") != null) {
                if ((Integer) request.getAttribute("banstatus") == 0) {

        %>
        <div class="main3">
            <div class="news_box">
                <h1 class="news_title">
                    <small><%=news.getNewstittles()%></small>
                </h1>

                <div class="news_content">
                    <div class="detail">
                        <% if (!news.getNews_Imgs().equalsIgnoreCase("")) {%>
                        <img class="news_img" src="<%=news.getNews_Imgs()%>" alt="image"/>
                        <%}%>
                    </div>

                    <p>  <%=news.getNewscontent()%> </p>
                    <div class="subdetail">                       
                        <ul>
                            <li>Time: <%=news.getNewsdaterealease().substring(0, 16)%></li>
                            <li>Create By: <%=news.getUser().getFullname()%></li>
                            <li>Has <%=listallcommentbynewid.size()%> comment in this news</li>
                        </ul>
                    </div>
                    <%

                        boolean thumplikenewsup = false;
                        for (int i = 0; i < listalllikenewsbynewsid.size(); i++) {
                            int likeuserid = listalllikenewsbynewsid.get(i).getUserid();
                            int likenewsid = listalllikenewsbynewsid.get(i).getNewsid();
                            if (likeuserid == Integer.parseInt(userid) && likenewsid == news.getNewsID()) {
                                thumplikenewsup = true;
                                break;
                            }
                        }
                    %>
                    <c:set var = "thumplikenewsup" scope = "session" value = "<%=thumplikenewsup%>"/>
                    <i id="heart" onclick="LikeNewsFunction(this,<%=news.getNewsID()%>,<%=Integer.parseInt(userid)%>)" class= "${thumplikenewsup ?("fas fa-heart fa-2x"):("far fa-heart fa-2x")}"></i>
                    <input class="likecounter1a" id="txtlikenewsnumber" type="text" name="" value="<%=total_likenews%>" readonly/>
                    <div class="like_unlike" id="likenew">${thumplikenewsup ?("Liked"):("Like")}</div> 

                </div>

            </div>
        </div>     
        <script>
            function LikeNewsFunction(thumblikenews, newsid, userid) {
                var numberlikenew = parseInt(document.getElementById('txtlikenewsnumber').value);

                if (thumblikenews.classList.toggle("far")) {

                    $.ajax({
                        type: "post",
                        url: "DeleteLikeCommentController", //this is my servlet
                        data: {userid: userid, newsid: newsid}
                    });
                    document.getElementById('likenew').innerHTML = 'Like';
                    document.getElementById('txtlikenewsnumber').value = numberlikenew - 1;
                }
                if (thumblikenews.classList.toggle("fas")) {

                    $.ajax({
                        type: "post",
                        url: "SaveLikeCommentController", //this is my servlet
                        data: {userid: userid, newsid: newsid}
                    });
                    document.getElementById('likenew').innerHTML = 'Liked';
                    document.getElementById('txtlikenewsnumber').value = numberlikenew + 1;
                }
            }
        </script>


        <% if (!listallcommentbynewid.isEmpty()) {
                for (int i = 0; i < listallcommentbynewid.size(); i++) {
                    int commentid = listallcommentbynewid.get(i).getCommentid();
                    int numberlike = commentid_and_numberof_like.get(commentid).intValue();
                    boolean thumbup = false;
                    for (int j = 0; j < listallvote.size(); j++) {
                        int votecommentid = listallvote.get(j).getCommentid();
                        int voteuserid = listallvote.get(j).getUserid();
                        //ng dang dang nhap tung like roi
                        if (commentid == votecommentid && voteuserid == Integer.parseInt(userid)) {
                            thumbup = true;
                            break;
                        }
                    }
        %>
        <c:set var = "thumpup" scope = "session" value = "<%=thumbup%>"/>
        <c:set var = "conntentofcomment" scope = "session" value = "<%=listallcommentbynewid.get(i).getContent()%>"/>

        <div class="cmt_items" id="<%=i%>">
            <div class="user_name"> <%=listallcommentbynewid.get(i).getUser().getUsername()%></div>
            <div class="cmt_detail" id="content_<%=commentid%>"> <c:out value="${conntentofcomment}"/><%--<%=listallcommentbynewid.get(i).getContent()%> --%></div> 
            <textarea maxlength="300" class="hiddeninputtag" id="txtedit_<%=commentid%>" type="text" name="commentcontentedit" >${conntentofcomment}</textarea>
            <div id="time_cmt" class="cmt_detail"><%= "At: " + listallcommentbynewid.get(i).getDatetime().substring(0, 16)%></div>  
            <i id="like_ulike_cmt" onclick="LikeCommentFunction(this,<%=commentid%>,<%=userid%>)" class= "${thumpup ?("fas fa-heart fa-1x"):("far fa-heart fa-1x")}" style="margin-left:15px;"></i>

            <input  class="likecounter2b" id="numberlike_<%=commentid%>" type="text"  value="<%=numberlike%>" />
            <div class="likeicon" id="like_<%=commentid%>"> ${thumpup ?("Liked"):("Like")}</div>       


            <%
                //là người đang đăng nhập sẽ hiển thị xoá,sửa            
                if (username.equals(listallcommentbynewid.get(i).getUser().getUsername())) {%> 

            <form>            
                <input type="hidden" name="commentid" value="<%=commentid%>" />
                <input  type="hidden" name="newsid" value="<%=news.getNewsID()%>" />                      
            </form>         
            <table>
                <tr> 
                    <td><input class="save_button" id="save_<%=commentid%>" type="submit" name ="save" onclick="savecomment(<%=commentid%>);" value="Save"  /></td>
                    <td>  <input class="cancel_button" id="cancel_<%=commentid%>" type="submit" name ="cancel" onclick="cancel(<%=commentid%>)" value="Cancel" /></td>
                </tr>
                <tr>
                    <td><input class="edit_button" id="edit_<%=commentid%>"  type="submit" name ="Edit" value="Edit" onclick="edit(<%=commentid%>);" />    </td>     
                    <td><input class="delete_button" id="delete_<%=commentid%>" type="submit" name="Delete" value="Delete" onclick="btndelete(<%=i%>,<%=commentid%>,<%=news.getNewsID()%>);"/></td>
                </tr>
            </table>          
            <% } else if (roleid.equals("1")) { // la admin thi co the xoa

            %>
            <table>
                <td><input class="admin_delete" id="delete_<%=commentid%>" type="submit" name="Delete" value="Delete this comment" onclick="btndelete(<%=i%>,<%=commentid%>,<%=news.getNewsID()%>);"/></td>
            </table>
            <% }%>

            <script>
                var checkedit = 0;
                setSaveButtonStatus(<%=commentid%>, 'none');
                setCancelButtonStatus(<%=commentid%>, 'none');
                //   setTxteditStatus(<%=commentid%>, 'hidden');

                $('#txtedit_<%=commentid%>').keyup(function () {
                    // Get the Login Name value and trim it
                    var name = $('#txtedit_<%=commentid%>').val().trim();

                    // Check if empty of not
                    if (name.length < 1) {
                        $("#save_<%=commentid%>").attr("disabled", true);
                    } else {
                        $("#save_<%=commentid%>").attr("disabled", false);
                    }
                });
                function LikeCommentFunction(thumb, commentid, userid) {

                    var numberlike = parseInt(document.getElementById('numberlike_' + commentid).value);
                    if (thumb.classList.toggle("far")) {

                        $.ajax({
                            type: "post",
                            url: "DeleteLikeCommentController", //this is my servlet
                            data: {userid: userid, commentid: commentid}
                        });

                        document.getElementById('numberlike_' + commentid).value = numberlike - 1;
                        document.getElementById('like_' + commentid).innerHTML = 'Like';
                    }
                    if (thumb.classList.toggle("fas")) {

                        $.ajax({
                            type: "post",
                            url: "SaveLikeCommentController", //this is my servlet
                            data: {userid: userid, commentid: commentid}
                        });

                        document.getElementById('numberlike_' + commentid).value = numberlike + 1;
                        document.getElementById('like_' + commentid).innerHTML = 'Liked';
                    }
                }


                function edit(commentid) {
                    if (checkedit === 0) {
                        checkedit = 1;

                        document.getElementById("txtedit_" + commentid).className = "show";

                        setDeleteButtonStatus(commentid, "none");
                        // setTxteditStatus(commentid, "visible");
                        setSaveButtonStatus(commentid, 'block');
                        setCancelButtonStatus(commentid, "block");
                        setEditButtonStatus(commentid, "none");
                        document.getElementById('content_' + commentid).style.display = 'none';
                    }
                }
                function btndelete(divpositiontodelete, commentid, newsid) {
                    if (confirm('Do you want to delete this comment?')) {
                        setDeleteButtonStatus(commentid, "none");

                        $.ajax({
                            type: "post",
                            url: "DeleteCommentServlet", //this is my servlet
                            data: {newsid: newsid, commentid: commentid}
                        });
                        var divdelete = document.getElementById(divpositiontodelete);
                        divdelete.remove();
                    } else {
                        event.preventDefault()
                    }


                }

                function setSaveButtonStatus(btn_position, status) {
                    document.getElementById('save_' + btn_position).style.display = status;
                }
                function setCancelButtonStatus(btn_position, status) {
                    document.getElementById('cancel_' + btn_position).style.display = status;
                }
                function setTxteditStatus(btn_position, status) {
                    document.getElementById("txtedit_" + btn_position).style.visibility = status;
                }
                function setDeleteButtonStatus(btn_position, status) {
                    document.getElementById('delete_' + btn_position).style.display = status;
                }
                function setEditButtonStatus(btn_position, status) {
                    document.getElementById('edit_' + btn_position).style.display = status;
                }
                function cancel(commentid) {
                    document.getElementById("txtedit_" + commentid).className = "hiddeninputtag";
                    setDeleteButtonStatus(commentid, 'block');
                    //  setTxteditStatus(commentid, 'hidden');
                    setSaveButtonStatus(commentid, 'none');
                    setCancelButtonStatus(commentid, "none");
                    setEditButtonStatus(commentid, 'block');
                    //  document.getElementById("txtedit_" + commentid).value= content;
                    document.getElementById('content_' + commentid).style.display = 'block';
                    checkedit = 0;
                }
                function escapeHtml(unsafe) {
                    return unsafe
                            .replace(/&/g, "&amp;")
                            .replace(/</g, "&lt;")
                            .replace(/>/g, "&gt;")
                            .replace(/"/g, "&quot;")
                            .replace(/'/g, "&#039;");
                }
              
                function savecomment(commentid) {
                    document.getElementById("txtedit_" + commentid).className = "hiddeninputtag";
                    checkedit = 0;
                    setSaveButtonStatus(commentid, "none");
                    setDeleteButtonStatus(commentid, "block");
                    //  setTxteditStatus(commentid, "hidden");
                    setCancelButtonStatus(commentid, "none");
                    setEditButtonStatus(commentid, "block");
                    //var txt_edit_content = document.getElementById("txtedit_" + commentid).value;
                    var txt_edit_content = $('#txtedit_' + commentid).val().trim().replace("\\s+", " ");

                    if (txt_edit_content === "") {
                        $('#save_' + commentid).attr("disabled", true);
                    } else {
                        if (confirm('Do you want to save this change?')) {
                            $('#save_' + commentid).attr("disabled", false);
                            document.getElementById('content_' + commentid).innerHTML = escapeHtml(txt_edit_content);
                            document.getElementById('content_' + commentid).style.display = 'block';
                            $.ajax({
                                type: "post",
                                url: "DeleteCommentServlet",
                                data: {commentcontentedit: txt_edit_content, commentid: commentid},
                                success: function (msg) {
                                    $('#output').append(msg);
                                }
                            });
                        } else {
                            cancel(commentid);
                            event.preventDefault();
                        }
                    }
                }
            </script>
        </div>

        <!--check nguoi dang dang nhap co nhung comment nao -->

        <%  }
        } else { //chua co comment nao

        %>
        <span class="let_first">
            <%= "Don't have any comment. let be the first comment!!! "%>
        </span>
        <%}
        %>

        <div>
            <form  class ="comment_content" method="POST" action="newsdetail">
                <%DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd  HH:mm:ss");
                    LocalDateTime now = LocalDateTime.now();
                    String strdate = dtf.format(now);
                %>
                <input type="hidden" name="strdate" value="<%=strdate%>" />
                <input type="hidden" name="id" value="<%=news.getNewsID()%> " />
                <textarea maxlength="300" class="textarea_cmt" id="txtsavedb" width="500"  name="commentcontent" placeholder="Type your think....."></textarea>
                <input class="post_button" type="submit" id="postcomment" onclick="checkContentIsEmpty()" name="postodb" value="Post comment" />       
            </form>
        </div>

        <script>
                function checkContentIsEmpty() {
                    if ($('#txtsavedb').val().trim() === "") {

                        $('#postcomment').attr("disabled", true);
                    } else {
                        $('#postcomment').attr("disabled", false);
                    }
                }
                $('#txtsavedb').keyup(function () {
                    // Get the Login Name value and trim it
                    var name = $('#txtsavedb').val().trim();
                    // Check if empty of not
                    if (name.length < 1) {
                        $('#postcomment').attr("disabled", true);
                    } else {
                        $('#postcomment').attr("disabled", false);
                    }
                }
                );

        </script>

        <%} else {%>
        <%-- From herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre --%>
        <div class="main3">
            <div class="news_box">
                <h1 class="news_title">
                    <small><%=news.getNewstittles()%></small>
                </h1>

                <div class="news_content">
                    <div class="detail">
                        <% if (!news.getNews_Imgs().equalsIgnoreCase("")) {%>
                        <img class="news_img" src="<%=news.getNews_Imgs()%>" alt="image"/>
                        <%}%>

                    </div>

                    <p>  <%=news.getNewscontent()%> </p>
                    <div class="subdetail">                       
                        <ul>
                            <li>Time: <%=news.getNewsdaterealease()%></li>
                            <li>Create By:<%=news.getUser().getFullname()%></li>
                            <li>Has <%=listallcommentbynewid.size()%> comment in this news</li>
                        </ul>
                    </div>
                    <%
                        boolean thumplikenewsup = false;
                        if (listalllikenewsbynewsid.size() > 0) {
                            thumplikenewsup = true;
                        }
                    %>
                    <c:set var = "thumplikenewsup" scope = "session" value = "<%=thumplikenewsup%>"/>
                    <i id="heart" class= "${thumplikenewsup ?("fas fa-heart fa-2x"):("far fa-heart fa-2x")}"></i>            
                    <input class="likecounter2a"  type="text" name="" value="<%=total_likenews%>" />


                </div>
            </div>
        </div>             
        <% if (!listallcommentbynewid.isEmpty()) {
                for (int i = 0; i < listallcommentbynewid.size(); i++) {
                    int commentid = listallcommentbynewid.get(i).getCommentid();
                    int numberlike = commentid_and_numberof_like.get(commentid).intValue();
                    boolean thumbup = false;

                    //ng dang dang nhap tung like roi
                    if (numberlike > 0) {
                        thumbup = true;
                    }

        %>
        <c:set var = "conntentofcomment" scope = "session" value = "<%=listallcommentbynewid.get(i).getContent()%>"/>
        <c:set var = "thumpup" scope = "session" value = "<%=thumbup%>"/>   
        <div class="comment_content">                            
            <div class="user_name"> <%=listallcommentbynewid.get(i).getUser().getUsername()%></div>
            <%--  <div><%=listallcommentbynewid.get(i).getContent()%> </div> --%>
            <div class="cmt_detail" id="content_<%=commentid%>"> <c:out value="${conntentofcomment}"/> </div>
            <div id="time_cmt"><%= "At: " + listallcommentbynewid.get(i).getDatetime().substring(0, 16)%></div>  
            <i  class= "${thumpup ?("fas fa-heart fa-1x"):("far fa-heart fa-1x")}"></i>             
            <input class="likecounter2c"  type="text"  value="<%=numberlike%>" />
        </div>

        <% } //hien thi tung comment
            } //neu mang comment > 0 %>
        <span class="let_first">
            <%= "You are restricted!!! "%>
        </span>
        <%  } // else cua check nguoi bi ban
        } else {    //else nay la khach%>
        <div class="main3">
            <div class="news_box">
                <h1 class="news_title">
                    <small><%=news.getNewstittles()%></small>
                </h1>

                <div class="news_content">
                    <div class="detail">
                        <% if (!news.getNews_Imgs().equalsIgnoreCase("")) {%>
                        <img class="news_img" src="<%=news.getNews_Imgs()%>" alt="image"/>
                        <%}%>
                    </div>

                    <p>  <%=news.getNewscontent()%> </p>
                    <div class="subdetail">                       
                        <ul>
                            <li>Time: <%=news.getNewsdaterealease()%></li>
                            <li>Create By:<%=news.getUser().getFullname()%></li>
                            <li>Has <%=listallcommentbynewid.size()%> comment in this news</li>
                        </ul>
                    </div>
                    <%
                        boolean thumplikenewsup = false;
                        if (listalllikenewsbynewsid.size() > 0) {
                            thumplikenewsup = true;
                        }
                    %>
                    <c:set var = "thumplikenewsup" scope = "session" value = "<%=thumplikenewsup%>"/>
                    <i id="heart" class= "${thumplikenewsup ?("fas fa-heart fa-2x"):("far fa-heart fa-2x")}"></i>            
                    <input class="likecounter2d"  type="text" name="" value="<%=total_likenews%>" />


                </div>
            </div>
        </div>             
        <% if (!listallcommentbynewid.isEmpty()) {
                for (int i = 0; i < listallcommentbynewid.size(); i++) {
                    int commentid = listallcommentbynewid.get(i).getCommentid();
                    int numberlike = commentid_and_numberof_like.get(commentid).intValue();
                    boolean thumbup = false;

                    //ng dang dang nhap tung like roi
                    if (numberlike > 0) {
                        thumbup = true;
                    }

        %>
        <c:set var = "conntentofcomment" scope = "session" value = "<%=listallcommentbynewid.get(i).getContent()%>"/>
        <c:set var = "thumpup" scope = "session" value = "<%=thumbup%>"/>   
        <div class="comment_content">
            <div class="user_name"> <%=listallcommentbynewid.get(i).getUser().getUsername()%></div>
            <%--  <div><%=listallcommentbynewid.get(i).getContent()%> </div> --%>
            <div class="cmt_detail" id="content_<%=commentid%>"> <c:out value="${conntentofcomment}"/> </div>
            <div id="time_cmt"><%= "At: " + listallcommentbynewid.get(i).getDatetime().substring(0, 16)%></div>  
            <i  class= "${thumpup ?("fas fa-heart fa-1x"):("far fa-heart fa-1x")}"></i>             
            <input class="likecounter2c"  type="text"  value="<%=numberlike%>" />
        </div>

        <%} //hien thi tung comment
                } //neu mang comment > 0
            }
        %>

        <%-- to herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre --%>
        <%@include file="footer.jsp" %>  
    </body>
</html>
