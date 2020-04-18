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
@WebServlet(name = "ChangeInforController", urlPatterns = {"/changeinfo"})
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
        HttpSession session = request.getSession();
        String username = "";
        String fullname = "None";
        String dob = "";
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
        }
        if (username.equals("")) {
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Account was logged out');");
            out.println("</script>");
            response.setHeader("Refresh", "1;url=/AVS/HomeController");
        } else if (username.equals("anon")) {
            response.sendRedirect("/AVS/inputusername");
        } else {
            session.setAttribute("username", username);
            try {
                UserModel userDao = new UserModel();
                User user = userDao.getUserByUsername(username);
                if (user.getFullname().length() > 0) {
                    fullname = user.getFullname();
                }
                dob = user.getDob();
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
                request.setAttribute("birthday", dob);
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
        String userid = "";
        String username = "";
        if (request.getCookies() != null) {
            Cookie cookie[] = request.getCookies();
            int cookienum = 0;
            while (cookienum < cookie.length) {
                if (cookie[cookienum].getName().equals("userid")) {
                    userid = cookie[cookienum].getValue();
                }
                if (cookie[cookienum].getName().equals("username")) {
                    username = cookie[cookienum].getValue();
                }
                cookienum++;
            }
        }
        if (username.equals("anon")) {
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Another Account was logged in');");
            out.println("</script>");
            response.setHeader("Refresh", "1;url=/AVS/inputusername");
        } else {
            HttpSession session = request.getSession();
            String currentuser = (String) session.getAttribute("username");
            if (currentuser.equals(username)) {
                String dob = request.getParameter("birthday");
                String phone = request.getParameter("phone");
                String workplace = request.getParameter("workplace");
                String fullname = request.getParameter("fullname");
                int job = Integer.parseInt(request.getParameter("job"));
                int gender = Integer.parseInt(request.getParameter("gender"));
                int id = 0;

                AuthenticateManagement authenticateManagement = new AuthenticateManagement();
                int success = 1;
                if (!phone.equals("")) {
                    if (phone.length() != 10) {
                        session.setAttribute("errorPhone", "Phone must be 10 digits");
                        success = 0;
                    } else if (phone.charAt(0) != '0') {
                        session.setAttribute("errorPhone", "Phone must start with 0");
                        success = 0;
                    }

                }
                if (success == 0) {
//            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/jsp/changeinfor.jsp");
//            dispatcher.forward(request, response);
                    response.sendRedirect("/AVS/changeinfo");
                } else if (success == 1) {

                    int agenumber = 0;
                    int useridnum = Integer.parseInt(userid);
                    try {
                        UserModel usermod = new UserModel();
                        usermod.UpdateUser(useridnum, fullname, dob, job, workplace, gender, phone);
                        response.sendRedirect("/AVS/userinfo");

                    } catch (Exception ex) {
                        Logger.getLogger(SignupController.class.getName()).log(Level.SEVERE, null, ex);
                    }

                }
            } else {
                PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Account was logged out');");
                out.println("</script>");
                response.setHeader("Refresh", "1;url=/AVS/HomeController");
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
