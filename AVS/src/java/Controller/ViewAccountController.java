/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.User;
import DAO.AlgorithmDAO;
import DAO.JobsDAO;
import DAO.UserDAO;
import Model.Jobs;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "ViewAccount", urlPatterns = {"/viewaccount"})
public class ViewAccountController extends HttpServlet {

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
            UserDAO userdao = new UserDAO();
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
            String userid = request.getParameter("id");
            User user = userdao.getUserByUserID(userid);
            String category = "account";

            JobsDAO jobDao = new JobsDAO();
            Jobs job = jobDao.getJobByID(user.getJob());
            String jobname = job.getJobname();

            request.setAttribute("category", category);
            request.setAttribute("user", user);
            request.setAttribute("jobname", jobname);
            request.getRequestDispatcher("view/viewaccount.jsp").forward(request, response);

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
