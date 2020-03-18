/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Entity.Comment;
import Entity.News;
import Model.CommentModel;
import Model.NewModel;
import Model.UserModel;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author quang
 */
public class CommentController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int newsid = Integer.parseInt(request.getParameter("newsid"));

            NewModel newmodeldao = new NewModel();
            CommentModel commentmodel = new CommentModel();
            News news = newmodeldao.getNewByNewsID(newsid);
            ArrayList<Comment> listallcommentbynewid = commentmodel.getAllCommentByNewsID(newsid);
            request.setAttribute("news", news);
            request.setAttribute("listallcommentbynewid", listallcommentbynewid);
            request.getRequestDispatcher("jsp/newsdetail.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(CommentController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    static int convertStringToInt(String number) {
        double doublenumber = Double.parseDouble(number);
        return (int) doublenumber;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            response.setContentType("text/html;charset=UTF-8");
            CommentModel commentmodel = new CommentModel();
            String newid = request.getParameter("newsid");
            int newsid = convertStringToInt(newid);
            String comment = "";
            String strdate = "";

          //lay cookies nguoi dang nhap
            Cookie cookie[] = request.getCookies();
            int age = cookie[0].getMaxAge();
            String username = "";
            String userid = "";
            String roleid= "";
            for (Cookie ck : cookie) {
                if (ck.getName().equals("username")) {
                    username = ck.getValue();
                }
                if (ck.getName().equals("roleid")) {
                    roleid = ck.getValue();
                }
                if (ck.getName().equals("userid")) {
                    userid = ck.getValue();
                }
                if (age == 0) {
                    username = "";
                }
            }
       
            //check chua dang nhap thi ve home
            
            if(username.equals("")) {
                response.sendRedirect("HomeController");
                return;
            }
            int usersid = Integer.parseInt(userid);
            //tao ra comment
            String posttodb = request.getParameter("postodb");
            if (posttodb != null) {
                comment = request.getParameter("commentcontent");
                strdate = request.getParameter("strdate");
                commentmodel.saveCommenttoDB(comment, strdate, usersid, newsid);             
                response.sendRedirect("CommentController?newsid=" + newsid);
                return;
            }
          
        } catch (Exception ex) {
            Logger.getLogger(CommentController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
