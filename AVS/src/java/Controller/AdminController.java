/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Algorithm;
import Model.History;
import Model.News;
import Model.Tracking;
import Model.User;
import DAO.AlgorithmDAO;
import DAO.HistoryDAO;
import DAO.NewsDAO;
import DAO.TrackingDAO;
import DAO.UserDAO;
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
            String username = "";
            for (Cookie ck : cookie) {
                if (ck.getName().equals("roleid")) {
                    roleid = ck.getValue();
                }
                if (ck.getName().equals("username")) {
                    username = ck.getValue();
                }
            }
            int adminrolenumber = 1;
            if (roleid == null || roleid.equals("") || Integer.parseInt(roleid) != adminrolenumber) {
                response.sendRedirect("home");
                return;
            }
            //ket thuc kiem tra
            String category = request.getParameter("category");
            if (category == null) {
                category = "account";
            }

            int page;
            if (request.getParameter("page") == null) {
                page = 1;
            } else {
                page = Integer.parseInt(request.getParameter("page"));
            }
            int rowperpage = 10;
            int start = rowperpage * (page - 1) + 1;
            int end = rowperpage * page;
            switch (category) {
                case "account": {
                    UserDAO userdao = new UserDAO();
                    ArrayList<User> userlist = userdao.getAllUser();

                    String searchstring = request.getParameter("searchtxt");
                    String columnname = request.getParameter("columnname");
                    String sortorder = request.getParameter("sortorder");

                    if (searchstring == null) {
                        searchstring = "";
                    }
                    if (columnname == null || columnname.isEmpty()) {
                        columnname = "n.user_id";
                    }
                    if (sortorder == null || sortorder.isEmpty()) {
                        sortorder = "ASC";
                    }

                    userlist = userdao.getPagingSearchUser(searchstring, columnname, sortorder, start, end);

                    int totalpage = (int) Math.ceil((double) userdao.getAllSearchUser(searchstring) / rowperpage);

                    request.setAttribute("totalpage", totalpage);
                    request.setAttribute("searchstring", searchstring);
                    request.setAttribute("columnname", columnname);
                    request.setAttribute("sortorder", sortorder);
                    request.setAttribute("userlist", userlist);
                    request.setAttribute("category", category);
                    request.getRequestDispatcher("view/manage_account.jsp").forward(request, response);

                    break;
                }
                case "algorithm": {
                    AlgorithmDAO algodao = new AlgorithmDAO();
                    String searchstring = request.getParameter("searchtxt");
                    String deleted = request.getParameter("showdeleted");
                    String columnname = request.getParameter("columnname");
                    String sortorder = request.getParameter("sortorder");

                    if (searchstring == null) {
                        searchstring = "";
                    }
                    if (deleted != null) {
                        deleted = "showdeleted";
                    }
                    if (columnname == null || columnname.isEmpty()) {
                        columnname = "algo_id";
                    }
                    if (sortorder == null || sortorder.isEmpty()) {
                        sortorder = "ASC";
                    }

                    ArrayList<Algorithm> algolist = new ArrayList();
                    algolist = algodao.getPagingSearchAlgo(searchstring, deleted, columnname, sortorder, start, end);

                    int totalpage = (int) Math.ceil((double) algodao.getAllSearchAlgo(searchstring, deleted) / rowperpage);

                    request.setAttribute("totalpage", totalpage);
                    request.setAttribute("showdeleted", deleted);
                    request.setAttribute("searchstring", searchstring);
                    request.setAttribute("columnname", columnname);
                    request.setAttribute("sortorder", sortorder);
                    request.setAttribute("algolist", algolist);
                    request.setAttribute("category", category);
                    request.getRequestDispatcher("view/manage_algorithm.jsp").forward(request, response);

                    break;
                }
                case "news": {
                    NewsDAO newsdao = new NewsDAO();
                    ArrayList<News> newslist = new ArrayList();
                    String searchstring = request.getParameter("searchtxt");
                    String deleted = request.getParameter("showdeleted");
                    String columnname = request.getParameter("columnname");
                    String sortorder = request.getParameter("sortorder");

                    if (searchstring == null) {
                        searchstring = "";
                    }
                    if (deleted != null) {
                        deleted = "showdeleted";
                    }
                    if (columnname == null || columnname.isEmpty()) {
                        columnname = "news_ID";
                    }
                    if (sortorder == null || sortorder.isEmpty()) {
                        sortorder = "ASC";
                    }

                    newslist = newsdao.getPagingSearchNews(searchstring, deleted, columnname, sortorder, start, end);

                    int totalpage = (int) Math.ceil((double) newsdao.getAllSearchNews(searchstring, deleted) / rowperpage);

                    request.setAttribute("totalpage", totalpage);
                    request.setAttribute("showdeleted", deleted);
                    request.setAttribute("searchstring", searchstring);
                    request.setAttribute("columnname", columnname);
                    request.setAttribute("sortorder", sortorder);
                    request.setAttribute("newslist", newslist);
                    request.setAttribute("category", category);
                    request.getRequestDispatcher("view/manage_news.jsp").forward(request, response);

                    break;
                }

                case "user_history": {
                    HistoryDAO historydao = new HistoryDAO();
                    ArrayList<History> historylist = historydao.getPagingUserHistory(start, end);

                    int totalpage = (int) Math.ceil((double) historydao.getTotalUsersHistory() / rowperpage);

                    category = "history";

                    request.setAttribute("totalpage", totalpage);
                    request.setAttribute("historylist", historylist);
                    request.setAttribute("category", category);
                    request.setAttribute("historytype", "user_history");
                    request.getRequestDispatcher("view/manage_history.jsp").forward(request, response);

                    break;
                }

                case "algo_history": {
                    HistoryDAO historydao = new HistoryDAO();
                    ArrayList<History> historylist = historydao.getPagingAlgoHistory(start, end);

                    int totalpage = (int) Math.ceil((double) historydao.getTotalAlgoHistory() / rowperpage);

                    category = "history";

                    request.setAttribute("totalpage", totalpage);
                    request.setAttribute("historylist", historylist);
                    request.setAttribute("category", category);
                    request.setAttribute("historytype", "algo_history");
                    request.getRequestDispatcher("view/manage_history.jsp").forward(request, response);

                    break;
                }

                case "news_history": {
                    HistoryDAO historydao = new HistoryDAO();
                    ArrayList<History> historylist = historydao.getPagingNewsHistory(start, end);

                    int totalpage = (int) Math.ceil((double) historydao.getTotalNewsHistory() / rowperpage);

                    category = "history";

                    request.setAttribute("totalpage", totalpage);
                    request.setAttribute("historylist", historylist);
                    request.setAttribute("category", category);
                    request.setAttribute("historytype", "news_history");
                    request.getRequestDispatcher("view/manage_history.jsp").forward(request, response);

                    break;
                }
                case "tracking": {
                    int daysago;
                    if (request.getParameter("daystracking") == null || request.getParameter("daystracking").equals("")) {
                        daysago = 1; 
                    } else {
                        daysago = Integer.parseInt(request.getParameter("daystracking")); //1 là trong 24h qua, 7 là trong 1 tuần qua, 30 là trong 1 tháng qua
                    }
                    
                    TrackingDAO trackingdao = new TrackingDAO();
                    ArrayList<Tracking> trackinglist = trackingdao.getPagingTrackingHistory(start, end, daysago);
                    int totalpage = (int) Math.ceil((double) trackingdao.getTotalTrackingHistory(daysago) / rowperpage);
                    request.setAttribute("daystracking", "" + daysago);
                    request.setAttribute("totalpage", totalpage);
                    request.setAttribute("trackinglist", trackinglist);
                    request.setAttribute("category", category);
                    request.getRequestDispatcher("view/manage_tracking.jsp").forward(request, response);
                    break;
                }

                default: {
                    response.sendRedirect("error");
                }
            }

        } catch (Exception ex) {
            response.sendRedirect("error?error=" + ex);
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
