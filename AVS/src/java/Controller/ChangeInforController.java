/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Entity.Jobs;
import Entity.User;
import Model.AuthenticateManagement;
import Model.JobsModel;
import Model.UserModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "ChangeInforController", urlPatterns = {"/ChangeInforController"})
public class ChangeInforController extends HttpServlet {

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
        String fullname = "None";
        String age = "";
        String sex = "None";
        String phone = "";
        String workplace = "None";
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
            if (agecookie == 0) {
                username = "";
            }
            try {
                UserModel userDao = new UserModel();
                User user = userDao.getUserByUsername(username);
                if (user.getFullname().length() > 0) {
                    fullname = user.getFullname();
                }
                if (user.getAge() != 0) {
                    age = Integer.toString(user.getAge());
                }

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

                JobsModel jobdao = new JobsModel();
                ArrayList<Jobs> jobs = jobdao.getJobs();
                for (int i = 0; i < jobs.size(); i++) {
                    if (jobid == jobs.get(i).getJobid()) {
                        request.setAttribute(Integer.toString(jobid), "selected");
                    } else {
                        request.setAttribute(Integer.toString(jobs.get(i).getJobid()), "");
                    }
                }

                request.setAttribute("fullname", fullname);
                request.setAttribute("age", age);
                request.setAttribute("sex", sex);
                request.setAttribute("phone", phone);
                request.setAttribute("workplace", workplace);
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/changeinfor.jsp");
                dispatcher.forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(HomeController.class.getName()).log(Level.SEVERE, null, ex);
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
        String age = request.getParameter("age");
        String phone = request.getParameter("phone");
        String workplace = request.getParameter("workplace");
        String fullname = request.getParameter("fullname");
        int job = Integer.parseInt(request.getParameter("job"));
        int gender = Integer.parseInt(request.getParameter("gender"));
        int id = 0;
        HttpSession session = request.getSession();
        AuthenticateManagement authenticateManagement = new AuthenticateManagement();
        AuthenticateManagement.CheckResult ageresult = authenticateManagement.checkNumber(age);
        AuthenticateManagement.CheckResult phoneresult = authenticateManagement.checkNumber(phone);
        int success = 1;
        if (ageresult == AuthenticateManagement.CheckResult.NOT_NUMBER && !age.equals("")) {
//            request.setAttribute("errorAge", "Age must be a number");
            session.setAttribute("errorAge", "Age must be a number");
            success = 0;
        }
        if (phoneresult == AuthenticateManagement.CheckResult.NOT_NUMBER && !phone.equals("")) {
//            request.setAttribute("errorPhone", "Phone must be numbers ");
            session.setAttribute("errorPhone", "Phone must be numbers ");
            success = 0;
        }
        if (success == 0) {
//            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/changeinfor.jsp");
//            dispatcher.forward(request, response);
            response.sendRedirect("/AVS/ChangeInforController");
        } else if (success == 1) {
            String userid = "";
            if (request.getCookies() != null) {
                Cookie cookie[] = request.getCookies();
                int cookienum = 0;
                while (cookienum < cookie.length) {
                    if (cookie[cookienum].getName().equals("userid")) {
                        userid = cookie[cookienum].getValue();
                    }

                    cookienum++;
                }
                int agenumber = 0;
                int useridnum = Integer.parseInt(userid);
                try {
                    UserModel usermod = new UserModel();
                    if (!age.equals("")) {
                        agenumber = Integer.parseInt(age);
                    }
                    usermod.UpdateUser(useridnum, fullname, agenumber, job, workplace, gender, phone);
                    response.sendRedirect("/AVS/UserinforController");

                } catch (Exception ex) {
                    Logger.getLogger(SignupController.class.getName()).log(Level.SEVERE, null, ex);
                }

            }
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
