/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Comment;
import Model.News;
import Model.Likecomment;
import Model.Likenews;
import Model.User;
import DAO.CommentModel;
import DAO.NewsModel;
import DAO.UserModel;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
                String username = "";
        if (request.getCookies() != null) {
            Cookie cookie[] = request.getCookies();
            int agecookie = cookie[0].getMaxAge();
            int cookienum = 0;
            while (cookienum < cookie.length) {
                
                if (cookie[cookienum].getName().equals("username")) {
                    username = cookie[cookienum].getValue();
                }
                cookienum++;
            }
           
        }
            if (username.equals("anon")) {
                
                response.sendRedirect("/AVS/inputusername");
            } else {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html; charset=UTF-8");
            int newsid = Integer.parseInt(request.getParameter("id").trim());
            
            if(!username.isEmpty() ) {
                UserModel usermodel = new UserModel();
                User user = usermodel.getUserByUsername(username);
                request.setAttribute("banstatus", user.getBanstatus());
            }
            NewsModel newmodeldao = new NewsModel();
            CommentModel commentmodel = new CommentModel();
            News news = newmodeldao.getNewsByID(newsid);
            if(news == null || news.getDeleted()== 1) {
                request.setAttribute("errorstring", "Don't have this news page or this page had been deleted");
                 request.getRequestDispatcher("view/error.jsp").forward(request, response);
                 return;
            }
            //get ra số lượng like của news
           ArrayList<Likenews> listalllikenewsbynewsid= newmodeldao.getTotalLikeNewsByNewsId(newsid);
          
           int total_likenews= listalllikenewsbynewsid.size();
            request.setAttribute("listalllikenewsbynewsid", listalllikenewsbynewsid);
            request.setAttribute("total_likenews", total_likenews);
            
            ArrayList<Comment> listallcommentbynewid = commentmodel.getAllCommentByNewsID(newsid);

            HashMap<Integer, Integer> commentid_and_numberof_like = new HashMap<>();
           
            for (int i = 0; i < listallcommentbynewid.size(); i++) {
                int commentid= listallcommentbynewid.get(i).getCommentid();
                int number_of_like = commentmodel.getTotalLikecommentByCommentId(commentid).size();
                commentid_and_numberof_like.put(commentid,number_of_like);
                
            }
            ArrayList<Likecomment> listallvote= commentmodel.getAllLikeComment();
            request.setAttribute("listallvote", listallvote);
            request.setAttribute("commentid_and_numberof_like", commentid_and_numberof_like);
            request.setAttribute("news", news);
            request.setAttribute("listallcommentbynewid", listallcommentbynewid);
            
            request.getRequestDispatcher("view/newsdetail.jsp").forward(request, response);
        } catch (Exception ex) {
             request.setAttribute("errorstring", "Don't have this news page");
             request.getRequestDispatcher("view/error.jsp").forward(request, response);
        }}
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
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");
            CommentModel commentmodel = new CommentModel();
            String newid = request.getParameter("id");
            int newsid = convertStringToInt(newid);
            String comment = "";
            String strdate = "";
            
            //lay cookies nguoi dang nhap
            Cookie cookie[] = request.getCookies();
            int age = cookie[0].getMaxAge();
            String username = "";
            String userid = "";
            String roleid = "";
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
            if (username.equals("")) {
                response.sendRedirect("HomeController");
                return;
            }
            NewsModel newmodeldao = new NewsModel();
            News news = newmodeldao.getNewsByID(newsid);
            if(news == null || news.getDeleted()== 1) {
                request.setAttribute("errorstring", "Don't have this news page or this page had been deleted");
                 request.getRequestDispatcher("view/error.jsp").forward(request, response);
                 return;
            }
            int usersid = Integer.parseInt(userid);
            //tao ra comment
            String posttodb = request.getParameter("postodb");
            if (posttodb != null) {
                comment = request.getParameter("commentcontent");
                strdate = request.getParameter("strdate");
                commentmodel.saveCommenttoDB(comment.trim(), strdate, usersid, newsid);
                response.sendRedirect("newsdetail?id=" + newsid);              
            }

        } catch (Exception ex) {
            System.out.println(ex);
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
