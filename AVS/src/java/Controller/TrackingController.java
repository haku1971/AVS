/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Asus
 */
@WebServlet(name = "TrackingController", urlPatterns = {"/TrackingController"})
public class TrackingController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        try {
            int algoid = Integer.parseInt(request.getParameter("algoid"));
            String ipuser = request.getParameter("ipuser");
            String dateaccess = request.getParameter("dateaccess");
            int totaltime = Integer.parseInt(request.getParameter("totaltime"));
            Date date1 = new SimpleDateFormat("yyyy/MM/dd  HH:mm:ss").parse(dateaccess);
            //   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd  HH:mm:ss");         
            System.out.println("algoid" + algoid + " ipuser: " + ipuser + " time:" + date1 + "totaltime" + totaltime);
            //commentmodel.deleteLikeComment(commentid, userid);
        } catch (Exception ex) {
            System.out.println("hihi");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}