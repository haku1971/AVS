/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Jobs;
import Model.User;
import DAO.JobsDAO;
import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author BinhNT
 */
@WebServlet(name = "UserinforController", urlPatterns = {"/userinfo"})
public class UserinforController extends HttpServlet {

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
        String username = "";
        String mail = "";
        String fullname = "None";
        String dob = "";
        String sex = "None";
        String phone = "None";
        String workplace = "None";
        String jobname = "";
        String status = "Active";
        String userid="";
        if (request.getCookies() != null) {
            Cookie cookie[] = request.getCookies();
            int agecookie = cookie[0].getMaxAge();
            int cookienum = 0;
            while (cookienum < cookie.length) {
                if (cookie[cookienum].getName().equals("username")) {
                    username = cookie[cookienum].getValue();
                }
                if (cookie[cookienum].getName().equals("userid")) {
                    userid = cookie[cookienum].getValue();
                }
                cookienum++;
            }
            if (agecookie == 0) {
                username = "";
            }
            if (username.equals("")) {
                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Account was logged out');");
                out.println("</script>");
                response.setHeader("Refresh", "1;url=/AVS/home");
            }else if (username.equals("anon")) {
                response.sendRedirect("/AVS/inputusername");
            }else{
            try {
                UserDAO userDao;
                userDao = new UserDAO();
                User user = userDao.getUserByUsername(username);
                mail = user.getMail();
                if (user.getFullname().length() > 0) {
                    fullname = user.getFullname();
                }

                    dob=user.getDob();
                int gender = user.getGender();
                if (gender == 1) {
                    sex = "Male";
                } else if (gender == 0) {
                    sex = "Female";
                }
                if (user.getPhone().length() > 0) {
                    phone = user.getPhone();
                }
                if (user.getWorkplace().length() > 0) {
                    workplace = user.getWorkplace();
                }
                int jobid = user.getJob();
                JobsDAO jobDao= new JobsDAO();
               Jobs job = jobDao.getJobByID(jobid);
               jobname = job.getJobname();
            if (user.getBanstatus() == 1) {
                status = "Ban";
            }
                System.out.println(user.getPassword());
                if (user.getPassword().equals("null")) {
                    HttpSession session = request.getSession();
                    session.setAttribute("googleacc", "true");
                }
            request.setAttribute("username", username);
            request.setAttribute("mail", mail);
            request.setAttribute("fullname", fullname);
            request.setAttribute("birthday", dob);
            request.setAttribute("gender", sex);
            request.setAttribute("phone", phone);
            request.setAttribute("workplace", workplace);
            request.setAttribute("jobname", jobname);
            request.setAttribute("status", status);
            } catch (Exception ex) {
                Logger.getLogger(HomeController.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/view/userinfor.jsp");
                dispatcher.forward(request, response);
        }
        }
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
