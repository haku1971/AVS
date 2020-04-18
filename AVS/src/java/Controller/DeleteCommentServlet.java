/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;


import Model.CommentModel;
import java.io.IOException;
import java.io.PrintWriter;
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
public class DeleteCommentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TestServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TestServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String commentid = request.getParameter("commentid");
            String commentcontentedit = request.getParameter("commentcontentedit");

            System.out.println(commentid +"va"+ commentcontentedit);
            CommentModel commentmodel = new CommentModel();
            Cookie cookie[] = request.getCookies();
            int age = cookie[0].getMaxAge();
            String username = "";
            String id_of_user = "";

            for (Cookie ck : cookie) {
                if (ck.getName().equals("username")) {
                    username = ck.getValue();
                }
                if (ck.getName().equals("userid")) {
                    id_of_user = ck.getValue();
                }
                if (age == 0) {
                    username = "";
                }
            }
            //check chua dang nhap thi ve home
            if (username.equals("")) {
                response.sendRedirect("HomeController");
                return;
            }
           // int userid = convertStringToInt(id_of_user);
            if(request.getParameter("newsid")!= null &&request.getParameter("commentid")!= null ) {
                //xoa comment la xoa ca vote
                commentmodel.adDeleteLikeCommentBycommentId(Integer.parseInt(commentid));
                commentmodel.deleteCommentById(Integer.parseInt(commentid));
            }
            
            
            commentmodel.editCommentById(commentcontentedit, Integer.parseInt(commentid));
        } catch (Exception ex) {
            Logger.getLogger(DeleteCommentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
