/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Entity.Algorithm;
import Entity.History;
import Entity.News;
import Entity.User;
import Model.AlgorithmModel;
import Model.HistoryModel;
import Model.NewsModel;
import Model.UserModel;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Ukah
 */
@WebServlet(name = "Admin", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            HttpSession session = request.getSession();

            //hien thi trang home neu nguoi dung khong phai admin
            Cookie cookie[] = request.getCookies();
            String roleid = "";
            for (Cookie ck : cookie) {
                if (ck.getName().equals("roleid")) {
                    roleid = ck.getValue();
                }
            }
            int adminrolenumber = 1;
            if (roleid == null || Integer.parseInt(roleid) != adminrolenumber) {
                response.sendRedirect("home");
                return;
            }
            //ket thuc kiem tra
            String category = request.getParameter("category");
            if (category == null) {
                category = "account";
            }
            switch (category) {
                case "account": {
                    UserModel userdao = new UserModel();
                    ArrayList<User> userlist = userdao.getAllUser();

                    String sortoption = request.getParameter("sortoption");
                    if(sortoption==null) {
                        sortoption = "id";
                    }
                    String sortdirection = request.getParameter("sortdirection");
                    if(sortdirection==null) {
                        sortdirection = "ascending";
                    }
                    request.setAttribute("sortdirection", sortdirection);
                    request.setAttribute("sortoption", sortoption);
                    request.setAttribute("userlist", userlist);
                    request.setAttribute("category", category);
                    request.getRequestDispatcher("jsp/manage_account.jsp").forward(request, response);

                    break;
                }
                case "algorithm": {
                    AlgorithmModel algodao = new AlgorithmModel();
                    ArrayList<Algorithm> algolist = algodao.getAllAlgo();

                    request.setAttribute("algolist", algolist);
                    request.setAttribute("category", category);
                    request.getRequestDispatcher("jsp/manage_algorithm.jsp").forward(request, response);

                    break;
                }
                case "news": {
                    NewsModel newsdao = new NewsModel();
                    ArrayList<News> newslist = newsdao.getAllNews();

                    request.setAttribute("newslist", newslist);
                    request.setAttribute("category", category);
                    request.getRequestDispatcher("jsp/manage_news.jsp").forward(request, response);

                    break;
                }
                
                case "user_history": {
                    HistoryModel historydao = new HistoryModel();
                    ArrayList<History> historylist = historydao.getUserHistory();
                    
                    request.setAttribute("historylist", historylist);
                    request.setAttribute("category", category);
                    request.setAttribute("historytype", "user_history");
                    request.getRequestDispatcher("jsp/manage_history.jsp").forward(request, response);

                    break;
                }
                
                case "algo_history": {
                    HistoryModel historydao = new HistoryModel();
                    ArrayList<History> historylist = historydao.getAlgoHistory();
                    
                    request.setAttribute("historylist", historylist);
                    request.setAttribute("category", category);
                    request.setAttribute("historytype", "algo_history");
                    request.getRequestDispatcher("jsp/manage_history.jsp").forward(request, response);

                    break;
                }
                
                case "news_history": {
                    HistoryModel historydao = new HistoryModel();
                    ArrayList<History> historylist = historydao.getNewsHistory();
                    
                    request.setAttribute("historylist", historylist);
                    request.setAttribute("category", category);
                    request.setAttribute("historytype", "news_history");
                    request.getRequestDispatcher("jsp/manage_history.jsp").forward(request, response);

                    break;
                }

                default: {
                    UserModel userdao = new UserModel();
                    ArrayList<User> userlist = userdao.getAllUser();

                    request.setAttribute("userlist", userlist);
                    request.setAttribute("category", category);
                    request.getRequestDispatcher("jsp/manage_account.jsp").forward(request, response);
                }
            }

        } catch (Exception ex) {
            response.sendRedirect("error");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
